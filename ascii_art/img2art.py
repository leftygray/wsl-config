#!/usr/bin/env python3
"""Convert an image to ASCII art in onefetch languages.yaml format."""
import sys, argparse
from PIL import Image

# Standard (non-bright) ANSI colors -> representative RGB, with index name.
ANSI = {
    "black":   (0, 0, 0),
    "red":     (194, 54, 33),
    "green":   (37, 188, 36),
    "yellow":  (173, 153, 50),
    "blue":    (73, 46, 225),
    "magenta": (211, 56, 211),
    "cyan":    (51, 187, 200),
    "white":   (203, 204, 205),
}

def nearest_ansi(rgb):
    r, g, b = rgb
    best, bestd = None, 1e18
    for name, (cr, cg, cb) in ANSI.items():
        d = (r-cr)**2 + (g-cg)**2 + (b-cb)**2
        if d < bestd:
            bestd, best = d, name
    return best

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("image")
    ap.add_argument("--width", type=int, default=48)
    ap.add_argument("--char", default="#", help="fill character for the art")
    ap.add_argument("--bg-thresh", type=int, default=235,
                    help="pixels brighter than this (and near-gray) are background")
    ap.add_argument("--dark-thresh", type=int, default=150,
                    help="cool pixels darker than this average are treated as 'dark'")
    ap.add_argument("--dark-share", type=float, default=0.30,
                    help="fraction of a cell that must be dark to mark the cell dark")
    ap.add_argument("--dark-as", default="blue",
                    help="ANSI color used for dark regions (blue reads on a black bg; "
                         "use 'black' for a light terminal)")
    ap.add_argument("--dark-char", default=None,
                    help="optional distinct fill char for dark regions (e.g. ':')")
    ap.add_argument("--name", default="Logo")
    ap.add_argument("--plain", action="store_true",
                    help="emit plain text instead of a yaml entry")
    args = ap.parse_args()

    im = Image.open(args.image).convert("RGBA")
    W, H = im.size
    px = im.load()
    # characters are ~2x taller than wide -> compress rows
    rows = max(1, round(args.width * (H / W) * 0.5))

    def classify_pixel(r, g, b, a):
        bright = (r + g + b) / 3
        sat = max(r, g, b) - min(r, g, b)
        if a < 40 or (bright >= args.bg_thresh and sat < 24):
            return "bg"
        if bright < args.dark_thresh and b >= r:
            return "dark"
        return "fg"

    # Classify each output cell from the BLOCK of source pixels it covers,
    # so thin dark features survive instead of being averaged away.
    grid = []
    used = []  # preserve first-seen order of colors actually used
    for cy in range(rows):
        sy0 = cy * H // rows
        sy1 = max(sy0 + 1, (cy + 1) * H // rows)
        line = []
        for cx in range(args.width):
            sx0 = cx * W // args.width
            sx1 = max(sx0 + 1, (cx + 1) * W // args.width)
            dark = 0
            fg = 0
            rs = gs = bs = 0
            for yy in range(sy0, sy1):
                for xx in range(sx0, sx1):
                    r, g, b, a = px[xx, yy]
                    kind = classify_pixel(r, g, b, a)
                    if kind == "dark":
                        dark += 1
                    elif kind == "fg":
                        fg += 1
                        rs += r; gs += g; bs += b
            total = dark + fg
            if total == 0:
                line.append(None)
            elif dark / total >= args.dark_share:
                name = args.dark_as
                if name not in used: used.append(name)
                line.append(name)
            else:
                name = nearest_ansi((rs // fg, gs // fg, bs // fg))
                if name not in used: used.append(name)
                line.append(name)
        grid.append(line)

    idx = {name: i for i, name in enumerate(used)}

    # Build colored lines with {N} placeholders, runs collapsed
    out_lines = []
    for row in grid:
        s, cur = [], None
        for cell in row:
            if cell is None:
                s.append(" ")
                cur = None
            else:
                if cell != cur:
                    s.append("{%d}" % idx[cell])
                    cur = cell
                if args.dark_char and cell == args.dark_as:
                    s.append(args.dark_char)
                else:
                    s.append(args.char)
        out_lines.append("".join(s).rstrip())

    # trim fully-blank top/bottom lines
    while out_lines and out_lines[0].strip() == "": out_lines.pop(0)
    while out_lines and out_lines[-1].strip() == "": out_lines.pop()

    if args.plain:
        for l in out_lines:
            import re
            print(re.sub(r"\{\d\}", "", l))
        return

    # onefetch yaml entry
    print("%s:" % args.name)
    print("  type: programming")
    print("  ascii: |")
    for l in out_lines:
        print("    " + l)
    print("  colors:")
    print("    ansi:")
    for name in used:
        print("      - " + name)
    print('    chip: "#c9a227"')

if __name__ == "__main__":
    main()

<!--
Written by: Claude (Claude Opus 5.5), 24/11/2026; revised 25/11/2026 (several times)
Validated by: Richard T. Gray (leftygray)
-->

# Modelling project template

This file describes the standard folder and file structure for a modelling project.
When you set up a new project, or work inside an existing one, follow this structure.
If you think a project needs a different structure, ask before you change it.

## 1. Two layouts

There are two versions of the layout.

- **Multi-project layout.** A main folder holds shared code, data and documents. Individual
  analyses sit in `projects/`. Each project has the same internal structure as the main folder,
  plus an `output/` folder.
- **Single-project layout.** If there is only one project, drop the `projects/` level. The
  project *becomes* the main folder, so `output/` and the numbered scripts sit at the top level.

If you're not sure which layout a project uses, check for a `projects/` folder. If it isn't
clear which one a new project needs, ask.

## 2. Folder tree (multi-project layout)

```text
MainFolder/
|-- .git/
|-- admin/                      # Admin for the overall project (ignored by Git)
|-- code/                       # Code shared by all projects; self-contained, package-ready
|-- data/                       # Data shared by all projects (contents ignored; .gitkeep kept)
|   |-- .gitkeep
|-- docs/                       # Papers, manuscripts, reports, presentations (ignored)
|-- misc/                       # General information, references (ignored)
|-- projects/
|   |-- templates/              # Template files used to set up a new project
|   |-- project1/               # One folder per project, with a descriptive name
|   |   |-- admin/
|   |   |-- code/               # Code specific to this project
|   |   |-- data/               # Data specific to this project
|   |   |   |-- .gitkeep
|   |   |   |-- project_input.csv
|   |   |   |-- project_data.csv
|   |   |   |-- project_parameters.csv  # Parameter values with sources (see Section 6)
|   |   |-- docs/
|   |   |-- misc/
|   |   |-- output/
|   |   |   |-- results/        # Output data (contents ignored; .gitkeep kept)
|   |   |   |   |-- .gitkeep
|   |   |   |-- figures/        # Output figures (contents ignored; .gitkeep kept)
|   |   |       |-- .gitkeep
|   |   |-- 0-ProjectScript.R   # Numbered main scripts, run in order
|   |   |-- 1-ProjectScript.R
|   |   |-- README.md
|   |   |-- project_notes.md
|   |   |-- project_document.docx
|   |   |-- project_materials.pptx
|   |-- project2/
|       |-- ...
|-- 0-SetUpProject.Rmd          # Overall scripts, e.g. to set up a new project
|-- 1-OverallScript.Rmd
|-- .gitattributes
|-- .gitignore
|-- LICENSE                     # MIT by default
|-- README.md                   # Overall project README
|-- modelling_project_template.md  # This file
|-- overall_notes.md
|-- overall_document.docx
|-- overall_materials.pptx
```

## 3. Folders

| Folder | Purpose | Git |
|---|---|---|
| `admin/` | Anything administrative: contracts, ethics, funding, correspondence. For a small project, this material can go in `docs/` or `misc/` instead. | Ignored |
| `code/` | Functions and scripts reused across the project. Keep it self-contained: functions only, no hard-coded paths or project-specific settings. That way it could later become a package. | Tracked |
| `data/` | Input data (spreadsheets and data files) and key data reports. | Contents ignored by default; `.gitkeep` tracked. Specific files can be un-ignored later. |
| `docs/` | Papers and manuscripts, reports, presentations. | Ignored |
| `misc/` | Useful background files, general information, references. | Ignored |
| `projects/` | One subfolder per project (multi-project layout only). | Tracked, subject to the rules above |
| `projects/templates/` | Template files copied into each new project. | Tracked |
| `output/` | Project outputs: `results/` for data, `figures/` for plots. It exists only at project level, or at the top level in the single-project layout. | Contents ignored by default; `.gitkeep` files tracked. Specific outputs can be un-ignored. |

Code at two levels:

- **Main `code/`**: generic code used by more than one project, such as model functions,
  fitting routines and plotting helpers.
- **Project `code/`**: code used by only that project.

If project code becomes useful elsewhere, suggest moving it to the main `code/` folder. Don't
move it without approval.

## 4. Key files

These files exist at two levels. The main folder uses the `overall_` prefix and each project
uses the `project_` prefix.

| File | Purpose | Git |
|---|---|---|
| `README.md` | Description for GitHub: what the project is, how to run it, folder overview. | Tracked |
| `*_notes.md` | Working notes and information, added quickly as the project progresses. | Ignored |
| `*_document.docx` | Formal write-up: methods, parameter tables with sources, assumptions. Write it so that text can be copied into manuscripts. | Ignored |
| `*_materials.pptx` | Sketchbook: screenshots of data and key information, each with its reference. | Ignored |
| `LICENSE` | Licence for the code (main folder only). Use MIT unless told otherwise. | Tracked |
| `modelling_project_template.md` | This file: the structure and rules for the project (main folder only). | Tracked |
| `.gitignore`, `.gitattributes` | Git configuration (main folder only). | Tracked |

Evernote: if the project uses Evernote work documents, put shortcut links to the relevant
notes in whichever folders they relate to. This is discretionary. Don't create Evernote
shortcuts unless asked.

## 5. Scripts

- Main scripts sit in the project folder, or in the main folder for overall tasks such as
  setting up a new project.
- Name each script with a numeric prefix giving the run order, then a dash, then a
  BigCamelCase name: `0-SetUpData.R`, `1-FitModel.R`, `2-ExampleScript.Rmd`.
  R scripts (`.R`) and R Markdown (`.Rmd`) are both fine.
- Main scripts run the analysis by calling functions in `code/`. Keep reusable logic in
  `code/`, not in the main scripts.
- Scripts read inputs from `data/` and write results to `output/results/` and figures to
  `output/figures/`. Any file in `output/` should be reproducible by re-running the scripts.

## 6. Parameter files

- Store model parameters in a parameter file (for example `data/project_parameters.csv`),
  not hard-coded in scripts or functions.
- Every parameter file must record where each value comes from. As a minimum, include
  columns for: parameter name, value, units, uncertainty (range, interval or distribution),
  source (full reference with DOI or link, plus the table, figure or page), and notes
  (assumptions, conversions or calculations used to derive the value).
- If a value is assumed, calibrated or derived rather than taken directly from a source, say
  so in the source or notes column. Never leave the source blank.
- Keep the parameter table in `*_document.docx` consistent with the parameter file.
- `data/` is ignored by Git by default. Consider un-ignoring parameter files so that results
  can be traced from the repository alone.

## 7. Git set-up

- Initialise the Git repository in the main folder when version control is needed. There is
  one repository per main folder, not one per project.
- Add `.gitignore`, `.gitattributes` and `LICENSE` to the main folder, as described below.
- Empty folders that need to stay in the repository contain a `.gitkeep` file.

### `.gitattributes`

Check that the main folder contains the user's modelling `.gitattributes`. It starts with a
"Line endings" section and includes the rule `*.csv text eol=crlf`. If it's missing, ask
the user to copy it in, and wait until they have. Don't create a `.gitattributes` from
scratch, and don't edit it for individual projects without approval.

### `.gitignore`

Build the `.gitignore` in two steps:

1. Check that the main folder contains the user's default `.gitignore`. It starts with a
   "Compiled source" section and ends with a "Local files to ignore" section. If it's
   missing, ask the user to copy it in from their Git defaults repository, and wait until
   they have. Don't create a `.gitignore` from scratch.
2. Append the block below to the end of it, under the "Local files to ignore" section.
   Before appending, check that the first line of the block is not already in the file. If
   it is, don't append it again.

The patterns use `**/` so the same rules apply in the main folder and in every project.
R history and system files (`.Rhistory`, `.DS_Store`, `Thumbs.db`) are already in the
default file, so they aren't repeated here.

```gitignore
# ---- Modelling project template rules ----

# Folders ignored entirely (main folder and all projects)
**/admin/
**/docs/
**/misc/

# Data: ignore contents, keep the folder
**/data/*
!**/data/.gitkeep
# To track a specific data file, un-ignore it, e.g.:
# !projects/project1/data/project_parameters.csv

# Outputs: ignore contents, keep the folders
**/output/results/*
!**/output/results/.gitkeep
**/output/figures/*
!**/output/figures/.gitkeep
# To track a specific output, un-ignore it, e.g.:
# !projects/project1/output/figures/figure1.png

# Working files
*_notes.md
*_document.docx
*_materials.pptx

# Keep project templates tracked
!projects/templates/**

# Other R and Office files
*.RData
.Rproj.user/
~$*
```

Git cannot re-include a file if its parent folder is ignored. That's why `data/` and
`output/` ignore their *contents* (`data/*`) and not the folder itself (`data/`). This lets
`.gitkeep` and specific files be un-ignored.

## 8. Setting up a new project

**Before you start:**

- Confirm which layout the project uses (Section 1). If it isn't clear, ask.
- Check what already exists. Create only what is missing. Never overwrite, rename or delete
  existing files or folders.
- The user has a `setup-project` script that creates the folders and files below. It doesn't
  initialise Git, create scripts or update the main `README.md`. It is safe to re-run,
  because it only creates what is missing. Suggest it to the user before doing the steps by
  hand:
  - `setup-project single`: single-project layout, in the current folder.
  - `setup-project multi`: multi-project main folder, in the current folder.
  - `setup-project add <ProjectName>`: a new project in `projects/`, run from the main folder.
- When you finish, report what you created and what already existed.

**Main folder (both layouts):**

1. Create `admin/`, `code/`, `data/` (with `.gitkeep`), `docs/` and `misc/`.
2. Create the key files (Section 4). Use the `project_` prefix in a single-project layout and
   the `overall_` prefix in a multi-project main folder.
3. Single-project layout: create `output/results/` and `output/figures/`, each with a
   `.gitkeep`. Multi-project layout: create `projects/templates/`.
4. Check that this file, `.gitattributes` and `.gitignore` are present, and append the
   modelling rules to `.gitignore` (Section 7). Add an MIT `LICENSE` if there isn't one.
5. Initialise Git when needed, with the user's approval.

**New project in a multi-project layout:**

1. Create `projects/<ProjectName>/` with `admin/`, `code/`, `data/`, `docs/`, `misc/`,
   `output/results/` and `output/figures/`.
2. Add `.gitkeep` to `data/`, `output/results/` and `output/figures/`.
3. Copy the template files from `projects/templates/` (`README.md`, `project_notes.md`,
   `project_document.docx`, `project_materials.pptx`). If a template is missing, create an
   empty file with that name.
4. Create `0-<ScriptName>.R` (or `.Rmd`) as the first script.
5. Add the project to the main `README.md`.

## 9. Rules for AI assistants working in this structure

- Put new files where this template says they belong. If the right place isn't clear, ask.
- Treat files in `data/` as read-only inputs. Don't modify or overwrite them. Write derived
  data to `output/results/`.
- Don't create new top-level folders, or rename existing files or folders, without approval.
- Put reusable functions in `code/` (with Roxygen documentation) and keep main scripts as
  thin as possible: they should mostly call functions.
- Use relative paths from the project folder. Never use absolute paths tied to one computer.
- Don't add ignored working files (`*_notes.md`, `.docx`, `.pptx`) to Git, and don't change
  `.gitignore` without approval.
- Every parameter value must trace to a source, calculation or stated assumption (Section 6).
  Never invent or guess a value without flagging it clearly.
- When you set up a project, follow Section 8 and report what you created.

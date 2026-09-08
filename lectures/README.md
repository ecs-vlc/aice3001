# lectures_dev — trial of a YAML-driven, standalone-file layout

A sibling of `lectures/` for trying out a different organisation. **Nothing in
`lectures/` has been changed**; delete this folder and you are back where you
started.

## What is different

| | `lectures/` (current) | `lectures_dev/` (this) |
|---|---|---|
| list of lectures | `\lecture{...}` lines in `lectures.tex`, commented out to disable | three plain lists in `lectures.yaml` |
| a lecture `.tex` | a fragment, `\include`d into `lectures.tex` | a standalone document, compiles on its own |
| building one lecture | `echo calculus \| pdflatex lectures` (uses `\typein` + `\includeonly`) | `pdflatex -shell-escape calculus` |
| scripts find lectures by | grepping `lectures.tex` with a regex | `import lecture_list` |

There is no `lectures.tex` here. It is not needed: the preamble that used to
live in it is in `preamble.tex`, which every lecture inputs on its first line.

## Files

* `lectures.yaml` — **the list of lectures**. Single source of truth. Three
  plain lists of ids; move an id between them to change what gets built:

  | list | meaning |
  |---|---|
  | `lectures` | in the course this year — built and published, in course order |
  | `draft_lectures` | source exists, not scheduled this year |
  | `old_lectures` | retired or never written; ignored by every script |
* `preamble.tex` — `\documentclass`, `\input{macros_gen}`, graphics paths and the
  `\lesson` definition. Previously the top of `lectures.tex`.
* `lecture_list.py` — reads the YAML. Every script goes through it.
  `load()` returns the `lectures` list; `load(section="draft_lectures")` or
  `load(section="all")` for the others. Run it directly
  (`python lecture_list.py`) to list everything and check for entries whose
  `.tex` is missing, or `.tex` files not in the YAML. Missing files in
  `old_lectures` are not warned about.

Scripts, all reading `lectures.yaml`:

* `build` — replaces `update`. Builds the four PDFs per lecture into
  `site/lecture_pdf/` and concatenates `lectures_8.pdf`.
  `./build` (the `lectures` list), `./build calculus sgd` (any section),
  `./build --all`, `./build --force`
* `go` — replaces `go`. Menu of lectures, builds if stale, opens in `papers`.
* `lecturehtml` — replaces `lecturehtml`. Writes `site/lectures.html`.
* `list_lectures.py` — prints the `lectures:` block for `courses.yaml`.
* `combineNotes.py` — concatenates `*-subsidiary.pdf` into `notes.pdf`.

## Notes

* **Run these with `python`, not `python3`.** On this machine `python3` is
  `/usr/bin/python3`, which has no `yaml`; `python` is miniconda, which does.
  This is why the old `update` ended with `python lecturehtml`.
* **Figures are not duplicated.** `preamble.tex` adds `../lectures/figures/` to
  `\graphicspath`, so both folders share one copy.
* **`site_dir` in `lectures.yaml`** controls where output goes. It is `../site`,
  the live site — the same files `lectures/update` writes. Point it at
  `../site_dev` if you want the trial kept separate.
* Titles and keywords are read from `\lesson{}` and `\keywords{}` in the `.tex`,
  so there is one place to edit them and the YAML stays easy to hand-edit.

## Status: 31 of 34 lectures compile standalone

Three fail, all for reasons that are **not** caused by this reorganisation —
each fails the same way under the old `lectures.tex` build:

* `taylorExpansion` — `\ii` is undefined (line 150). Defined in no macro file
  here or in comp6208. This one is in the `lectures` list, so it is worth fixing.
* `entropy` — `maxent` image missing. A copy exists at
  `courses/probability/book/figures/maxent.pdf`, which is not on `\graphicspath`.
* `graphicalModels` — `\includegraphics{figures/acb.pdf}` (line 208). The file
  exists at `comp6208/github/lectures/figures/acb.pdf`, but the hard-coded
  `figures/` prefix defeats `\graphicspath`.

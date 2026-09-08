r"""Read the lecture list from lectures.yaml.

This replaces the old approach of grepping \lecture{...} lines out of
lectures.tex.  Every script that needs to know which lectures exist, and in
what order, goes through here.

lectures.yaml holds three plain lists of ids -- `lectures`, `draft_lectures`
and `old_lectures`.  Move an id between them to change what gets built.

Titles and keywords live in the .tex files (\lesson{} and \keywords{}), so
there is only one place to edit them.
"""

import glob
import os
import re

import yaml

YAML_FILE = "lectures.yaml"
SECTIONS = ("lectures", "draft_lectures", "old_lectures")
SUPPORT = {"macros_gen", "supp-pdf", "preamble", "extra"}


class Lecture:
    def __init__(self, lecture_id, section="lectures", directory="."):
        self.id = lecture_id
        self.section = section
        self.tex = os.path.join(directory, f"{lecture_id}.tex")
        self._title = None
        self._keywords = None

    @property
    def exists(self):
        return os.path.isfile(self.tex)

    def _scan_tex(self):
        """Pull \\lesson{} and \\keywords{} out of the first few lines."""
        title, keywords = "", ""
        if not self.exists:
            return title, keywords
        with open(self.tex) as f:
            for cnt, line in enumerate(f):
                m = re.search(r"\\lesson\{(.+?)\}", line)
                if m:
                    title = m.group(1)
                m = re.search(r"\\keywords\{(.+?)\}", line)
                if m:
                    keywords = m.group(1)
                    break
                if cnt > 15:
                    break
        return title, keywords

    @property
    def title(self):
        if self._title is None:
            self._title = self._scan_tex()[0] or self.id
        return self._title

    @property
    def keywords(self):
        if self._keywords is None:
            self._keywords = self._scan_tex()[1]
        return self._keywords

    def __repr__(self):
        return f"<Lecture {self.id} ({self.section})>"


def config(directory="."):
    with open(os.path.join(directory, YAML_FILE)) as f:
        return yaml.safe_load(f)


def load(directory=".", section="lectures"):
    """Return Lecture objects from one section of lectures.yaml.

    section: "lectures" (default), "draft_lectures", "old_lectures", or "all".
    """
    data = config(directory)
    wanted = SECTIONS if section == "all" else (section,)
    out = []
    for name in wanted:
        for lecture_id in data.get(name) or []:
            out.append(Lecture(lecture_id, name, directory))
    return out


def find(lecture_id, directory="."):
    """Look an id up in any section; None if it is not listed."""
    for lec in load(directory, section="all"):
        if lec.id == lecture_id:
            return lec
    return None


def check(directory="."):
    """Warn about listed lectures with no .tex, and .tex files not listed.

    old_lectures are exempt -- they are retired, so a missing file is expected.
    """
    problems = []
    listed = set()
    for lec in load(directory, section="all"):
        listed.add(lec.id)
        if lec.section != "old_lectures" and not lec.exists:
            problems.append(f"{lec.id}: in '{lec.section}' but {lec.id}.tex is missing")
    for path in sorted(glob.glob(os.path.join(directory, "*.tex"))):
        stem = os.path.splitext(os.path.basename(path))[0]
        if stem not in listed and stem not in SUPPORT:
            problems.append(f"{stem}.tex exists but is not listed in {YAML_FILE}")
    return problems


if __name__ == "__main__":
    for lec in load(section="all"):
        mark = " " if lec.exists else "?"
        print(f"{mark} {lec.section:15} {lec.id:24} {lec.title}")
    for p in check():
        print(f"WARNING: {p}")

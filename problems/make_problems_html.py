#!/usr/bin/env python
r"""Generate the problem-sheet web pages from problems.yaml.

Two pages are written into <site_dir>:

  problems_page   questions only -- this is the one students get
  answers_page    questions *and* worked answers -- for demonstrators

The answers page has a random filename and is linked from nowhere. That makes
it unlisted, not secure: anyone with the URL can read it. Keep the filename
stable in problems.yaml or the demonstrators' link stops working.

Each sheet gets an <a id="..."> anchor so lectures/make_timetable.py can link
a tutorial slot straight at the right sheet.

    ./make_problems_html.py            write both pages
    ./make_problems_html.py --list     show what would be published
"""

import datetime
import os
import shutil
import sys

import yaml

PDF_DIR = "problem_pdf"

CSS = """
body { font-family: system-ui, sans-serif; margin: 2em; max-width: 55em; }
h1 { margin-bottom: 0.2em; }
p.sub { color: #555; margin-top: 0; }
ol { line-height: 1.6; }
li { margin-bottom: 0.9em; }
.keywords { color: #555; font-style: italic; }
.missing { color: #999; }
.note { background: #fff4d6; border: 1px solid #e6cf8b;
        padding: 0.8em 1em; border-radius: 4px; }
"""


def config():
    with open("problems.yaml") as f:
        return yaml.safe_load(f)


BUILD_DIR = "_build"
DATES_FILE = "tutorial_dates.yaml"


def released(cfg):
    """Names whose answers may appear on the public page.

    Default is `auto`: a sheet is released once its tutorial has been taught,
    using the dates lectures/make_timetable.py derives from term_start. That
    makes it self-resetting -- next year's term_start pushes every tutorial
    into the future and nothing is public until it has been taught again.

    The date is read when the site is *built*, not when it is viewed. This is
    a static site, so answers appear at the next rebuild after the tutorial,
    not at midnight on the day.
    """
    mode = cfg.get("release_answers", "auto")
    names = [s["name"] for s in cfg["sheets"]]
    if mode == "all":
        out = set(names)
    elif mode == "none":
        out = set()
    else:
        dates = {}
        if os.path.exists(DATES_FILE):
            with open(DATES_FILE) as f:
                dates = yaml.safe_load(f) or {}
        delay = datetime.timedelta(days=cfg.get("release_delay_days", 0))
        today = datetime.date.today()
        # strictly after the tutorial day, so a rebuild on the morning of a
        # tutorial does not publish the answers before it has happened
        out = {n for n, d in dates.items() if n in names and today > d + delay}

    for sheet in cfg["sheets"]:                       # per-sheet override
        if "release" in sheet:
            (out.add if sheet["release"] else out.discard)(sheet["name"])
    return out


def answers_name(sheet_name, cfg, is_released):
    """Published filename for an answers PDF.

    Released answers get the obvious name. Unreleased ones get a token in the
    filename: the demonstrators' page can link them, but they cannot be found
    by guessing `<name>_answers.pdf` from the question link, which is exactly
    how they were reachable before.
    """
    if is_released:
        return f"{sheet_name}_answers.pdf"
    token = cfg.get("answers_token", "unlisted")
    return f"{sheet_name}_answers-{token}.pdf"


def sheet_files(sheet):
    """./build compiles into _build/ and copies to the site; look there."""
    n = sheet["name"]
    return os.path.join(BUILD_DIR, f"{n}.pdf"), os.path.join(BUILD_DIR, f"{n}_answers.pdf")


def publish_pdfs(cfg, open_answers):
    """Copy the built PDFs into <site_dir>/problem_pdf/. Returns what exists.

    Answer PDFs are published under whichever name their release state calls
    for, and the *other* name is deleted -- otherwise un-releasing a sheet
    would leave the old public copy sitting there, and the reset would be a
    reset in name only.
    """
    site = cfg.get("site_dir", "../site")
    dest = os.path.join(site, PDF_DIR)
    os.makedirs(dest, exist_ok=True)
    present = {}
    for sheet in cfg["sheets"]:
        name = sheet["name"]
        q, a = sheet_files(sheet)
        got_q = os.path.exists(q)
        got_a = os.path.exists(a)
        if got_q:
            shutil.copy(q, dest)
        is_open = name in open_answers
        wanted = answers_name(name, cfg, is_open)
        stale = answers_name(name, cfg, not is_open)
        if got_a:
            shutil.copy(a, os.path.join(dest, wanted))
        obsolete = os.path.join(dest, stale)
        if os.path.exists(obsolete):
            os.remove(obsolete)
        present[name] = (got_q, got_a)
    return present


def render(cfg, present, answers, open_answers=frozenset()):
    course = cfg.get("course", {})
    title = "Problem Sheets" + (" (with answers)" if answers else "")
    out = ['<!DOCTYPE html>', '<html lang="en">', "<head>",
           '<meta charset="UTF-8">',
           '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
           '<link rel="stylesheet" href="style.css">',
           f"<title>{title}</title>", "</head>", "<body>",
           f"<header>{title}</header>", '<div class="container">',
           '<p><a href="index.html">&larr; Course home</a></p>',
           f"<p>{course.get('code','')}: {course.get('title','')}</p>"]

    if answers:
        out.append("<p class='note'><b>Demonstrators only.</b> This page "
                   "includes worked answers. It is unlisted, not protected "
                   "&mdash; please do not pass the link to students.</p>")

    out.append("<ol>")
    for sheet in cfg["sheets"]:
        name = sheet["name"]
        got_q, got_a = present.get(name, (False, False))
        label = sheet.get("title", name)
        out.append(f'<li><a id="{name}"></a>')
        if got_q:
            out.append(f'<b><a href="{PDF_DIR}/{name}.pdf">{label}</a></b>')
        else:
            out.append(f'<b class="missing">{label}</b> '
                       '<span class="missing">(not yet available)</span>')
        if sheet.get("keywords"):
            out.append(f'<br><span class="keywords">{sheet["keywords"]}</span>')
        is_open = name in open_answers
        if answers:                                   # demonstrators' page
            if got_a:
                link = answers_name(name, cfg, is_open)
                state = "" if is_open else " (not yet public)"
                out.append(f'<br><a href="{PDF_DIR}/{link}">'
                           f'questions with answers</a>{state}')
            else:
                out.append('<br><span class="missing">answers not built</span>')
        elif is_open and got_a:                       # public page
            out.append(f'<br><a href="{PDF_DIR}/{name}_answers.pdf">'
                       'worked answers</a>')
        out.append("</li>")
    out += ["</ol>", "</div>",
            "<footer>ECS &mdash; "
            f"{course.get('code','')}: {course.get('title','')}</footer>",
            "</body>", "</html>"]
    return "\n".join(out)


def main():
    cfg = config()
    site = cfg.get("site_dir", "../site")

    if "--list" in sys.argv:
        open_answers = released(cfg)
        for sheet in cfg["sheets"]:
            q, a = sheet_files(sheet)
            state = "PUBLIC" if sheet["name"] in open_answers else "withheld"
            print(f"  week {sheet.get('week','?'):>2}  {sheet['name']:<16}"
                  f" questions={os.path.exists(q)}  answers={os.path.exists(a)}"
                  f"  {state}")
        return

    open_answers = released(cfg)
    present = publish_pdfs(cfg, open_answers)

    pages = [(cfg.get("problems_page", "problems.html"), False),
             (cfg.get("answers_page"), True)]
    for filename, answers in pages:
        if not filename:
            continue
        path = os.path.join(site, filename)
        with open(path, "w") as f:
            f.write(render(cfg, present, answers, open_answers))
        print(f"wrote {path}")

    mode = cfg.get("release_answers", "auto")
    if open_answers:
        print(f"answers public ({mode}): " + ", ".join(sorted(open_answers)))
    else:
        print(f"answers public ({mode}): none")

    built = sum(1 for q, _ in present.values() if q)
    print(f"{built}/{len(present)} sheets have a questions PDF")
    missing = [n for n, (q, _) in present.items() if not q]
    if missing:
        print("not yet built: " + ", ".join(missing) + "   (run ./build)")


if __name__ == "__main__":
    main()

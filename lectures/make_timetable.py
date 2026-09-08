#!/usr/bin/env python
r"""Build the lecture timetable from lectures.yaml.

Replaces the old make_timetable.py, which read a separate courses.yaml holding
a hand-maintained list of lecture links with "Tutorial" entries interleaved by
hand. Here the lecture list is the `lectures:` list in lectures.yaml, and slots
carry a `type:`, so tutorials and labs are no longer padding in the lecture
list -- they fall out of the slot definitions.

    ./make_timetable.py              write <site_dir>/lecture_timetable.html
    ./make_timetable.py --text       print the schedule as text (no file written)
    ./make_timetable.py -o out.html  write somewhere else

Deliberately self-contained: ~/Documents/python/local/timetable.py is shared
with AICE1005 and comp3212, so it is not imported or modified here.
"""

import argparse
import datetime
import os
import sys
from collections import deque

import lecture_list

try:
    import yaml
except ImportError:                                   # only needed for problems
    yaml = None

DAY_TO_INT = {"Mon": 0, "Tue": 1, "Wed": 2, "Thu": 3, "Fri": 4,
              "Sat": 5, "Sun": 6}


# --------------------------------------------------------------------------
# calendar
# --------------------------------------------------------------------------

def monday_of(d):
    return d - datetime.timedelta(days=d.weekday())


def week_is_break(week_start, breaks):
    """Return the break covering this week, or None.

    A week counts as a break week if any weekday in it falls in the break.
    """
    week_end = week_start + datetime.timedelta(days=4)
    for b in breaks:
        if b["start"] <= week_end and week_start <= b["end"]:
            return b
    return None


def build_weeks(term_start, teaching_weeks, breaks):
    """Weeks from term_start until `teaching_weeks` teaching weeks have run.

    Break weeks are included in the calendar but do not count towards the
    total, so a reading week or Easter pushes the end of term later rather
    than eating a week of teaching.
    """
    weeks = []
    current = monday_of(term_start)
    taught = 0
    guard = 0
    while taught < teaching_weeks:
        guard += 1
        if guard > 60:
            raise RuntimeError("more than 60 weeks generated -- check breaks")
        brk = week_is_break(current, breaks)
        if brk:
            weeks.append({"start": current, "number": None, "break": brk})
        else:
            taught += 1
            weeks.append({"start": current, "number": taught, "break": None})
        current += datetime.timedelta(days=7)
    return weeks


def load_problems(cfg_all):
    """Problem sheets, in order, from problems.yaml.

    Tutorial slots take these consecutively, the same way lecture slots take
    lectures. Returns [] if the file is not configured or not found.
    """
    path = cfg_all.get("problems_yaml")
    if not path or yaml is None or not os.path.exists(path):
        return []
    with open(path) as f:
        data = yaml.safe_load(f) or {}
    return [{"name": s["name"],
             "title": s.get("title", s["name"]),
             "keywords": s.get("keywords", "")}
            for s in data.get("sheets", [])]


# --------------------------------------------------------------------------
# schedule
# --------------------------------------------------------------------------

def build_schedule(weeks, slots, lectures, bank_holidays, startweek=1,
                   problems=None):
    """Fill each slot. Only `lecture` slots consume from the lecture list."""
    queue = deque(lectures)
    problem_queue = deque(problems or [])
    rows = []

    for week in weeks:
        cells = []
        for slot in slots:
            date = week["start"] + datetime.timedelta(days=DAY_TO_INT[slot["day"]])
            kind = slot.get("type", "lecture")

            if week["break"]:
                cells.append({"kind": "break", "text": week["break"].get("name", "")})
            elif date in bank_holidays:
                cells.append({"kind": "bank", "text": "Bank Holiday"})
            elif kind == "lecture":
                if queue:
                    cells.append({"kind": "lecture", "lecture": queue.popleft()})
                else:
                    cells.append({"kind": "empty", "text": ""})
            elif kind == "lab":
                wanted = slot.get("weeks")
                if wanted is None or week["number"] in wanted:
                    cells.append({"kind": "fixed", "text": slot.get("label", "Lab")})
                else:
                    cells.append({"kind": "empty", "text": ""})
            elif kind == "tutorial" and problem_queue:
                cells.append({"kind": "problem",
                              "problem": problem_queue.popleft()})
            else:                                     # tutorial with no sheet left
                cells.append({"kind": "fixed",
                              "text": slot.get("label", kind.capitalize())})
        rows.append({"week": week, "cells": cells})

    return rows, list(queue), list(problem_queue)


# --------------------------------------------------------------------------
# output
# --------------------------------------------------------------------------

CSS = """
body { font-family: system-ui, sans-serif; margin: 2em; }
table.timetable { border-collapse: collapse; }
table.timetable th, table.timetable td {
  border: 1px solid #bbb; padding: 4px 8px; vertical-align: top;
}
table.timetable th { background: #eee; text-align: left; font-weight: 600; }
td.weeknumber { text-align: right; color: #666; }
td.week { white-space: nowrap; color: #444; }
td.break { background: #fde2e2; font-style: italic; }
td.bank-holiday { background: #fde2e2; font-style: italic; }
td.fixed { color: #444; }
"""


def fmt(d):
    return d.strftime("%d %b")


def cell_html(cell, lectures_page, problems_page="problems.html"):
    if cell["kind"] == "lecture":
        lec = cell["lecture"]
        return f'<td><a href="{lectures_page}#{lec.id}">{lec.title}</a></td>'
    if cell["kind"] == "problem":
        p = cell["problem"]
        return (f'<td><a href="{problems_page}#{p["name"]}">'
                f'Tutorial: {p["title"]}</a></td>')
    if cell["kind"] == "break":
        return f'<td class="break">{cell["text"]}</td>'
    if cell["kind"] == "bank":
        return '<td class="bank-holiday">Bank Holiday</td>'
    if cell["kind"] == "fixed":
        return f'<td class="fixed">{cell["text"]}</td>'
    return "<td></td>"


def render_html(cfg, slots, rows, lectures_page, standalone=True,
                problems_page="problems.html"):
    out = []
    if standalone:
        out += ['<!DOCTYPE html>', '<html lang="en">', "<head>",
                '<meta charset="UTF-8">',
                '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
                '<link rel="stylesheet" href="style.css">',
                f"<title>{cfg.get('year','')} timetable</title>", "</head>",
                "<body>", '<div class="container">',
                '<p><a href="index.html">&larr; Course home</a></p>']
    out.append("<table class='timetable'>")
    out.append("<tr><th></th><th>Week</th>" + "".join(
        f"<th>{s['day']} {s['time']}<br><small>{s['location']}</small></th>"
        for s in slots) + "</tr>")

    offset = cfg.get("startweek", 1) - 1
    for row in rows:
        wk = row["week"]
        num = "" if wk["number"] is None else wk["number"] + offset
        out.append("<tr>")
        out.append(f"<td class='weeknumber'>{num}</td>")
        out.append(f"<td class='week'>{fmt(wk['start'])} - "
                   f"{fmt(wk['start'] + datetime.timedelta(days=4))}</td>")
        out += [cell_html(c, lectures_page, problems_page) for c in row["cells"]]
        out.append("</tr>")

    out.append("</table>")
    if standalone:
        out += ["</div>", "</body>", "</html>"]
    return "\n".join(out)


def render_text(cfg, slots, rows):
    lines = []
    head = f"{'Wk':>3}  {'Week':<15}" + "".join(
        f"{s['day']+' '+str(s['time']):<22}" for s in slots)
    lines.append(head)
    lines.append("-" * len(head))
    offset = cfg.get("startweek", 1) - 1
    for row in rows:
        wk = row["week"]
        num = "" if wk["number"] is None else str(wk["number"] + offset)
        cells = []
        for c in row["cells"]:
            if c["kind"] == "lecture":
                cells.append(c["lecture"].title[:20])
            elif c["kind"] == "problem":
                cells.append("PS: " + c["problem"]["title"][:16])
            elif c["kind"] == "empty":
                cells.append("-")
            else:
                cells.append(c["text"][:20])
        lines.append(f"{num:>3}  {fmt(wk['start']):<15}" +
                     "".join(f"{c:<22}" for c in cells))
    return "\n".join(lines)


# --------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(description="Build the lecture timetable.")
    ap.add_argument("-o", "--output", help="output file (default <site_dir>/lecture_timetable.html)")
    ap.add_argument("--text", action="store_true", help="print as text, write nothing")
    args = ap.parse_args()

    cfg_all = lecture_list.config()
    if "timetable" not in cfg_all:
        sys.exit("lectures.yaml has no `timetable:` section")
    cfg = cfg_all["timetable"]
    slots = cfg["slots"]
    lectures = lecture_list.load()

    breaks = cfg.get("breaks") or []
    bank = set(cfg.get("bank_holidays") or [])

    problems = load_problems(cfg_all)
    weeks = build_weeks(cfg["term_start"], cfg["teaching_weeks"], breaks)
    rows, unplaced, unplaced_problems = build_schedule(
        weeks, slots, lectures, bank, cfg.get("startweek", 1), problems)

    if args.text:
        print(render_text(cfg, slots, rows))
    else:
        site = cfg_all.get("site_dir", "../site")
        out = args.output or os.path.join(site, "lecture_timetable.html")
        os.makedirs(os.path.dirname(out) or ".", exist_ok=True)
        with open(out, "w") as f:
            f.write(render_html(cfg, slots, rows, "lectures.html",
                                problems_page=cfg_all.get("problems_page",
                                                          "problems.html")))
        print(f"wrote {out}")

    # report anything that did not fit, and any spare capacity
    n_lecture_slots = sum(1 for r in rows for c in r["cells"]
                          if c["kind"] in ("lecture", "empty"))
    n_placed = sum(1 for r in rows for c in r["cells"] if c["kind"] == "lecture")
    print(f"{n_placed} lectures placed in {n_lecture_slots} lecture slots")
    if unplaced:
        print(f"WARNING: {len(unplaced)} lectures did not fit: "
              + ", ".join(l.id for l in unplaced))
    elif n_lecture_slots > n_placed:
        print(f"note: {n_lecture_slots - n_placed} lecture slots left empty")
    if problems:
        placed = len(problems) - len(unplaced_problems)
        print(f"{placed}/{len(problems)} problem sheets placed in tutorial slots")
        if unplaced_problems:
            print("WARNING: no tutorial slot for: "
                  + ", ".join(p["name"] for p in unplaced_problems))
    for p in lecture_list.check():
        print(f"WARNING: {p}")


if __name__ == "__main__":
    main()

#!/usr/bin/env python
r"""Print the `lectures:` block for courses.yaml, built from lectures.yaml.

Tutorial slots are inserted every `tutorial_every` lectures.  Paste the output
into courses.yaml, or redirect it:  ./list_lectures.py > lectures_block.yaml
"""

import lecture_list


def main():
    cfg = lecture_list.config()
    every = cfg.get("tutorial_every", 4)
    lectures = lecture_list.load()

    print("lectures:")
    for n, lec in enumerate(lectures, 1):
        print(f'  - <a href="lectures.html#{lec.id}">{lec.title}</a>')
        if every and n % every == 0:
            print("  - Tutorial")


if __name__ == "__main__":
    main()

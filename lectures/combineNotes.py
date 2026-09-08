#!/usr/bin/env python
r"""Concatenate the per-lecture subsidiary notes into one notes.pdf.

Same as before, but the lecture order comes from lectures.yaml.
"""

import os

import lecture_list


def main():
    lectures = lecture_list.load()
    parts = [f"./{lec.id}-subsidiary.pdf" for lec in lectures
             if os.path.exists(f"./{lec.id}-subsidiary.pdf")]
    if not parts:
        print("no <lecture>-subsidiary.pdf files found -- nothing to combine")
        return
    os.system("pdfjam --fitpaper true --rotateoversize false "
              f"-o notes.pdf {' '.join(parts)}")
    print(f"combined {len(parts)} notes -> notes.pdf")


if __name__ == "__main__":
    main()

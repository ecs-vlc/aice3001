import csv
import datetime
import numscreen


current = datetime.date.today()

def myengage():
    with open('myengage.csv') as csvfile:
        reader = csv.reader(csvfile, delimiter='\t')
        noCode = True
        for row in  reader:
            date = row[0].split('/')
            dateTime = datetime.date(int(date[2]), int(date[1]), int(date[0]))
            if dateTime>=current:
                print(row[1])
                print(f"{row[0]}: {row[7]}")
								numscreen(row[7])
                noCode = False
                break
    if noCode:
        print("Need to run Jon's script")
        print("https://southampton.seats.cloud/angular/#/lectures/")
    input()

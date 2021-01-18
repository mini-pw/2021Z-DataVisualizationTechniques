import csv
import os
new_rows = []
print(os.getcwd())
r = csv.reader(open('ViewingActivity.csv'))
lines = list(r)
new_lines = []
series_column_number = 2
time_column_number = 1
combined = dict()
for line in lines:
    name = ""
    if ":" in line[series_column_number]:
        name = line[series_column_number].split(":")[0]
    else:
        name = line[series_column_number]
    mapped = [int(x) for x in line[time_column_number].split(":")]
    if name not in combined.keys():
        combined[name] = mapped
    else:
        combined[name][0] += mapped[0]
        combined[name][1] += mapped[1]
        combined[name][2] += mapped[2]
        if combined[name][2] > 60:
            combined[name][1] += 1
            combined[name][2] -= 60
        if combined[name][1] > 60:
            combined[name][0] += 1
            combined[name][1] -= 60

new_lines = [["Username","Vidname","Hours","Minutes","Seconds","Total"]]
user = "Paweł"
for k in combined:
    val = combined[k]
    new_lines.append([user,k,val[0],val[1],val[2],3600*val[0]+60*val[1]+val[2]])
with open("Activity.csv", "w") as newcsv:
    writer = csv.writer(newcsv, quoting=csv.QUOTE_NONNUMERIC,delimiter=",")
    writer.writerows(new_lines)

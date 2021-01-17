import csv
import os
import matplotlib.pyplot as plt

new_rows = []
print(os.getcwd())
r = csv.reader(open('PlaybackRelatedEvents.csv'))
lines = list(r)
time_column_number = 2
bins = 60 * 10  # every ten minutes
binsNumber = 24*6
frequencyTable = [0 for _ in range(binsNumber)]
total = 0
for line in lines[1:]:
    time_all = line[time_column_number].split(" ")[1].split(":")
    time_secs = 3600 * int(time_all[0]) + 60 * int(time_all[1]) + int(time_all[2])
    frequencyTable[time_secs//bins] += 1
    total += 1
fT = [x/total for x in frequencyTable]

# fig = plt.figure()
# ax = fig.add_axes([0,0,1,1])
# x = [i for i in range(binsNumber)]
# ax.bar(x,fT)
# plt.show()

user = "Paweł"
new_lines = [user]
for v in fT:
    new_lines.append(v)
print(new_lines)
with open(f"fileFrequency{user}", "w") as f:
    print(new_lines,file=f)

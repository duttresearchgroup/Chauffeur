import sys
f = open(sys.argv[1],"r")
lines = f.readlines()

data = []
for x in lines:
    if "real" in x:
        data.append(x)

for d in data:
    raw = d.split()[1]
    mins = int(raw.split("m")[0])
    secs = float(raw.split("m")[1][:-1])
    print(mins*60+secs)

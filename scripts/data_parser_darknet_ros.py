import sys
f = open(sys.argv[1],"r")
lines = f.readlines()

data =[]
for line in lines:
    if "ms" in line:
        data.append(line)


for d in data:
    raw = d.split()
    print(raw[3])

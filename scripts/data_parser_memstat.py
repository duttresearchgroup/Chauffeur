import sys
f = open(sys.argv[1],"r")
lines = f.readlines()

for d in lines[2:]:
    raw = d.split()
    print(raw[1]+","+raw[2]+","+raw[3])

import sys
f = open(sys.argv[1],"r")
lines = f.readlines()

for d in lines[2:]:
    raw = d.split()
    print(raw[0]+"\t"+raw[1]+"\t"+raw[2]+"\t"+raw[3])

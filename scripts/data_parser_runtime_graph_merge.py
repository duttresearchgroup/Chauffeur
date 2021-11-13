import sys
import os
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import networkx as nx

if __name__ == "__main__":
    # print(sys.argv[1:])
    
    while(1):
        if len(sys.argv)<2:
            print("Please input more arguments")
            print("Usage python3 data_parser_runtime_graph_merge.py [.txt] [.txt]...")
            sys.exit(0)
        else:
            for i in sys.argv[1:]:
                if os.path.exists(i) and i.endswith(".txt"):
                    continue
                else:
                    print(i + " does not exist or not a txt file")
                    sys.exit(0)
            break


    x = []
    y = []
    lines = []
    fig = plt.figure(sys.argv[1])

    for i in sys.argv[1:]:
        f = open(i, 'r')
        lines = f.readlines()
        for line in lines:
            x.append(float(line.split()[0]))
            y.append(float(line.split()[1]))
        
        plt.plot(x, y, label = i)
        x.clear()
        y.clear()
    # plt.plot(y, x, label = "line 2")
    plt.legend()
    plt.show()
    # plt.plot(x, y, label = "line 1")
    # plt.ylabel('some numbers')
    # plt.legend()
    # plt.show()
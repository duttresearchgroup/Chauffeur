import sys
import os
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import matplotlib.image as mpimg

fig = plt.figure(sys.argv[1])

def isfloat(value):
  try:
    float(value)
    return True
  except ValueError:
    return False

def animate(i):
    
    file_path = sys.argv[1]
    ax1 = fig.add_subplot(1,1,1)
    ax2 = fig.add_subplot(1,1,1)
    ax3 = fig.add_subplot(1,1,1)
    f = open(file_path,"r")
    lines = f.readlines()
    xs = []
    ys_rss = []
    ys_pss = []
    ys_ref = []
    time = 0.0
    for d in lines[2:]:
        raw = d.split()
        if isfloat(raw[0]):
            time = float(raw[0]) + time
            xs.append(time)
            ys_rss.append(float(raw[1]))
            ys_pss.append(float(raw[2]))
            ys_ref.append(float(raw[3]))

    ax1.clear()
    ax2.clear()
    ax3.clear()
    ax1.plot(xs, ys_rss, label="RSS(MB)")
    ax2.plot(xs, ys_pss, label="PSS(MB)")
    ax3.plot(xs, ys_ref, label="Ref(MB)")

    plt.legend(loc='upper right')
    plt.xlabel("Time (s)")
    plt.ylabel("Memory (Mbs)")
   
if __name__ == "__main__":
    if len(sys.argv) == 1:
        print("Please input the file name")
        sys.exit(0)

    while(len(sys.argv) > 1):
        if(os.path.exists(sys.argv[1])):
            break
        else:
            print('Please input the correct memory profile file name')
            print('Usage python3 data_parser_memstat.py "filename"')     
            sys.exit(0)

    ani = animation.FuncAnimation(fig, func=animate, interval=2000)
    plt.show()


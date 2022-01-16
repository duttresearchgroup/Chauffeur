
import sys
import os
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import networkx as nx

fig, ax = plt.subplots()

def isfloat(value):
  try:
    float(value)
    return True
  except ValueError:
    return False

def calcutlate_avg_timing_between_frame(timimg_per_input, app):
    global cuda_lane_detection_file_idx
    global darknet_ros_file_idx
    global hybrid_astar_file_idx
    global lidar_tracking_file_idx
    
    file_idx = 0
    
    if app == 'cuda-lane-detection':
        file_idx = cuda_lane_detection_file_idx        

    elif app == 'darknet_ros':
        file_idx = darknet_ros_file_idx

    elif app == 'hybrid_astar':
        file_idx = hybrid_astar_file_idx

    elif app == 'lidar-tracking':
        file_idx = lidar_tracking_file_idx

    accumulate_time = 0.0
    times_between_frame = 0.0
    avg_time_between_frame = 0.0
    elapse_time = 0.0
    while accumulate_time < ms_between_frame:
        if file_idx < len(timimg_per_input):

            if isfloat(timimg_per_input[file_idx].split()[2]):
                elapse_time = float(timimg_per_input[file_idx].split()[2])
            else:
                pass

            if elapse_time > ms_between_frame:
                pass
            else:
                accumulate_time += elapse_time
                times_between_frame += 1.0
            
            file_idx+=1
        else:
            print("I need more logs!!!")
            sys.exit(0)

    avg_time_between_frame = accumulate_time / times_between_frame
    accumulate_time = 0.0
    
    
    if app == 'cuda-lane-detection':
        cuda_lane_detection_file_idx = file_idx      

    elif app == 'darknet_ros':
        darknet_ros_file_idx = file_idx

    elif app == 'hybrid_astar':
        hybrid_astar_file_idx = file_idx
    
    elif app == 'lidar-tracking':
        lidar_tracking_file_idx = file_idx       

    return avg_time_between_frame

def animate(i):

    global cuda_lane_detection_file_idx
    global darknet_ros_file_idx
    global hybrid_astar_file_idx
    global lidar_tracking_file_idx

    global num_of_frames_counted 
    global xs
    global ys 

    timing_per_input_logs = {}
    timimg_per_input = []

    for app in end_to_end:

        if app == 'cuda-lane-detection' and os.path.exists(sys.argv[3] + 'cuda_lane_detection_time_per_input.txt'):
            file_path = sys.argv[3] + 'cuda_lane_detection_time_per_input.txt'
            f = open(file_path,"r")
            timing_per_input_logs["cuda-lane-detection"] = f.readlines()

        elif app == 'darknet_ros' and os.path.exists(sys.argv[3] + 'darknet_ros_time_per_input.txt'):
            file_path = sys.argv[3] + 'darknet_ros_time_per_input.txt'
            f = open(file_path,"r")
            timing_per_input_logs["darknet_ros"] = f.readlines()

        elif app == 'hybrid_astar' and os.path.exists(sys.argv[3] + 'h_a_star_time_per_input.txt'):
            file_path = sys.argv[3] + 'h_a_star_time_per_input.txt'
            f = open(file_path,"r")
            timing_per_input_logs["hybrid_astar"] = f.readlines()

        elif app == 'lidar-tracking' and os.path.exists(sys.argv[3] + 'lidar_tracking.txt'):
            file_path = sys.argv[3] + 'lidar_tracking.txt'
            f = open(file_path,"r")
            timing_per_input_logs["lidar-tracking"] = f.readlines()

    end_to_end_time ={}
    end_to_end_time_per_frame=0.0
    num_of_frames_to_count = int(total_time_in_milliseconds / ms_between_frame)

    for app in end_to_end:
        if app in timing_per_input_logs:
            timimg_per_input = timing_per_input_logs[app]
            avg_timing_between_frame  = calcutlate_avg_timing_between_frame(timimg_per_input, app)
            
            if end_to_end[app] not in end_to_end_time:
                end_to_end_time[end_to_end[app]] = avg_timing_between_frame
            else:
                if end_to_end_time[end_to_end[app]] < avg_timing_between_frame:
                    end_to_end_time[end_to_end[app]] = avg_timing_between_frame
            

    for depth in end_to_end_time:
        end_to_end_time_per_frame += end_to_end_time[depth]
    
    ax1 = fig.add_subplot(1,1,1)

    if num_of_frames_counted <= num_of_frames_to_count:
        xs.append(float(num_of_frames_counted) * ms_between_frame / 1000.0)
        ys.append(end_to_end_time_per_frame)
        num_of_frames_counted+=1
        ax1.clear()
        ax1.plot(xs, ys)
        plt.xlabel("Time (s)")
        plt.ylabel("End-to-End Exectution time (ms)")
        
        if num_of_frames_counted == num_of_frames_to_count:
            with open(sys.argv[4], 'w') as filehandle:
                for i in range(len(xs)):
                    filehandle.write("%f %f\n" %(xs[i], ys[i]))       
            plt.savefig(sys.argv[1])
            sys.exit(0)

        
if __name__ == "__main__":

    global end_to_end
    global cuda_lane_detection_file_idx
    global darknet_ros_file_idx
    global hybrid_astar_file_idx
    global lidar_tracking_file_idx
    global ms_between_frame
    global fps
    global num_of_frames_counted
    global xs 
    global ys 
    
    pipline_num = [1,2]

    xs = []
    ys = []

    fps = 0.0
    total_time_in_seconds = 20.0
    total_time_in_milliseconds = total_time_in_seconds * 1000.0
    cuda_lane_detection_file_idx = 0
    darknet_ros_file_idx = 0
    hybrid_astar_file_idx = 0
    lidar_tracking_file_idx = 0
    
    if len(sys.argv) < 5 :
        print("Need more arguments")
        print('Usage: python3 data_parser_app_runtime.py [output image *.png] [1 or 2] [log folder] [output file *.txt]')   
        sys.exit(0)
    
    elif len(sys.argv) > 5:
        print("Too many arguments")
        print('Usage: python3 data_parser_app_runtime.py [output image *.png] [1 or 2] [log folder] [output file *.txt]')   
        sys.exit(0)

    while(len(sys.argv) == 5):
        if sys.argv[1].endswith(".png") and int(sys.argv[2]) in pipline_num and os.path.isdir(sys.argv[3]) and sys.argv[4].endswith(".txt"):
            break
        else:
            if not sys.argv[1].endswith(".png"):
                print("The output image must be a .png file")
            if int(sys.argv[2]) not in pipline_num:
                print("Pipeline num should be 1 or 2")
            if not os.path.isdir(sys.argv[3]):
                print("logs folder doesn't exist")
            if not sys.argv[4].endswith(".txt"):
                print("output should be a .txt file")

            print('Usage: python3 data_parser_app_runtime.py [output image *.png] [1 or 2] [log folder] [output file *.txt]')     
            sys.exit(0)

    if sys.argv[2] == '1':
        print("Using pipeline 1")
        fps = 10.0
        G = nx.DiGraph()
        G.add_node('cam', pos=(0,1))
        G.add_node('cuda-lane-detection', pos=(1,0))
        G.add_node('darknet_ros', pos=(1,2))
        G.add_node('hybrid_astar', pos=(2,1))
        G.add_node('ExtendedKF', pos=(3,1))
        G.add_edge('cam', 'cuda-lane-detection')
        G.add_edge('cam', 'darknet_ros')
        G.add_edge('cuda-lane-detection', 'hybrid_astar')
        G.add_edge('darknet_ros', 'hybrid_astar')
        G.add_edge('hybrid_astar', 'ExtendedKF')
        end_to_end = nx.shortest_path_length(G,'cam')
    
    elif sys.argv[2] == '2':
        print("Using pipeline 2")
        fps = 2.0
        G = nx.DiGraph()
        G.add_node('lidar', pos=(0,1))
        G.add_node('lidar-tracking', pos=(1,1))
        G.add_node('hybrid_astar', pos=(2,1))
        G.add_edge('lidar', 'lidar-tracking')
        G.add_edge('lidar-tracking', 'hybrid_astar')
        end_to_end = nx.shortest_path_length(G,'lidar')

    ms_between_frame = 1 / fps * 1000.0
    num_of_frames_counted = 0
    
    position=nx.get_node_attributes(G,'pos')

    nx.draw(G, with_labels = True, pos=position)

    ani = animation.FuncAnimation(fig, func=animate, interval=50)
    
    plt.show()


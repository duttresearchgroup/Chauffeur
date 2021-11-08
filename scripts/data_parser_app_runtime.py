import sys
import os
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import matplotlib.image as mpimg
import networkx as nx

graph = {'cam': ['cuda-lane-detection', 'darknet_ros'],
            'cuda-lane-detection': ['hybrid_astar'],
            'darknet_ros': ['hybrid_astar'],
            'hybrid_astar': ['extendedKF'],
        }

fig, ax = plt.subplots()

if __name__ == "__main__":

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

    position=nx.get_node_attributes(G,'pos')

    nx.draw(G, with_labels = True, pos=position)

    depths = nx.shortest_path_length(G,'cam')
    print(type(depths))
    for key in depths:
        print(key, '->', depths[key])

    plt.show()
    
    # print(graph)
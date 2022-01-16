python3 data_parser_app_runtime.py cam0.png 1 ../logs/cam0/ cam0.txt
python3 data_parser_app_runtime.py cam1.png 1 ../logs/cam1/ cam1.txt
python3 data_parser_app_runtime.py lidar0.png 2 ../logs/lidar0/ lidar0.txt
python3 data_parser_runtime_graph_merge.py cam0.txt cam1.txt lidar0.txt
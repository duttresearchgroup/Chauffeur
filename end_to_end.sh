docker run -d --gpus all -v $(pwd)/logs/cam0:/workspace/logs --entrypoint "python3" x86.runner runner_detached.py 3 4 6 
docker run -d --gpus all -v $(pwd)/logs/cam1:/workspace/logs --entrypoint "python3" x86.runner runner_detached.py 3 4 6
docker run -d --gpus all -v $(pwd)/logs/lidar0:/workspace/logs --entrypoint "python3" x86.runner runner_detached.py 3 8  

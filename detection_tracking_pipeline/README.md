# Vehicle_Detection_And_Tracking_Pipeline
A simple vehicle detection and tracking pipeline

## Step 1: Build the docker image

```
cd Vehicle_Detection_And_Tracking_Pipeline
docker build -t pipeline .
```

## Step 2: Run the container

```
docker run -it --network host --gpus all -v $(pwd)/source/output:/source/output pipeline /bin/bash
```

## Step 3: Start the end-to-end pipeline

```
./end_to_end.sh
```
if ended, press ctrl+C

## Step 4: After finish, kill all process
```
./killall.sh
```

## Step 5: Make video
If you want to combine output images as a video:
```
cd output
ffmpeg -framerate 30 -i "%d.png" output.mp4
```


## Additional Step : Run multiple detached containers
```
docker-compose build
docker-compose up
```

STR="INPUT_VIDEO=\"test_videos/project_video.mp4\""
STR1="RATIO_CONFIG=\"/configs/test.cfg\""
STR2="MONITORING_PERIOD="
STR3="TOTAL_TIME="
rm -rf .env
echo $STR > .env
echo $STR1 >> .env
echo $STR2"1" >> .env
echo $STR3"300" >> .env
docker-compose up --force-recreate -d 
sleep 300
sudo mv source/vehicle_detection_and_tracking_pipeline_detector_1 ./dataset/.
sudo mv source/vehicle_detection_and_tracking_pipeline_tracker_1 ./dataset/.
docker-compose down

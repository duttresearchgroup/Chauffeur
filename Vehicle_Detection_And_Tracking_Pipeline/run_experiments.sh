#!/bin/bash
#for x in 1
mkdir result
mkdir -p result/proswap
mkdir -p result/normal
mkdir -p result/default

for x in 1 2 3 
#for x in 1
do
sudo swapoff --all
sudo swapon /home/alex/swapfile
docker-compose up --force-recreate > log &
PID=$!
sleep 300
sudo kill -SIGINT $PID
docker stop $(docker ps -aq)
cp log result/normal/$x"_raw.log"
cat log | grep -a fps | awk '{print $5}' > result/normal/$x.log
done

for x in 1 2 3
do
sudo swapoff --all
sudo swapon /home/alex/swapfile
docker-compose up --force-recreate > log &
sleep 30
python3 swaphist.py &
sleep 300
# sudo kill -9 $(ps -axu | grep swaphist | head -n1 | awk '{ print $2}')
# sudo kill -SIGINT $(ps -axu | grep my_scheme | head -n1| awk '{print $2}')
PID=$(ps -axu | grep docker-compose | head -n3 | tail | awk '{ print $2}')
# echo $PID
sudo kill -SIGINT $PID
# echo $(ps -axu | grep swaphist | head -n1 | awk '{ print $2}')
# echo $(ps -axu | grep my_scheme | head -n1| awk '{print $2}')
sudo kill -9 $(ps -axu | grep swaphist | head -n3 | tail | awk '{ print $2}')
sudo kill -SIGINT $(ps -axu | grep damo | head -n 1| awk '{print $2}')
cp log result/proswap/$x"_raw.log"
cat log | grep -a fps | awk '{print $5}' > result/proswap/$x.log
docker stop $(docker ps -aq)
done

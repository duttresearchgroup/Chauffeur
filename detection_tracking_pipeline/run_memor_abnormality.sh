#!/bin/bash
for x in 1 2 3 4 5 6 7 8 9 10
do
    ./masim/masim --quiet masim/configs/demo.cfg
    sleep 30
done
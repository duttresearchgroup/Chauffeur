#!/bin/bash
P1=$(pgrep -f input.py)
P2=$(pgrep -f detect.py)
P3=$(pgrep -f track.py)
P4=$(pgrep -f output.py)

kill -9 $P1 $P2 $P3 $P4

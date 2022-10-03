#!/bin/bash
python3 input.py -f ${INPUT_VIDEO} -i ${SLEEP_TIME} -t 0&
python3 track.py &
python3 detect.py &
python3 output.py -d output

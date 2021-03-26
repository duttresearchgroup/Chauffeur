export PYTHONPATH="${PYTHONPATH}:/home/leming/workspace/lanenet/lanenet-lane-detection/lanenet_model/" 





LD_PRELOAD=/usr/local/lib/python3.6/dist-packages/scikit_learn.libs/libgomp-d22c30c5.so.1.0.0 python3.6 tools/test_lanenet.py --weights_path /home/leming/workspace/lanenet/model/tusimple_lanenet/tusimple_lanenet.ckpt --image_path ./data/tusimple_test_image/0.jpg

#LD_PRELOAD=/usr/local/lib/python3.6/dist-packages/scikit_learn.libs/libgomp-d22c30c5.so.1.0.0 python3.6 tools/test_lanenet.py --weights_path /home/leming/workspace/lanenet/model/tusimple_lanenet/ --image_path ./data/tusimple_test_image/0.jpg

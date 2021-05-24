#
# converts a saved PyTorch model to ONNX format
# 
import os
import sys
import argparse

import torch.onnx

from vision.ssd.vgg_ssd import create_vgg_ssd
from vision.ssd.mobilenetv1_ssd import create_mobilenetv1_ssd
from vision.ssd.mobilenetv1_ssd_lite import create_mobilenetv1_ssd_lite
from vision.ssd.squeezenet_ssd_lite import create_squeezenet_ssd_lite
from vision.ssd.mobilenet_v2_ssd_lite import create_mobilenetv2_ssd_lite


# parse command line
parser = argparse.ArgumentParser()
parser.add_argument('--net', default="ssd-mobilenet", help="The network architecture, it can be mb1-ssd (aka ssd-mobilenet), mb1-lite-ssd, mb2-ssd-lite or vgg16-ssd.")
parser.add_argument('--input', type=str, default='', help="path to input PyTorch model (.pth checkpoint)")
parser.add_argument('--output', type=str, default='', help="desired path of converted ONNX model (default: <NET>.onnx)")
parser.add_argument('--labels', type=str, default='labels.txt', help="name of the class labels file")
parser.add_argument('--width', type=int, default=300, help="input width of the model to be exported (in pixels)")
parser.add_argument('--height', type=int, default=300, help="input height of the model to be exported (in pixels)")
parser.add_argument('--batch-size', type=int, default=1, help="batch size of the model to be exported (default=1)")
parser.add_argument('--model-dir', type=str, default='', help="directory to look for the input PyTorch model in, and export the converted ONNX model to (if --output doesn't specify a directory)")

args = parser.parse_args() 
print(args)

# set the device
device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
print('running on device ' + str(device))

# format input model paths
if args.model_dir:
    args.model_dir = os.path.expanduser(args.model_dir)
    
    # find the checkpoint with the lowest loss
    if not args.input:
        best_loss = 10000
        for file in os.listdir(args.model_dir):
            if not file.endswith(".pth"):
                continue
            try:
               loss = float(file[file.rfind("-")+1:len(file)-4])
               if loss < best_loss:
                   best_loss = loss
                   args.input = os.path.join(args.model_dir, file)
            except ValueError:
               continue            
        print('found best checkpoint with loss {:f} ({:s})'.format(best_loss, args.input))
        
    # append the model dir (if needed)
    if not os.path.isfile(args.input):
	    args.input = os.path.join(args.model_dir, args.input)

    if not os.path.isfile(args.labels):
        args.labels = os.path.join(args.model_dir, args.labels)

# determine the number of classes
class_names = [name.strip() for name in open(args.labels).readlines()]
num_classes = len(class_names)

# construct the network architecture
print('creating network:  ' + args.net)
print('num classes:       ' + str(num_classes))

if args.net == 'vgg16-ssd':
    net = create_vgg_ssd(len(class_names), is_test=True)
elif args.net == 'mb1-ssd' or args.net == 'ssd-mobilenet':
    net = create_mobilenetv1_ssd(len(class_names), is_test=True)
elif args.net == 'mb1-ssd-lite':
    net = create_mobilenetv1_ssd_lite(len(class_names), is_test=True)
elif args.net == 'mb2-ssd-lite':
    net = create_mobilenetv2_ssd_lite(len(class_names), is_test=True)
elif args.net == 'sq-ssd-lite':
    net = create_squeezenet_ssd_lite(len(class_names), is_test=True)
else:
    print("The net type is wrong. It should be one of vgg16-ssd, mb1-ssd and mb1-ssd-lite.")
    sys.exit(1)
    
# load the model checkpoint
print('loading checkpoint:  ' + args.input)

net.load(args.input)
net.to(device)
net.eval()

# create example image data
dummy_input = torch.randn(args.batch_size, 3, args.height, args.width).cuda()

# format output model path
if not args.output:
	args.output = args.net + '.onnx'

if args.model_dir and args.output.find('/') == -1 and args.output.find('\\') == -1:
	args.output = os.path.join(args.model_dir, args.output)

# export to ONNX
input_names = ['input_0']
output_names = ['scores', 'boxes']

print('exporting model to ONNX...')
torch.onnx.export(net, dummy_input, args.output, verbose=True, input_names=input_names, output_names=output_names)
print('model exported to:  {:s}'.format(args.output))
print('task done, exiting program')

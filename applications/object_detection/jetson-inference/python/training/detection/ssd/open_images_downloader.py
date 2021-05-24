import time
import boto3
from botocore import UNSIGNED
from botocore.config import Config
import botocore
import logging
from multiprocessing import Pool, Manager
import pandas as pd
import numpy as np
import os
import argparse
import sys
import functools
from urllib import request
from random import sample 

s3 = boto3.client('s3', config=Config(signature_version=UNSIGNED))


def parse_args():
    parser = argparse.ArgumentParser(description='Dowload open image dataset by class.')

    parser.add_argument("--root", "--data", type=str, default="data", help="The root directory that you want to store the image data.")
    parser.add_argument("--include-depiction", action="store_true", help="Do you want to include drawings or depictions?")
    parser.add_argument("--class-names", type=str, help="Comma-separated list of classes you want to download.")
    parser.add_argument("--num-workers", type=int, default=10, help="the number of worker threads used to download images.")
    parser.add_argument("--retry", type=int, default=10, help="retry times when downloading.")
    parser.add_argument('--remove-overlapped', action='store_true', help="Remove single boxes covered by group boxes.")
    parser.add_argument('--max-images', type=int, default=-1, help='limit the total number of images downloaded across the whole dataset.  The default is to use all available data.')
    parser.add_argument('--max-annotations-per-class', type=int, default=-1, help='limit the number of bounding-box annotations per class.  Each class will be able to have up to this many annotations.  The default is to use all annotations per class.')
    parser.add_argument('--stats-only', action='store_true', help='only list the number of images from the selected classes, and quit')
    
    return parser.parse_args()


def download(bucket, root, retry, counter, lock, path):
    i = 0
    src = path
    dest = f"{root}/{path}"
    while i < retry:
        try:
            if not os.path.exists(dest):
                s3.download_file(bucket, src, dest)
            else:
                logging.info(f"{dest} already exists.")
            with lock:
                counter.value += 1
                if counter.value % 100 == 0:
                    logging.warning(f"Downloaded {counter.value} images.")
            return
        except botocore.exceptions.ClientError as e:
            if e.response['Error']['Code'] == "404":
                logging.warning(f"The file s3://{bucket}/{src} does not exist.")
                return
            i += 1
            logging.warning(f"Sleep {i} and try again.")
            time.sleep(i)
    logging.warning(f"Failed to download the file s3://{bucket}/{src}. Exception: {e}")


def batch_download(bucket, file_paths, root, num_workers=10, retry=10):
    with Pool(num_workers) as p:
        m = Manager()
        counter = m.Value('i', 0)
        lock = m.Lock()
        download_ = functools.partial(download, bucket, root, retry, counter, lock)
        p.map(download_, file_paths)


def http_download(url, path):
    with request.urlopen(url) as f:
        with open(path, "wb") as fout:
            buf = f.read(1024)
            while buf:
                fout.write(buf)
                buf = f.read(1024)


def log_counts(values):
    for k, count in values.value_counts().iteritems():
        print("    {:s}:  {:d}/{:d} = {:.2f}".format(k, count, len(values), count/len(values)))


def get_totals(dataset_types, images, annotations):
    total_images = sum([len(images[d]) for d in dataset_types])
    total_annotations = sum([len(annotations[d]) for d in dataset_types]) 
    return total_images, total_annotations
    

if __name__ == '__main__':
    logging.basicConfig(stream=sys.stdout, level=logging.WARNING,
                        format='%(asctime)s - %(message)s', datefmt="%Y-%m-%d %H:%M:%S")

    args = parse_args()
    bucket = "open-images-dataset"
    
    # split the --class_names argument into an array
    class_names = [e.strip() for e in args.class_names.split(",")]
    num_classes = len(class_names)
    
    # make sure the output dir exists
    if not os.path.exists(args.root):
        os.makedirs(args.root)

    # download the class description list
    class_description_file = os.path.join(args.root, "class-descriptions-boxable.csv")
    
    if not os.path.isfile(class_description_file):
        url = "https://storage.googleapis.com/openimages/2018_04/class-descriptions-boxable.csv"
        logging.warning(f"Download {url}.")
        http_download(url, class_description_file)

    # load the class descriptions and filter by the requested classes
    class_descriptions = pd.read_csv(class_description_file, names=["id", "ClassName"])
    class_descriptions = class_descriptions[class_descriptions['ClassName'].str.lower().isin([x.lower() for x in class_names])]

    # verify that all the requested classes were found
    logging.warning(f"Requested {num_classes} classes, found {len(class_descriptions)} classes")
    
    if num_classes != len(class_descriptions):
        missing_classes = []
        
        for class_name in class_names:
            if len(class_descriptions[class_descriptions['ClassName']==class_name]) == 0:
                logging.warning(f"Couldn't find class '{class_name}'")
                missing_classes.append(class_name)
                
        raise Exception("Couldn't find classes '{:s}' in the Open Images dataset.  Please confirm that the --class_names argument contains valid classes.".format(','.join(missing_classes)))
        
    # download and parse the annotations
    dataset_types = ["train", "validation", "test"]
    annotations = {}
    images = {}
    
    for dataset_type in dataset_types:
         # create subdirectory for this set
        image_dir = os.path.join(args.root, dataset_type)
        os.makedirs(image_dir, exist_ok=True)

        # download the annotations for train/val/test
        annotation_file = f"{args.root}/{dataset_type}-annotations-bbox.csv"
        
        if not os.path.exists(annotation_file):
            url = f"https://storage.googleapis.com/openimages/2018_04/{dataset_type}/{dataset_type}-annotations-bbox.csv"
            logging.warning(f"Download {url}.")
            http_download(url, annotation_file)
            
        logging.warning(f"Read annotation file {annotation_file}")
        
        # parse the annotations and filter by the class names
        annotation_set = pd.read_csv(annotation_file)
        annotation_set = pd.merge(annotation_set, class_descriptions, left_on="LabelName", right_on="id", how="inner")
        
        # remove drawings and depictions
        if not args.include_depiction:
            annotation_set = annotation_set.loc[annotation_set['IsDepiction'] != 1, :]
    
        annotations[dataset_type] = annotation_set
        images[dataset_type] = annotation_set['ImageID'].unique()
   
        logging.warning(f"Available {dataset_type} images:  {len(images[dataset_type])}")
        logging.warning(f"Available {dataset_type} boxes:   {len(annotations[dataset_type])}\n")
        
    # get the total number of images / annotations    
    total_images, total_annotations = get_totals(dataset_types, images, annotations)
    
    logging.warning(f"Total available images: {total_images}")
    logging.warning(f"Total available boxes:  {total_annotations}\n")

    # limit the total number of images (if needed)
    if args.max_images > 0 and total_images > args.max_images:
        for d in dataset_types:
            max_images = int(args.max_images * (len(images[d]) / total_images))
            images[d] = np.random.permutation(images[d])[:max_images]
            annotations[d] = annotations[d].loc[annotations[d]['ImageID'].isin(images[d]), :]
            logging.warning(f"Limiting {d} dataset to:  {len(images[d])} images ({len(annotations[d])} boxes)")

        total_images, total_annotations = get_totals(dataset_types, images, annotations)

    # limit the number of annotations per class
    if args.max_annotations_per_class > 0:
        for d in dataset_types:
            limited_images = []
            limited_annotations = []
            
            for class_name in class_names:
                class_annotations = annotations[d][(annotations[d]['ClassName'] == class_name)]
                class_images = class_annotations['ImageID'].unique()

                if len(class_annotations) > args.max_annotations_per_class:
                    class_annotations = class_annotations.sample(n=args.max_annotations_per_class)
                    class_images = class_annotations['ImageID'].unique()
                    logging.warning(f"Limiting '{class_name}' in {d} dataset to:  {len(class_annotations)} boxes ({len(class_images)} images)")

                limited_images.append(class_images)
                limited_annotations.append(class_annotations)
                
            images[d] = np.concatenate(limited_images)
            annotations[d] = pd.concat(limited_annotations)
            
        total_images, total_annotations = get_totals(dataset_types, images, annotations)
        
        logging.warning(f"Total images after limiting annotations per-class: {total_images}")
        logging.warning(f"Total boxes after limiting annotations per-class:  {total_annotations}\n")
    
    # print out class statistics
    for dataset_type in dataset_types:
        print("\n-------------------------------------\n '{:s}' set statistics\n-------------------------------------".format(dataset_type))
        print("  Image count:  {:d}".format(len(images[dataset_type])))
        print("  Bounding box count:  {:d}".format(len(annotations[dataset_type])))
        print("  Bounding box distribution: ")
        log_counts(annotations[dataset_type]['ClassName'])
        #print("  Approximate image stats: ")
        #log_counts(annotations[dataset_type].drop_duplicates(["ImageID", "ClassName"])["ClassName"])
        print(" ")
    
    print("\n-------------------------------------\n Overall statistics\n-------------------------------------".format(dataset_type))
    print("  Image count:  {:d}".format(total_images))
    print("  Bounding box count:  {:d}\n".format(total_annotations))

    if args.stats_only:
        sys.exit(0)
        
    # save our selected annotations and build the image list
    image_files = []
    
    for dataset_type in dataset_types:
        sub_annotation_file = f"{args.root}/sub-{dataset_type}-annotations-bbox.csv"
        logging.warning(f"Saving '{dataset_type}' data to {sub_annotation_file}.")
        annotations[dataset_type].to_csv(sub_annotation_file, index=False)
        image_files.extend(f"{dataset_type}/{id}.jpg" for id in images[dataset_type])
        
    logging.warning(f"Starting to download {len(image_files)} images.")
    batch_download(bucket, image_files, args.root, args.num_workers, args.retry)
    logging.warning("Task Done.")
    
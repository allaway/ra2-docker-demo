# RA2 Docker Demo

The purpose of this repository is to provide a template for creating a Docker image for submission to this challenge, and to provide information about required components of your Docker image for it to be scored correctly. 

## Basic Requirements 

There are a few basic requirements that your Docker container must have in order to run correctly: 

- Have /train, /test, and /output directories at the top directory level. 
- The model must read in images from the /train (if submitting untrained model) and /test directories.
- The model must write out a prediction file called predictions.csv to the /output directory. 
- Able to run without a network connection (ie all dependencies already installed).
- Have a defined ENTRYPOINT that runs your model (either directly in Python, R, etc, or via a shell script). 
- (GPU Only) Must define PATHs to access Cheaha's NVIDIA drivers - this is only necessary if your model requires GPU functionality. See run.sh below for more information. 

## Files in this repository
There are three files in this repository that we will define in greater detail below: Dockerfile, run.sh, and model.R. This repository will create a dockerfile that successfully runs on the challenge scoring harness, has GPU access, and produces a prediction file with a "2" for every score.

### run.sh


### model.R


### Dockerfile 


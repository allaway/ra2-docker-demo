# hello-world RA2 DREAM Challenge Docker Demo

The purpose of this repository is to provide a template for creating a Docker image for submission to this challenge, and to discuss the required components of your Docker image for it to be pass validation and be scored. You can inspect the docker image itself by logging into the Synapse docker repository (`docker login docker.synapse.org`) and pulling the image (`docker pull docker.synapse.org/syn20545111:hello-world`). 

## Basic Requirements 

There are a few basic requirements that your Docker container must have in order to run correctly: 

- Have `/train/`, `/test/`, and `/output/` directories at the top directory level. 
- The model must read in images from the `/train/` (if submitting untrained model) and `/test/` directories.
- The model must write out a prediction file called predictions.csv to the `/output/` directory. 
- Be able to run without a network connection (i.e. all dependencies already installed).
- Have a defined `ENTRYPOINT` that runs your model (either directly in Python, R, etc, or via a shell script). 
- Any required scripts must be executable by non-root user (`chmod 755`or `chmod +x`)
- (GPU Only) Must define `PATHs` to access Cheaha's NVIDIA drivers - this is only necessary if your model requires GPU functionality. See `run.sh` below for more information. 
- Must be tested locally! A good way to do this would be to create a `testing/` directory on your machine. Within this directory, copy a small subset of the training data to create `train/` and `test/` directories on your local machine, and create an `output/` folder as well. Then, from this directory, run:  `docker run -networking="none" -v test/:/test/ -v train/:/train/ -v output/:/output/ your-container-name`
 
## Files in this repository
There are three files in this repository that we will define in greater detail below: Dockerfile, run.sh, and model.R. This repository will create a dockerfile that successfully runs on the challenge scoring harness, has GPU access, and produces a prediction file with a "2" for every score.

### model.R

[model.R](https://github.com/allaway/ra2-docker-demo/blob/master/model.R) reads in the provided numerical training data (`/train/training.csv`) and template (`/test/template.csv`). It fills the template in with scores of "2" for all columns. It also provides a snippet at the end that reports GPU devices that it has access to - you may want to do something similar in your model to report GPU devices in your logs - this will help verify whether you have GPU drivers configured correctly. 

### run.sh

[run.sh](https://github.com/allaway/ra2-docker-demo/blob/master/run.sh) defines the PATHs that you *must* export if you want your running container to have access to GPU drivers. It also runs the model script - `run.sh` could be omitted if your entrypoint directly calls your model file. 

### Dockerfile 

The [Dockerfile](https://github.com/allaway/ra2-docker-demo/blob/master/Dockerfile) describes the Docker image that will be built by `docker build`. You can examine the Dockerfile for more details but there are a few basic steps: building off of a previous container (`FROM`), installing dependencies and making directories (`RUN`) and defining the entrypoint (`ENTRYPOINT`), that is, the script that will execute when we run the container. 

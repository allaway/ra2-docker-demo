#!/bin/bash

# Required to use GPU: Copy and paste these path exports to your run.sh file so that the NVIDIA drivers
# Are available. Alternatively, you can define these system-wide in the Dockerfile
export CUDA_HOME=/cm/local/apps/cuda/libs/current
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${CUDA_HOME}/lib64
PATH=${CUDA_HOME}/bin:${PATH}
export PATH

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/cm/shared/apps/cuda10.0/toolkit/10.0.130/lib64
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/share/apps/rc/software/cuDNN/7.6.2.24-CUDA-10.1.243/lib64

# Command to run R model
Rscript --vanilla /usr/local/bin/model.R

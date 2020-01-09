# Get a good base docker image, pin it to a specific SHA digest to ensure reproducibility 
FROM rocker/r-base@sha256:ec224c21eff00e6cd8016419fae2886596c76e80fb1ae042e657b3cd08ba30d8

# Install dependencies, this example is to use tensorflow in R via the keras library
RUN apt-get update -y && \
    apt-get install -y libpython3-dev && \ 
    apt-get install -y python-pip libjpeg-dev && \ 
    pip install virtualenv Pillow pandas

RUN R -e "install.packages(c('tidyverse','keras'), dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e 'keras::install_keras(tensorflow = "gpu")'
RUN echo "Sys.setenv(RETICULATE_PYTHON = '/root/.virtualenvs/r-reticulate/bin/python')" > ~/.Rprofile

# Required: Create /train /test and /output directories 
RUN mkdir /train
RUN mkdir /test
RUN mkdir /output

# Required for GPU: run.sh defines PATHs to find GPU drivers, see run.sh for specific commands
COPY run.sh /run.sh

# Required: a model file. 
COPY model.R /usr/local/bin/model.R

# Make model and runfiles executable 
RUN chmod 775 /usr/local/bin/model.R
RUN chmod 775 /run.sh

# This is for the virtualenv defined above, if not using a virtualenv, this is not necessary
RUN chmod 755 /root #to make virtualenv accessible to singularity user

# Required: define an entrypoint. run.sh will run the model for us, but in a different configuration
# you could simply call the model file directly as an entrypoint 
ENTRYPOINT ["/bin/bash", "/run.sh"]
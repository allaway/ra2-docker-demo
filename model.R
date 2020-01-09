library(dplyr)
library(glue)
library(readr)

## we will mount training.csv into the "/train" directory, so look for this here!
train <- read_csv('/train/training.csv') 

## you could do this another way, but this is one way to use the training data csv 
## to generate all of the paths 
labs <- train %>% 
  select(Patient_ID, Overall_Tol) %>% 
  mutate(rh = glue::glue('/train/{Patient_ID}-RH.jpg'),
         lh = glue::glue('/train/{Patient_ID}-LH.jpg'),
         rf = glue::glue('/train/{Patient_ID}-RF.jpg'),
         lf = glue::glue('/train/{Patient_ID}-LF.jpg'))

## insert steps to read in images and train model
## for this example, our model formula will predict all images as having a score of 2 

model_formula <- 2

## we will mount template.csv into the "/test" directory, so look for this here!

template <- read_csv('/test/template.csv')

## you could do this another way, but this is one way to use the template data csv 
## to generate all of the paths 
labs_test <- template %>% 
  select(Patient_ID, Overall_Tol) %>% 
  mutate(rh = glue::glue('/test/{Patient_ID}-RH.jpg'),
         lh = glue::glue('/test/{Patient_ID}-LH.jpg'),
         rf = glue::glue('/test/{Patient_ID}-RF.jpg'),
         lf = glue::glue('/test/{Patient_ID}-LF.jpg'))

## insert steps to read in images, test model on images
## for this example, our model formula will predict all images and all scores as having a score of 2 

predictions <- template %>% #get template
  mutate_at(vars(-Patient_ID), ~ 2 ) #insert 2 in every column except for Patient_ID (do not modify that column)

## you must output your predictions to "/output/predictions.csv" in your container
predictions %>% write_csv('/output/predictions.csv')

##The steps below are only to demonstrate GPU usage: 

##The above model doesn't depend on GPUs, but what if yours does? 
##You MUST define PATHs in your running container to properly map the drivers
##Please see run.sh file in this repo for more information

##this snippet will show that tensorflow (a deep learning library) can access the GPU
library(reticulate)
library(tensorflow)

##for ease, we installed a virtualenv to make sure we have all of the correct libraries
##see Dockerfile for how this was done
reticulate::use_virtualenv('/root/.virtualenvs/r-reticulate')
tf$python$client$device_lib$list_local_devices()


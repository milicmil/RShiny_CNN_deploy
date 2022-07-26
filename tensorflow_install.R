install.packages("tensorflow")


#/Users/new/opt/miniconda3/bin/python

library(reticulate)
virtualenv_create("r-reticulate", python = "/Users/new/opt/miniconda3/bin/python")


library(tensorflow)
install_tensorflow(envname = "r-reticulate")



install.packages("keras")
library(keras)
install_keras(envname = "r-reticulate")

#testing intallation
library(tensorflow)
tf$constant("Hello Tensorflow!")

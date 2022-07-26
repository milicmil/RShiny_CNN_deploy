library(keras)
library(tensorflow)
mnist <- dataset_mnist()

setwd("/Users/new/Documents/github_projects/RShiny_CNN_deploy")


#loadind a simple MNIST number model
mnist$train$x <- (mnist$train$x/255) %>% 
  array_reshape(., dim = c(dim(.), 1))

mnist$test$x <- (mnist$test$x/255) %>% 
  array_reshape(., dim = c(dim(.), 1))


#here we will define a simple CNN
model <- keras_model_sequential() %>% 
  layer_conv_2d(filters = 16, kernel_size = c(3,3), activation = "relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_conv_2d(filters = 16, kernel_size = c(3,3), activation = "relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_flatten() %>% 
  layer_dense(units = 128, activation = "relu") %>% 
  layer_dense(units = 10, activation = "softmax")

model %>% 
  compile(
    loss = "sparse_categorical_crossentropy",
    optimizer = "adam",
    metrics = "accuracy"
  )

#Now we will fit our model
model %>% 
  fit(
    x = mnist$train$x, y = mnist$train$y,
    batch_size = 32,
    epochs = 5,
    validation_sample = 0.2,
    verbose = 2
  )

#evaluating the performance
model %>% evaluate(x = mnist$test$x, y = mnist$test$y)


#Now we save our model
save_model_tf(model, "Image_Classification_CAMH/cnn-mnist")

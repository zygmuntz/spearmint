get_rmse <- function( y, p ) sqrt( mean(( y - p )^2 ))

train_file = 'data/train.csv'
validation_file = 'data/validation.csv'
test_file = 'data/test.csv'

library( randomForest )

train <- read.csv( train_file, header = TRUE, sep = ";" )
validation <- read.csv( validation_file, header = TRUE, sep = ";" )
test <- read.csv( test_file, header = TRUE, sep = ";" )

# combine train and validation sets
train = rbind( train, validation )

y_train = train$quality
y_test = test$quality

x_train =  train[, 1:length( train ) - 1]
x_test =  test[, 1:length( test ) - 1]


predictions_default = vector()
for ( i in 1:10 ) {
	rf <- randomForest( x_train, y_train, ntree = 158 )

	p <- predict( rf, x_test )

	rmse = get_rmse( y_test, p )
	predictions_default[i] = rmse
}

print( mean( predictions_default ))


predictions_mtry2 = vector()
for ( i in 1:10 ) {
	rf <- randomForest( x_train, y_train, ntree = 158, mtry = 2 )

	p <- predict( rf, x_test )

	rmse = get_rmse( y_test, p )
	predictions_mtry2[i] = rmse
}

print( mean( predictions_mtry2 ))


# a boxplot
all_predictions = as.data.frame( list( predictions_default, predictions_mtry2 ))
colnames( all_predictions ) = c('default', 'mtry = 2' )
boxplot( all_predictions )

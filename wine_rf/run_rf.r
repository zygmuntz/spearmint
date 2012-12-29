get_rmse <- function( y, p ) sqrt( mean(( y - p )^2 ))

ntrees = as.numeric( argv[1] )
nvars = as.numeric( argv[2] )
# cat( ntrees, nvars )

train_file = 'data/train.csv'
validation_file = 'data/validation.csv'

library( randomForest )

train <- read.csv( train_file, header = TRUE, sep = ";" )
testv <- read.csv( validation_file, header = TRUE, sep = ";" )

y_train = train$quality
y_testv = testv$quality

x_train =  train[, 1:length( train ) - 1]
x_testv =  testv[, 1:length( testv ) - 1]


rf <- randomForest( x_train, y_train, ntree = ntrees, mtry = nvars )

p <- predict( rf, x_testv )

rmse = get_rmse( y_testv, p )
cat( 'rmse:', rmse, "\n" )



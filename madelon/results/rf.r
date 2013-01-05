# train a random forest, predict, score

ntrees = 919
nvars = 169

"
accuracy 0.86
auc 0.9272056
"

train_file = 'data/madelon_train.data'
train_labels = 'data/madelon_train.labels'

validation_file = 'data/madelon_valid.data'
validation_labels = 'data/madelon_valid.labels'


library( randomForest )
library( caTools )


x_train <- read.table( train_file, sep = " " )
x_train = x_train[, 1:500]

x_validation <- read.table( validation_file, sep = " " )
x_validation = x_validation[, 1:500]

y_train = as.numeric( readLines( train_labels ))
y_validation = as.numeric( readLines( validation_labels ))

rf <- randomForest( x_train, as.factor( y_train ), ntree = ntrees, mtry = nvars, do.trace = 50 )
p <- predict( rf, x_validation, type = 'prob' )
p_binary <- predict( rf, x_validation )
probs =  p[,2]

accuracy = sum( p_binary == y_validation ) / length( p_binary )
print( accuracy )

auc = colAUC( probs, ( y_validation + 1 ) / 2 )
auc = auc[1]

print( auc )

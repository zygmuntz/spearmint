# a script to be run by Spearmint

ntrees = as.numeric( argv[1] )
nvars = as.numeric( argv[2] )
cat( ntrees, nvars )

train_file = 'data/train.data'
train_labels = 'data/train.labels'

validation_file = 'data/trainv.data'
validation_labels = 'data/trainv.labels'

library( caTools )
library( randomForest )

x_train <- read.table( train_file, sep = " " )
x_train = x_train[, 1:500]

x_validation <- read.table( validation_file, sep = " " )
x_validation = x_validation[, 1:500]

y_train = as.numeric( readLines( train_labels ))
y_validation = as.numeric( readLines( validation_labels ))

rf <- randomForest( x_train, as.factor( y_train ), ntree = ntrees, mtry = nvars, do.trace = 5 )
p <- predict( rf, x_validation, type = 'prob' )
probs =  p[,2]

auc = colAUC( probs, ( y_validation + 1 ) / 2 )
auc = auc[1]

cat( 'auc:', auc, "\n" )



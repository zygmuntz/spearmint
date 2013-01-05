# output submission files for nips 2003 challenge
# train on training + validation

ntrees = 919
nvars = 169

setwd( 'D:/devel/bin/spearmint/madelon/' )

train_file = 'data/madelon_train.data'
train_labels = 'data/madelon_train.labels'

validation_file = 'data/madelon_valid.data'
validation_labels = 'data/madelon_valid.labels'

test_file = 'data/madelon_test.data'


library( randomForest )
library( caTools )


x_train <- read.table( train_file, sep = " " )
x_train = x_train[, 1:500]

x_validation <- read.table( validation_file, sep = " " )
x_validation = x_validation[, 1:500]

x_test <- read.table( test_file, sep = " " )
x_test = x_test[, 1:500]

y_train = as.numeric( readLines( train_labels ))
y_validation = as.numeric( readLines( validation_labels ))

combined_x_train = rbind( x_train, x_validation)
combined_y_train = as.factor( rbind( as.matrix( y_train ), as.matrix( y_validation )))

rf <- randomForest( combined_x_train, combined_y_train, ntree = ntrees, mtry = nvars, do.trace = 50 )

# training set predictions
train_p <- predict( rf, x_train, type = 'prob' )
train_probs =  train_p[,2]
train_p_binary <- predict( rf, x_train )

# validation set predictions
valid_p <- predict( rf, x_validation, type = 'prob' )
valid_probs =  valid_p[,2]
valid_p_binary <- predict( rf, x_validation )

# test set predictions
test_p <- predict( rf, x_test, type = 'prob' )
test_probs =  test_p[,2]
test_p_binary <- predict( rf, x_test )

# validation metrics
accuracy = sum( valid_p_binary == y_validation ) / length( valid_p_binary )
cat( "validation accuracy:", accuracy )

auc = colAUC( valid_probs, ( y_validation + 1 ) / 2 )
auc = auc[1]
cat( "validation auc:", auc )

# compute confidence values from probabilities
train_conf = abs( train_probs - 0.5 ) * 2;
valid_conf = abs( valid_probs - 0.5 ) * 2;
test_conf = abs( test_probs - 0.5 ) * 2;

# save files
write.table( train_p_binary, 'madelon_train.resu', col.names = F, row.names = F, quote = F )
write.table( valid_p_binary, 'madelon_valid.resu', col.names = F, row.names = F, quote = F )
write.table( test_p_binary, 'madelon_test.resu', col.names = F, row.names = F, quote = F )

write.table( train_conf, 'madelon_train.conf', col.names = F, row.names = F, quote = F )
write.table( valid_conf, 'madelon_valid.conf', col.names = F, row.names = F, quote = F )
write.table( test_conf, 'madelon_test.conf', col.names = F, row.names = F, quote = F )

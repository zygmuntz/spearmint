language: PYTHON
name: "a4"

variable {
 name: "log_rbm_learning_rate"
 type: FLOAT
 size: 1
 min:  -10
 max:  0
}

# this doesn't work so well
#variable {
# name: "rbm_learning_rate"
# type: FLOAT
# size: 1
# min:  0.0001
# max:  1
#}


# Integer example
#
# variable {
#  name: "Y"
#  type: INT
#  size: 5
#  min:  -5
#  max:  5
# }

# Enumeration example
# 
# variable {
#  name: "Z"
#  type: ENUM
#  size: 3
#  options: "foo"
#  options: "bar"
#  options: "baz"
# }



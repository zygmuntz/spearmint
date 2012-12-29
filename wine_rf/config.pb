language: PYTHON
name: "wine_rf"

variable {
 name: "ntrees"
 type: INT
 size: 1
 min:  10
 max:  300
}

variable {
 name: "mtry"
 type: INT
 size: 1
 min:  1
 max:  11
}





#!/bin/bash
streaming.sh
hadoop fs -get prov
#prov data -> Harasser.csv
R CMD BATCH --args paint.R
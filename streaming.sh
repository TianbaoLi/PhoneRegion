#!/bin/bash
HADOOP_HOME=/usr/local/hadoop-2.4.1
INPUT_PATH=/input/userid-phone
OUTPUT_PATH=/output
echo "Input path: $INPUT_PATH"
echo "Output path: $OUTPUT_PATH"
 
$HADOOP_HOME/bin/hadoop fs -rm -r /input
$HADOOP_HOME/bin/hadoop fs -rm -r /output

$HADOOP_HOME/bin/hadoop fs -mkdir /input
$HADOOP_HOME/bin/hadoop fs -put userid-phone /input

${HADOOP_HOME}/bin/hadoop jar\
   ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-2.4.1.jar\
  -input $INPUT_PATH\
  -output $OUTPUT_PATH\
  -mapper "python mapper.py"\
  -reducer "python reducer.py"\
  -file mapper.py\
  -file reducer.py\
  -file area_city\
  -file city_prov\
  -file mobile_city/


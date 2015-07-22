#!/bin/bash
HADOOP_HOME=/usr/local/hadoop-2.4.1
INPUT_PATH=/input/userid-phone
OUTPUT_PATH=/output
echo "Input path: $INPUT_PATH"
echo "Output path: $OUTPUT_PATH"
 
$HADOOP_HOME/bin/hadoop fs -rm -r input
$HADOOP_HOME/bin/hadoop fs -rm -r output
$HADOOP_HOME/bin/hadoop fs -rm -r source

$HADOOP_HOME/bin/hadoop fs -mkdir /input
$HADOOP_HOME/bin/hadoop fs -put userid-phone /input

$HADOOP_HOME/bin/hadoop fs -mkdir /source
$HADOOP_HOME/bin/hadoop fs -put source/normalizer.py /source
$HADOOP_HOME/bin/hadoop fs -put mapper.py /source
$HADOOP_HOME/bin/hadoop fs -put reducer.py /source
$HADOOP_HOME/bin/hadoop fs -put source/area_city /source
$HADOOP_HOME/bin/hadoop fs -put source/city_prov /source
$HADOOP_HOME/bin/hadoop fs -mkdir /source/mobile_city
$HADOOP_HOME/bin/hadoop fs -put source/mobile_city/* /source/mobile_city

${HADOOP_HOME}/bin/hadoop jar\
   ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-2.4.1.jar\
  -D stream.non.zero.exit.is.failure=false\
  -input $INPUT_PATH\
  -output $OUTPUT_PATH\
  -mapper "python source/mapper.py"\
  -reducer "python source/reducer.py"\
  -cacheFile hdfs:/source#source

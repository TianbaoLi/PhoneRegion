#!/bin/bash
HADOOP_HOME=/usr/local/hadoop-2.4.1
INPUT_PATH=/user/toby.li/input/userid-phone
OUTPUT_PATH=/user/toby.li/output
echo "Input path: $INPUT_PATH"
echo "Output path: $OUTPUT_PATH"
 
$HADOOP_HOME/bin/hadoop fs -rm -r /user/toby.li/input
$HADOOP_HOME/bin/hadoop fs -rm -r /user/toby.li/output
$HADOOP_HOME/bin/hadoop fs -rm -r /user/toby.li/source

$HADOOP_HOME/bin/hadoop fs -mkdir /user/toby.li/input
$HADOOP_HOME/bin/hadoop fs -put userid-phone /user/toby.li/input

$HADOOP_HOME/bin/hadoop fs -mkdir /user/toby.li/source
$HADOOP_HOME/bin/hadoop fs -put source/normalizer.py /user/toby.li/source
$HADOOP_HOME/bin/hadoop fs -put mapper.py /user/toby.li/source
$HADOOP_HOME/bin/hadoop fs -put reducer.py /user/toby.li/source
$HADOOP_HOME/bin/hadoop fs -put source/area_city /user/toby.li/source
$HADOOP_HOME/bin/hadoop fs -put source/city_prov /user/toby.li/source
$HADOOP_HOME/bin/hadoop fs -mkdir /user/toby.li/source/mobile_city
$HADOOP_HOME/bin/hadoop fs -put source/mobile_city/* /user/toby.li/source/mobile_city

${HADOOP_HOME}/bin/hadoop jar\
   ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-2.4.1.jar\
  -D stream.non.zero.exit.is.failure=false\
  -input $INPUT_PATH\
  -output $OUTPUT_PATH\
  -mapper "python source/mapper.py"\
  -reducer "python source/reducer.py"\
  -cacheFile hdfs:/user/toby.li/source#source

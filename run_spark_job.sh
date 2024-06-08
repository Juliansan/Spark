#!/bin/bash

# Script to submit a Spark job to the local Spark cluster

# Check if the correct number of arguments is passed
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <application-file>"
  exit 1
fi

# Assign the first argument to APP_FILE variable
APP_FILE=$1

# Define the paths
SPARK_MASTER="spark://spark-master:7077"
APP_PATH="/opt/spark-apps/$APP_FILE"

# Determine file extension
EXT="${APP_FILE##*.}"

# Set SPARK_SUBMIT_CMD based on the file extension
if [ "$EXT" = "py" ]; then
  SPARK_SUBMIT_CMD="/opt/bitnami/spark/bin/spark-submit --master $SPARK_MASTER $APP_PATH"
elif [ "$EXT" = "jar" ]; then
  # If it is a jar file, we need to set the class name. Modify 'org.example.MySparkApp' to your main class
  MAIN_CLASS="org.example.MySparkApp"
  SPARK_SUBMIT_CMD="/opt/bitnami/spark/bin/spark-submit --class $MAIN_CLASS --master $SPARK_MASTER $APP_PATH"
else
  echo "Unsupported file type: $EXT. Please provide a .py or .jar file."
  exit 1
fi

# Run the Spark job
echo "Running Spark job: $APP_FILE"
docker exec -it spark-master $SPARK_SUBMIT_CMD

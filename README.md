# Spark Docker Setup

This project sets up a local Apache Spark cluster using Docker Compose. The setup includes a Spark master node and two worker nodes.

## Prerequisites

- Docker
- Docker Compose

## Getting Started

### 1. Clone the Repository

Clone this repository to your local machine:

```sh
git clone https://github.com/yourusername/spark-docker-setup.git
cd spark-docker-setup
```

### 2.Create folder structure

```sh
mkdir -p mnt/spark/apps
mkdir -p mnt/spark/data
```
- `mnt/spark/apps`: This directory is mapped to the /opt/spark-apps directory inside the Spark containers. Place your Spark application JAR files or Python scripts here.
- `mnt/spark/data`: This directory is mapped to the /opt/bitnami/spark/data directory inside the Spark containers. Use this directory to store any data files that your Spark applications will process.

### 3.Start & Stop the Docker Compose Services

#### Start
```sh
docker-compose up -d 
```
#### Stop
```sh
docker-compose down
```

### 4. Access the Spark Web UIs
Spark Master UI: http://localhost:8080
Spark Worker 1 UI: http://localhost:8081
Spark Worker 2 UI: http://localhost:8081

## How to submit you application 

### 1.(Scala/Java)
Place your JAR file in the mnt/spark/apps directory. For example:

```sh
cp /path/to/your/app/my-spark-app.jar mnt/spark/apps/

docker exec -it spark-master /opt/bitnami/spark/bin/spark-submit \
  --class org.example.MySparkApp \
  --master spark://spark-master:7077 \
  /opt/spark-apps/my-spark-app.jar
```

### 2.(PySpark)
Place your Python script in the mnt/spark/apps directory.
```sh
cp /path/to/your/app/my_spark_app.py mnt/spark/apps/

docker exec -it spark-master /opt/bitnami/spark/bin/spark-submit \
  --master spark://spark-master:7077 \
  /opt/spark-apps/my_spark_app.py
```
### 3. (run_spark_job.sh)
You can run also any spark job with the script `run_spark_job.sh`
```sh
chmod +x run_spark_job.sh

./run_spark_job.sh <name of the file> # does not need to contain full path, just the jar or script variable
```
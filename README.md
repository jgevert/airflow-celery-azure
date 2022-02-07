# airflow-celery-azure
This project will help you to initiate and install Apache Airflow with Celery Executor for a Docker Swarm cluster on AZURE.
Why is it important to mention AZURE? Because the log files will/can be stored in AZURE Blob Storage. Everything is already setup for that!
You only have to store the credentials in the Airflow UI when everything is running.

First of all you have to start the install script provided in the root directory of this project with two parameters:

- init or remove
- GIT=this or your GIT REPO

With the init parameter git, docker and some other packages will be installed. Additionally the Git repository from GIT=
will be cloned into the working directory. If the user of the machine is not airflow with /home/airflow this script will
make the folders necessary:

```
bash install.sh init GIT=https://github.com/jgevert/airflow-celery-azure
```

IMPORTANT: You have to init install.sh on every Airflow node regardless if it's a worker node or a manager node.
The file and directory structure is important.

For you RabbitMQ service you don't need to init install.sh

## Install poertainer.io on manager node
Since this porject will install Apache Airflow on a Docker Swarm cluster we have choosen to install portainer.io
on the manager nodes. Before starting `bash /home/airflow/airflow-celery-azure/install_file/install_portainer.sh` 
you have to make sure Docker Swarm hat been started: 
`docker swarm init`

You need the token on your screen to connect your worker nodes with the manager node.

After the installation you can access portainer.io via: http://YOUR_IP:9443

For additional information regarding the setup of portainer please visit: https://docs.portainer.io/v/ce-2.9/start/install/server/setup

### Management of Docker Swarm Token
Of cause you don't have to remember the join token of Docker Swarm. Just type:
```
docker swarm join-token worker # for worker nodes or
docker swarm join-token manager # for additional manager
```

## Airflow Services
### RabbitMQ
When everything is set up you can launch your first service: RabbitMQ
RabbitMQ is an in-memory-database that will be your queue for the scheduler/worker. That also means that RabbitMQ will connect your worker nodes with the scheduler/webserver!
You can start RabbitMQ from portainer.io on a worker node. BUT: you have to keep in mind the IP of that VM since this information has to be stored in airflow.cfg!
For a short overview of the ports and the Docker Build I'll put the shell command here:

```
docker run -d -rm -name rabbitmq \
    -e RABBITMQ_DEFAULT_USER=username \
    -e RABBITMQ_DEFAULT_PASS=password \
    -p 5672_5672 \
    -p 15672:15672 \
    rabbitmq:3.9-management
```
This RabbitMQ interface can be accessed via port 15672.

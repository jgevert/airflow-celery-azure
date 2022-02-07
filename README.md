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
on the manager nodes. Before starting `bash /home/airflow/airflow-celery-azure/install_portainer.sh` you
have to make sure Docker Swarm hat been started: `docker swarm init`
You need the token on your screen to connect your worker nodes with the manager node.

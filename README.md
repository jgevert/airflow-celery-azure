# airflow-celery-azure
This project will provide an Airflow infrastructure on basis of Docker containers.
The executor for this project is Celery. At the current state of this project AZURE blob storage is implemented for writing log files. In the future this will change probably to be more flexible.

## Start containers
The image is build this way that environment variables controll the start behaviour. That means if a user decides to start a scheduler this will be controlled via STARTUP:

`
docker run -d --rm --name airflow-scheduler -e STARTUP=scheduler jgevert/airflow-celery-azure:latest
`

The following STARTUP variables are possible:
- scheduler
- webserver
- flower
- worker

## Setup of environmental variables
Beside the STARTUP variable there are other necessary variables to make the cluster work properly:
- RESULT_BACKEND=db+ YOUR DATABASE CONNECTION STRING
- BROKER_URL=YOUR URL TO RABBITMQ
- FERNET_KEY=YOUR FERNET KEY
- SQL_ALCHEMY_CONN=YOUR CONNECTION URL TO META DATABASE
- FLOWER_USERNAME=YOUR USERNAME FOR FLOWER WEBSERVICE
- FLOWER_PASSWORD=YOUR PASSWORD FOR FLOWER WEBSERVICE
- GIT_URL=YOUR URL TO GIT REPO WHERE DAGS AND PLUGINS ARE LOCATED
- GIT_PASSWORD=YOUR PASSWORD TO ACCESS THE GIT REPO

### Git Repo
Due to the fact Docker containers are stateless and each worker node has to have a copy of all DAGs inside its own dags folder the Git Repo is important.
Via the Git repo each container downloads an entire copy of the DAGs permanently. I could have mounted one place of storage into every worker node but the 
maintenance would have become too complicated. That's why each worker container as well as the webserver download permanently the git repo.

### How to create a Fernet key?
For creating a Fernet key you need only a few lines of Python code:

`
from cryptography.fernet import Fernet

fernet_key = Fernet.generate_key()
print(fernet_key.decode())  # your fernet_key, keep it in secured place!
`

# airflow-celery-azure
This project will help you to initiate and install Apache Airflow with Celery Executor.
First of all you have to start the install script provided in the root directory of this project with two parameters:
- init or remove
- GIT=this or your GIT REPO
With the init parameter git, docker and some other packages will be installed. Additionally the Git repository from GIT=
will be cloned into the working directory. If the user of the machine is not airflow with /home/airflow this script will
make the folders necessary:
'''
bash install.sh init GIT=https://github.com/jgevert/airflow-celery-azure
'''

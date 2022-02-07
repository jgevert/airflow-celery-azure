#!/usr/bin/bash

if [ ! "$#" -eq "0" ]; then

	# Get Git Repo URL
	for subkey in $@ 
	do
		if [[ $subkey == GIT=* ]]; then
				GIT_REPO=${subkey/"GIT="/""}
				# Get repo name
				GIT_REPO_NAME=$(echo "$GIT_REPO" | awk -F'/' '{print $5}')
		fi
	done	

	case "$@" in    
		*init* )
			echo "Start to initialize Airflow base setup with Docker"

			# update apt-get
			sudo apt-get update -y && sudo apt-get upgrade -y

			# install docker base libaries
			sudo apt-get install \
			    ca-certificates \
			    curl \
			    gnupg \
			    lsb-release -y

			 # add Docker's official GPG key
			 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

			 # install stable repository of Docker
			 echo \
				  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
				  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

			# install Docker Engine
			sudo apt-get update -y
			sudo apt-get install docker-ce docker-ce-cli containerd.io -y

			# install git
			sudo apt-get install git -y

			# check if user airflow exist. It's important /home/airflow exists.
			USER_EXIST=$(grep -c '^airflow_test:' /etc/passwd)
			if [[ $USER_EXIST -eq 0 ]]
			then
				sudo mkdir /home/airflow_test
			fi

			# add current user to docker group
			sudo usermod -a -G docker $USER
			sudo chmod 666 /var/run/docker.sock

			# pull repository
			exec git clone $GIT_REPO --verbose;;

		 *remove* )
			LENGTH=${#GIT_REPO_NAME}
			if [ $LENGTH -ne 0 ]
			then
				sudo sudo apt-get remove docker-ce docker-ce-cli containerd.io
				exec sudo rm -rf /home/airflow/$GIT_REPO_NAME
			fi
	esac	 
fi
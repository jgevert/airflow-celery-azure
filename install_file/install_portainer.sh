#!/usr/bin/bash

echo This script will install portainer.io!
echo Please make sure on your VMs the ports 8000 and 9443 are exposed.
echo You have to make sure you have initialized Docker Swarm on your system.
echo The manager node 1 needs: docker swarm init
echo There you get a toke to connect other VMs as worker nodes to the cluster
echo On the other machines you must not install portainer!

curl -L https://downloads.portainer.io/portainer-agent-stack.yml \
    -o portainer-agent-stack.yml

docker stack deploy -c portainer-agent-stack.yml portainer

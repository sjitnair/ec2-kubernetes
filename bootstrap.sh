#!/bin/bash
#
cat <<FFE >> /tmp/docker_install.sh
#!/bin/bash
#Docker installation
echo "############This is user `whoami`############"
echo "############Started docker installation############"
sudo apt update && sudo apt install -y curl wget apt-transport-https
sudo apt install -y docker.io
sudo systemctl enable --now docker
usermod -aG docker ubuntu && newgrp docker
echo "############Finished docker installation############"
FFE

cat <<SFE >> /tmp/minikube_install.sh
echo "############This is user `whoami`############"
# Install kubectl
echo "############Started docker Minikube installation phase1 ############"
sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo rm -f minikube-linux-amd64
minikube version
echo "############Finished docker Minikube installation phase1 ############"
echo "############Started docker Minikube installation phase2 ############"
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
sudo rm kubectl
kubectl version --client
minikube start --driver=docker
minikube status
echo "############Finished docker Minikube installation phase2 ############"
SFE

chmod +x /tmp/docker_install.sh
/tmp/docker_install.sh  >> /tmp/package_install.log 2>&1


chown ubuntu:ubuntu /tmp/minikube_install.sh
chmod +x /tmp/minikube_install.sh
runuser -u ubuntu -- /tmp/minikube_install.sh >> /tmp/package_install.log 2>&1
sudo lsb_release -r
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo apt update
sudo apt-get update 
sudo apt-get upgrade
sudo apt install jenkins

sudo apt update --allow-insecure-repositories 

sudo apt install jenkins
sudo systemctl start jenkins.service
sudo apt update
sudo apt install jenkins
sudo apt install default-jre
sudo dpkg --configure -a

sudo su jenkins
sudo vi  /etc/sudoers
jenkins ALL=(ALL) NOPASSWD: ALL
aws configure
cd /var/lib/jenkins
cd ~
rm -rf .aws
## rotate creds
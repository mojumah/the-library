### On the Jenkins controller
sudo apt install openssh-client
### the -t ed25519 command enabled the launching of the jenkins agent
ssh-keygen -t ed25519
sudo apt install openssh-server 
sudo vi /etc/ssh/sshd_config
sudo systemctl restart ssh.service 
cat .ssh/id_rsa.pub >> /home/ubuntu/public_key 
mv /home/ubuntu/public_key id_rsa.pub
lsblk 
cd /media/ubuntu/WINDOWS\ USB/
cd Whale/
cp /home/ubuntu/id_rsa.pub .
### On the agent where you installed openssh-server
cat id_rsa.pub >> authorized_keys


### to rsync files from the jenkins agent to the web server, ssh connectivity must work between the jenkins agent and the web server/jenkins controller

### on the jenkins agent
ssh-keygen
cd /media/mo/WINDOWS\ USB/
cp /home/mo/.ssh/id_rsa.pub .

### on the web server/jenkins controller
touch authorized_keys
cat /media/ubuntu/WINDOWS\ USB/rsync-project/id_rsa.pub >> .ssh/authorized_keys
### On the Jenkins controller
sudo apt install openssh-client
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

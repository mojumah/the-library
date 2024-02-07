# This commands creates the public key that is in ssh_authorized_keys in the cloud-init scripts
openssl rsa -in library-key.pem -pubout > library-key.pub
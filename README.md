# SSH Keys
These are required to establish an SSH connection to the EC2 instance.
In AWS EC2 create a .pem file. The file name is passed as a parameter in the workflow command:

``aws cloudformation create-stack --stack-name whale --template-body file://whale.yaml --parameters ParameterKey=myKeyPair,ParameterValue=<your key name>``

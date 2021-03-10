docker image build --tag redmine-gitolite:4.1.1-passenger redmine-gitolite-docker

mkdir -p docker/{postgresql,redmine/{certs,config,etc_ssh,files,gitolite,plugins,public,ssh}}

# generate ssl keys
openssl req -x509 -newkey rsa:4096 -keyout docker/redmine/certs/key.pem -out docker/redmine/certs/cert.pem -days 365 -nodes \
		-subj "/C=US/ST=TS/L=Test/O=Redmine/OU=client/CN=`hostname -f`/emailAddress=test@example.com"



git clone -b stable git://github.com/alphanodes/additionals.git docker/redmine/plugins/additionals
cp sshd_config docker/redmine/etc_ssh/
ssh-keygen -f docker/redmine/etc_ssh/ssh_host_rsa_key -N '' -t rsa


sudo chown 106:107 -R docker/redmine/gitolite
sudo chown 999:999 -R docker/redmine/config
sudo chown 999:999 -R docker/redmine/files
sudo chown 999:999 -R docker/redmine/plugins
sudo chown 999:999 -R docker/redmine/public
sudo chown 999:999 -R docker/redmine/ssh
sudo chown 999:999 -R docker/redmine/certs

docker-compose up -d

docker container exec -it redmine_git_hosting_dev_env_redmine_1 /bin/bash /sbin/docker-configure.sh

docker-compose down

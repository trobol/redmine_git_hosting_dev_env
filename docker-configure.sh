
#run as root

# make sure /etc/ssh has the right contents
apt-get install --reinstall openssh

# generate ssl keys
openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/redmine/key.pem -out /etc/ssl/redmine/cert.pem -days 365 -nodes \
		-subj "/C=US/ST=TS/L=Test/O=Redmine/OU=client/CN=`hostname -f`/emailAddress=test@example.com"


su - redmine
cd ~
ssh-keygen -m PEM -N '' -f .ssh/redmine_gitolite_admin_id_rsa
cp .ssh/redmine_gitolite_admin_id_rsa.pub /home/git
exit

su - git
cd ~
gitolite setup -pk redmine_gitolite_admin_id_rsa.pub
exit


su - redmine
redmine$ ssh -p 2222 -i ~/.ssh/redmine_gitolite_admin_id_rsa git@localhost info
exit

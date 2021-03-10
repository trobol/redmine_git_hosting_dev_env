
#run as root


su redmine -c "ssh-keygen -m PEM -N '' -f /home/redmine/.ssh/redmine_gitolite_admin_id_rsa"

cp /home/redmine/.ssh/redmine_gitolite_admin_id_rsa.pub /home/git
chown git /home/git/redmine_gitolite_admin_id_rsa.pub

su git -c "cd ~; gitolite setup -pk redmine_gitolite_admin_id_rsa.pub"


su redmine -c "ssh -oStrictHostKeyChecking=no -p 2222 -i ~/.ssh/redmine_gitolite_admin_id_rsa git@localhost info"

run ./configure

sometimes inside the container you need to run

ssh -oStrictHostKeyChecking=no -p 2222 -i ~/.ssh/redmine_gitolite_admin_id_rsa git@localhost info


Gitolite must accept hook keys

root$ su - git
git$ vi (or nano) .gitolite.rc

## Look for GIT_CONFIG_KEYS and make it look like :
GIT_CONFIG_KEYS  =>  '.*',

## Enable local code directory
LOCAL_CODE       =>  "$ENV{HOME}/local"

## then save and exit



set ssh key paths in redmine_git_hosting settings


run migrations


for more look at readme inside redmine-gitolite

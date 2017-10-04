# flask-ansible-example

This is an example Flask app, ready to be deployed with Ansible.

The included playbook:
- installs apt packages and Python utils
- clones the repo and installs Python requirements in a virtualenv
- configures gunicorn, nginx, ufw and systemd
- enables and starts services
- get the url and check for the expected response

The `deploy.yml` playbook is modeled after the manual steps discussed in this [digitalocean article](https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-16-04) using a Ubuntu [ML](https://www.digitalocean.com/community/tutorials/how-to-use-the-machine-learning-one-click-install-image-on-digitalocean) instance.

## Prerequisites

Install Ansible.
```
pip install ansible
```

## Deploying the app

Edit `hosts` and deploy the app.
```
nano hosts
ansible-playbook deploy.yml
```

## Debugging

Test connection with the host.
```
ansible webservers -m ping
```

If needed, configure the ssh agent.
```
ssh-add ~/.ssh/example_rsa
```

Rerun the playbook with verbosity.
```
ansible-playbook deploy.yml -vvvv
```

Check the logs.
```
journalctl -xe
```

Allow port 5000 and activate the virtualenv.
```
sudo ufw allow 5000
source env/bin/activate
export FLASK_GN_HOSTNAME=example.com
```

Test Flask.
```
python app.py
open http://$FLASK_GN_HOSTNAME:5000
```

Test gunicorn.
```
gunicorn --bind 0.0.0.0:5000 wsgi:app
open http://$FLASK_GN_HOSTNAME:5000
```

Check for nginx issues.
```
sudo nginx -t
```

Check ports in use.
```
netstat -plnt
```

Run gunicorn in debug mode.
```
gunicorn --workers 3 --log-level debug --error-logfile error.log \
    --bind unix:flask-ansible-example.sock -m 007 wsgi:app
```

Check facts.
```
ansible webservers -m setup
```

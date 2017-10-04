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

Test connection with the host. If needed, configure the ssh agent.
```
ansible webservers -m ping
ssh-add ~/.ssh/example_rsa
```

Rerun the playbook with verbosity.
```
ansible-playbook deploy.yml -vvvv
```

Check the logs on the host.
```
journalctl -xe
journalctl -u nginx
journalctl -u flask-ansible-example
```

Check the systemd status of the services on the host.
```
sudo systemctl status nginx
sudo systemctl status flask-ansible-example.service
```

Test the app.
```
sudo ufw allow 5000  # to undo: sudo ufw delete allow 5000
source env/bin/activate
python app.py
open http://HOSTNAME:5000
```
If that doesn't work, try running the Flask app with `app.run(debug=True)`

Test gunicorn.
```
gunicorn --bind 0.0.0.0:5000 wsgi:app
```

Test gunicorn in debug mode.
```
gunicorn --log-level debug --error-logfile error.log \
    --bind 0.0.0.0:5000 wsgi:app
```

Test gunicorn in debug mode binding to socket.
```
gunicorn --workers 3 --log-level deketbug --error-logfile error.log \
    --bind unix:flask-ansible-example.sock -m 007 wsgi:app
```

Run nginx tests.
```
sudo nginx -t
```

Check ports in use.
```
netstat -plnt
```

Check all active connections.
```
netstat -a
```

If need be, kill any processes using a specific port.
```
sudo fuser -k 80/tcp
```

Check facts.
```
ansible webservers -m setup
```

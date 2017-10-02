# ansible flask gunicorn nginx systemd example

This is an example Flask app, ready to be deployed using Ansible.

The `deploy.yml` is adapted from the manual steps discussed in this [digitalocean article](https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-16-04) using a Ubuntu [ML (beta)](https://www.digitalocean.com/community/tutorials/how-to-use-the-machine-learning-one-click-install-image-on-digitalocean) instance.

## Deploying

Edit `hosts` and deploy the app.
```
nano hosts
pip install ansible
ansible-playbook deploy.yml -v
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

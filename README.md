# ansible flask gunicorn nginx systemd example

This is an example Flask app deployed to a Ubuntu host using Ansible. The `playbook.yml` is adapted from this [digitalocean article](https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-16-04) using an [ML (beta)](https://www.digitalocean.com/community/tutorials/how-to-use-the-machine-learning-one-click-install-image-on-digitalocean) instance.

## Getting started

Deploy the app.
```
pip install ansible
ansible-playbook deploy.yml -i xxx.xxx.xx.xxx ansible_ssh_user=science -v
```

## Debugging

Optionally create a hosts inventory file.
```
echo '[webservers]' > hosts
echo 'HOSTNAME ansible_ssh_user=USERNAME'>> hosts
```

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

# flask-gunicorn-nginx example

Adapted from this [digitalocean article](https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-16-04).


```
sudo apt-get update
sudo apt-get install python-pip python-dev nginx

sudo pip install virtualenv


sudo apt-get update
sudo apt-get install python3-pip python3-dev nginx

sudo pip3 install virtualenv


virtualenv myprojectenv
source myprojectenv/bin/activate


pip install flask gunicorn

python app.py
http://server_domain_or_IP:5000


sudo ufw allow 5000
gunicorn --bind 0.0.0.0:5000 wsgi:app
http://server_domain_or_IP:5000


sudo nano /etc/systemd/system/myproject.service



[Unit]
Description=Gunicorn instance to serve myproject
After=network.target

[Service]
User=sammy
Group=www-data
WorkingDirectory=/home/sammy/myproject
Environment="PATH=/home/sammy/myproject/myprojectenv/bin"
ExecStart=/home/sammy/myproject/myprojectenv/bin/gunicorn --workers 3 --bind unix:myproject.sock -m 007 wsgi:app

[Install]
WantedBy=multi-user.target



sudo systemctl start myproject
sudo systemctl enable myproject



sudo nano /etc/nginx/sites-available/myproject



server {
    listen 80;
    server_name server_domain_or_IP;

    location / {
        include proxy_params;
        proxy_pass http://unix:/home/sammy/myproject/myproject.sock;
    }
}



sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled



sudo nginx -t

If this returns without indicating any issues, we can restart the Nginx process to read the our new config:

sudo systemctl restart nginx

The last thing we need to do is adjust our firewall again. We no longer need access through port 5000, so we can remove that rule. We can then allow access to the Nginx server:

sudo ufw delete allow 5000
sudo ufw allow 'Nginx Full'
You should now be able to go to your server's domain name or IP address in your web browser:

http://server_domain_or_IP





# tileserver
alias tenv='source /home/science/projects/tileserver-env/bin/activate'
alias tstart="tenv && cd /home/science/projects/tileserver && python /tileserver/__init__.py config.yaml"
alias tcheck='curl http://localhost:8080/all/16/19293/24641.json'

# misc
alias bashrc="nano /home/science/.bashrc && source /home/science/.bashrc"
alias ports='sudo netstat -plnt'
# kill procs  # sudo fuser -k 80/tcp
# find / -name lighttpd.conf
# ps aux | grep lighttpd
statics='sudo tree /var/www/'
# sudo systemctl disable lighttpd.service



```

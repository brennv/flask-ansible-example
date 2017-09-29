sudo nano /etc/nginx/sites-available/myproject







sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled



sudo nginx -t

If this returns without indicating any issues, we can restart the Nginx process to read the our new config:

sudo systemctl restart nginx

The last thing we need to do is adjust our firewall again. We no longer need access through port 5000, so we can remove that rule. We can then allow access to the Nginx server:

sudo ufw delete allow 5000
sudo ufw allow 'Nginx Full'
You should now be able to go to your server's domain name or IP address in your web browser:

http://server_domain_or_IP

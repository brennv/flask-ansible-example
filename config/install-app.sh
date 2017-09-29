virtualenv myprojectenv
source myprojectenv/bin/activate


pip install flask gunicorn

python app.py
http://server_domain_or_IP:5000


sudo ufw allow 5000
gunicorn --bind 0.0.0.0:5000 wsgi:app
http://server_domain_or_IP:5000

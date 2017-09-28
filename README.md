# flask-gunicorn-nginx example




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



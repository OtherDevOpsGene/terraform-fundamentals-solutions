#! /bin/bash
DOCROOT=/home/ubuntu
PORT=8080

nohup busybox httpd -f -h ${DOCROOT} -p ${PORT} &

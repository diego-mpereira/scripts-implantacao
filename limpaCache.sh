#!/bin/sh
sudo su 
rm -r .cache/google-chrome*/* 
rm -r .config/google-chrome*/*
cd /opt/videosoft/vs-autopag-se/
service vs-autopag-se stop
timeout 40 node/bin/node vs-autopag-se.js
service vs-autopag-se start

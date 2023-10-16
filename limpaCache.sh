#!/bin/sh
sudo rm -r .cache/google-chrome*/* 
sudo rm -r .config/google-chrome*/*
cd /opt/videosoft/vs-autopag-se/
sudo service vs-autopag-se stop
sudo timeout 40 node/bin/node vs-autopag-se.js
sudo service vs-autopag-se start

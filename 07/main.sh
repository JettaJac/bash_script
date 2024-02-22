#!/bin/bash

chmod +x ins.sh

sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server
# http://localhost:3000


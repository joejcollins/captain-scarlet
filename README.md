# Protecting Your Work

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#github.com/joejcollins/captain-scarlet)

rserver --server-daemonize 0 --auth-none 1

sudo rserver --server-daemonize 0 --auth-none 1 --server-user rstudio-server

$ cat disable_auth_rserver.conf 
rsession-which-r=/usr/local/bin/R
auth-none=1
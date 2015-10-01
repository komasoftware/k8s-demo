#!/bin/bash
# install [direnv](http://direnv.net/)
brew install direnv
# install [gcloud](https://cloud.google.com/sdk/#Quick_Start)
curl https://sdk.cloud.google.com | bash
exec -l $SHELL
# setup bashrc with includes (.envrc using direnv)
gcloud auth login

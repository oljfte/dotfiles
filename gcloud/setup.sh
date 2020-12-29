#!/bin/zsh

if [ `command -v gcloud >/dev/null` ]; then
    cd $HOME
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-320.0.0-darwin-x86_64.tar.gz
    tar xvf google-cloud-sdk-320.0.0-darwin-x86_64.tar.gz
    gcloud init
fi

#!/bin/bash

echo "Installing Clojure"

URL=$(curl https://clojure.org/guides/getting_started |\
      grep "curl -O " |\
      sed 's/.*curl -O //')


sudo apt install -y bash curl rlwrap
curl "$URL" | sudo bash


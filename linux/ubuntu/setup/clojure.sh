#!/bin/bash

echo "Installing Clojure"

URL=$(curl https://clojure.org/guides/install_clojure |\
      grep "curl -O " |\
      sed 's/.*curl -O //' |\
      grep linux)


sudo apt install -y bash curl rlwrap
curl "$URL" | sudo bash


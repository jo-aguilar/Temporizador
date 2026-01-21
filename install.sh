#!/usr/bin/env bash

cp tempo.raku tempo
chmod +x tempo
sudo mv -i ./tempo /usr/local/bin/tempo
echo "[!!!] ./tempo instalado com sucesso"

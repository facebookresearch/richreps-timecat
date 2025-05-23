#!/bin/bash
# if uv is not installed, uncomment following line to install 
# curl -LsSf https://astral.sh/uv/install.sh | sh

uv venv
source .venv/bin/activate
uv sync

# add line to .bashrc 
export CAT_EXP_HOME=/private/home/axyang/mixtures/mixture_richreps
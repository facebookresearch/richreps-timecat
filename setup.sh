#!/bin/bash
# Copyright (c) Meta Platforms, Inc. and affiliates.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

# if uv is not installed, uncomment following line to install 
# curl -LsSf https://astral.sh/uv/install.sh | sh

uv venv
source .venv/bin/activate
uv sync

# add line to .bashrc 
export CAT_EXP_HOME=$(pwd)
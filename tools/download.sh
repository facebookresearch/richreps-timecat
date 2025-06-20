#!/bin/bash
# Copyright (c) Meta Platforms, Inc. and affiliates.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
set -x
mkdir -p 'checkpoints/supervised_pretrain'
wget https://dl.fbaipublicfiles.com/richreps-timecat/ckpt_resnet50_sfadamw_imagenet1k_supervised.tar.gz -P 'checkpoints/supervised_pretrain'
gunzip -f checkpoints/supervised_pretrain/ckpt_resnet50_sfadamw_imagenet1k_supervised.tar.gz
tar -xvf checkpoints/supervised_pretrain/ckpt_resnet50_sfadamw_imagenet1k_supervised.tar -C checkpoints/supervised_pretrain/
mv checkpoints/supervised_pretrain/ckpt_resnet50_sfadamw_imagenet1k_supervised checkpoints/supervised_pretrain/resnet50_sfadamw_imagenet1k_supervised
# uncomment line below to remove tar file
# rm checkpoints/supervised_pretrain/ckpt_resnet50_sfadamw_imagenet1k_supervised.tar

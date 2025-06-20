#!/bin/bash
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --job-name=run_cifar_supervised_resnet50_sf_lineareval
#SBATCH --time=6:00:00
#SBATCH --array=0-59
#SBATCH --mem=64G
#SBATCH --error=slurm/%A_%a.out
#SBATCH --output=slurm/%A_%a.out

# Copyright (c) Meta Platforms, Inc. and affiliates.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
i=0;
for wd in 1e-2 5e-2 1e-4 5e-4 1e-3 5e-3;
do 
	for run in 0 1 2 3 4;
	do 
		for model in resnet50_sfadamw;
		do 
			for data in cifar10 cifar100; 
			do 	
				wds[$i]=$wd;
				runs[$i]=$run; 
				models[$i]=$model;
				datas[$i]=$data;
				bs[$i]=256;
				i=$(($i+1));
			done 
		done
	done 
done 

set -x
final_model=${models[$SLURM_ARRAY_TASK_ID]}
final_bs=${bs[$SLURM_ARRAY_TASK_ID]}
final_data=${datas[$SLURM_ARRAY_TASK_ID]}
final_run=${runs[$SLURM_ARRAY_TASK_ID]}
final_wd=${wds[$SLURM_ARRAY_TASK_ID]}

resdir=results/supervised/imagenet/transfer/lineareval_seer/${final_data}_${final_wd}/${final_model}/run${final_run}
mkdir ${resdir} -p

python supervised.py  --dump_path ${resdir} \
--tag supervisedimagenet_${final_model}_run${final_run} \
--data_name ${final_data}  --classifier linear --batch_size ${final_bs}  --data_path data --debug  --wd ${final_wd} \
--exp_mode lineareval --nesterov True --wd_skip_bn True \
--headinit normal --tf_name 224px --use_bn True  --eval_freq 1

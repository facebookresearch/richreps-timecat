#!/bin/bash
#SBATCH --nodes=1
#SBATCH --gpus-per-node=8
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=8
#SBATCH --job-name=cat_inat_supervised_resnet50_sf_lineareval
#SBATCH --time=5:00:00
#SBATCH --array=0-3
#SBATCH --mem=64G
#SBATCH --error=slurm/%A_%a.out
#SBATCH --output=slurm/%A_%a.out

# Copyright (c) Meta Platforms, Inc. and affiliates.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
i=0;
for wd in 1e-6 1e-5 1e-4;
do 
    for exp in 2_step200k 4_step100k 5_step80k;
    do
        for model in resnet50_sfadamw;
        do
            for data in inaturalist18;
            do
                wds[$i]=$wd;
                exps[$i]=$exp;
                models[$i]=$model;
                datas[$i]=$data;
                bs[$i]=32;
                i=$(($i+1));
            done
        done
    done
done

set -x
final_model=${models[$SLURM_ARRAY_TASK_ID]}
final_bs=${bs[$SLURM_ARRAY_TASK_ID]}
final_data=${datas[$SLURM_ARRAY_TASK_ID]}
final_exp=${exps[$SLURM_ARRAY_TASK_ID]}
final_wd=${wds[$SLURM_ARRAY_TASK_ID]}

resdir=results/supervised/imagenet/transfer/lineareval/${final_data}_${final_wd}/${final_model}_cat${final_exp}
mkdir ${resdir} -p

srun  --output=${resdir}/%A_%a.out --error=${resdir}/%A_%a.out python  supervised.py  --dump_path ${resdir}  \
--tag supervisedimagenet_${final_model}_${final_exp} \
--data_name ${final_data}  --classifier linear --batch_size ${final_bs}  --data_path data --debug  --wd ${final_wd} \
--exp_mode lineareval --nesterov True --wd_skip_bn True \
--headinit normal  --use_bn True  --eval_freq 1 --sync_bn True || scontrol requeue $SLURM_JOB_ID
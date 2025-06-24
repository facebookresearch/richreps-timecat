# These Are Not All the Features You Are Looking For: A Fundamental Bottleneck in Supervised Pretraining
### Pytorch Implementation of Time-Cat Experiments
Xingyu Alice Yang, [Jianyu Zhang](https://www.jianyuzhang.com/),  [Léon Bottou](https://leon.bottou.org/)

<p align="center" width="500" style="background-color: white; padding: 0px; color: #333333;">
  <image src=figures/time-cat-diagram-v2.png>
  <!-- .slide: data-background-color="white" -->
  <em><strong>Figure 1: Richer Feature Representations via Concatenation during Fixed-Time Pretraining</strong></em>
</p>


### [[Paper]](https://arxiv.org/abs/2506.18221)

> <p align="center">  <figcaption align="center"><b></b></figcaption>
> Transfer learning is a cornerstone of modern machine learning, promising a way to adapt models pretrained on a broad mix of data to new tasks with minimal new data. However, a significant challenge remains in ensuring that transferred features are sufficient to handle unseen datasets, amplified by the difficulty of quantifying whether two tasks are "related". To address these challenges, we evaluate model transfer from a pretraining mixture to each of its component tasks, assessing whether pretrained features can match the performance of task-specific direct training. We identify a fundamental limitation in deep learning models -- an "information saturation bottleneck" -- where networks fail to learn new features once they encode similar competing features during training. When restricted to learning only a subset of key features during pretraining, models will permanently lose critical features for transfer and perform inconsistently on data distributions, even components of the training mixture. Empirical evidence from published studies suggests that this phenomenon is pervasive in deep learning architectures -- factors such as data distribution or ordering affect the features that current representation learning methods can learn over time. This study suggests that relying solely on large-scale networks may not be as effective as focusing on task-specific training, when available. We propose richer feature representations as a potential solution to better generalize across new datasets and, specifically, present existing methods alongside a novel approach, the initial steps towards addressing this challenge.
> 


<br>


## Installation
### Set Up Python Virtual Environment
We provide instructons to set up a virtual environment using `uv`, specified by `pyproject.yaml`.
1. Clone this repository
```
git clone https://github.com/richreps-timecat
cd richreps-timecat
```
2. If not already installed, set up `uv` with
```
curl -LsSf https://astral.sh/uv/install.sh | sh
```
3. Set up environment
```
uv venv
source .venv/bin/activate
uv sync
```
Activate your new environment using
```
source ./.venv/bin/activate
```
### Quick Start
```
chmod +x setup.sh
./setup.sh
```

### (Optional) Shortcuts
To check experiment results from anywhere, add following lines to your `~/.bashrc` file 
```
export CAT_EXP_HOME="/path/to/your/downloaded/repo"
alias 'acc1=$CAT_EXP_HOME/top1acc_final.sh'
alias 'acc1sofar=$CAT_EXP_HOME/top1acc_sofar.sh'
```
And run
```
source ~/.bashrc
```

You can specify **patterns** to filter across all your experiments and view their  **current accuracy** 
```
./acc1_sofar.sh <pattern_1> <pattern_2>  ... <pattern_k>
```
Or their **final accuracy**  
```
./acc1_final.sh <pattern_1> <pattern_2>  ... <pattern_k>
```

## Checkpoints
### Download (ImageNet1k) pretrained checkpoints:
You can get pretrained checkpoints by
* downloading them using the script `./tools/download.sh` 
* training from scratch using the [AlgoPerf repository](https://github.com/mlcommons/algorithmic-efficiency/tree/main#citing-algoperf-benchmark)


## Datasets
We evaluate transfer using the following datasets: 
- [ImageNet-1K [~130 GB]](https://www.image-net.org/index.php) 
- [iNaturalist18 [120GB]](https://ml-inat-competition-datasets.s3.amazonaws.com/2018/train_val2018.tar.gz)
  - [Training Annotations [26MB]](https://ml-inat-competition-datasets.s3.amazonaws.com/2018/train2018.json.tar.gz)
  - [Validation annotations [26MB]](https://ml-inat-competition-datasets.s3.amazonaws.com/2018/val2018.json.tar.gz)
- [CIFAR10,CIFAR100 [178MB]](https://www.cs.toronto.edu/~kriz/cifar.html)


Download and extract `ImageNet-1k` and `iNaturalist18` datasets to `data/imagenet` and `data/inaturalist18`. The resulting folder structure should be:

```
📦 richerfeatures
 ┣ 📂data
 ┃ ┣ 📂cifar
 ┃ ┣ 📂imagenet
 ┃ ┃ ┣ 📂train
 ┃ ┃ ┗ 📂val
 ┃ ┣ 📂inaturalist18
 ┃ ┃   ┣ 📂train_val2018
 ┃ ┃   ┣📜train2018.json
 ┃ ┃   ┗📜val2018.json
```


## Supervised Transfer Learning (ResNet50)


### Download (ImageNet1k) pretrained checkpoints:
You can get pretrained checkpoints either:
- by automatically download according to ```python tools/download.py``` or
- by manually download according to [download_checkpoint.md](download_checkpoint.md) or 
- by training from scratch according to [download_checkpoint.md](downloaad_checkpoint.md)


The resulting folder structure should be: 
```
📦 richerfeatures
 ┣ 📂checkpoints
 ┃ ┣ 📂supervised_pretrain
 ┃ ┃ ┣ 📂resnet50_sfadamw
 ┃ ┃ ┃ ┣ 📂checkpoints_stepfull
 ┃ ┃ ┃ ┣ ┣📜 checkpoint_run0.pth.tar 
 ┃ ┃ ┃ ┃ ┣    ...            
 ┃ ┃ ┃ ┃ ┗📜 checkpoint_run4.pth.tar 
 ┃ ┃ ┃ ┣ 📂checkpoints_step200
 ┃ ┃ ┃ ┣ ┣📜 checkpoint_run0.pth.tar 
 ┃ ┃ ┃ ┃ ┗📜 checkpoint_run1.pth.tar 
 ┃ ┃ ┃ ┣ 📂checkpoints_step100
 ┃ ┃ ┃ ┣ ┣📜 checkpoint_run0.pth.tar 
 ┃ ┃ ┃ ┃ ┣    ...            
 ┃ ┃ ┃ ┃ ┗📜 checkpoint_run3.pth.tar 
 ┃ ┃ ┃ ┣ 📂checkpoints_step80
 ┃ ┃ ┃ ┣ ┣📜 checkpoint_run0.pth.tar 
 ┃ ┃ ┃ ┃ ┣    ...            
 ┃ ┃ ┃ ┃ ┗📜 checkpoint_run4.pth.tar 
```



### Transfer via Linear Probing

We **concatenate** multiple sets of ResNet50 features (separately pretrained on ImageNet1k) into one larger model and **transfer** to CIFAR10, CIFAR100, and iNaturalist18 by retraining a final classification layer.

<p align="center" width="500" style="background-color: white; padding: 0px; color: #333333;">
  <image src=figures/resnet-catn-results.png>
  <em>Figure 2: An ensemble of ResNet50 models pretrained on ImageNet for 400 total epochs (using different random seeds) achieves superior transfer performance compared to a single ResNet50 model trained for an additional 50 epochs. </em>
</p>


## Citation
If you find this code useful for your research, please consider citing our work:
```
@misc{yang2025features,
    title={These are Not All the Features You are Looking For: A Fundamental Bottleneck In Supervised Pretraining},
    author={Xingyu Alice Yang and Jianyu Zhang and Léon Bottou},
    year={2025},
    eprint={2506.18221},
    archivePrefix={arXiv},
    primaryClass={cs.LG}
}
```

## License
This repo is licensed with the CC-BY-NC 4.0 license, as found in the LICENSE file.
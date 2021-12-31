#!/bin/bash

# CIFAR experiments
# Label noise levels
# c=0.2
c=0
datasets=CIFAR10
for model in resnet20
do
	CUDA_VISIBLE_DEVICES=0 python -u train_sgd.py --datasets $datasets --lr 0.1 --corrupt $c --arch=$model --epochs=150  --save-dir=save_labelnoise$c\_$model |& tee -a log_$model
    
    CUDA_VISIBLE_DEVICES=0 python -u train_pbfgs.py --epochs 20 --datasets $datasets --corrupt $c --params_start 0 --params_end 81  --batch-size 1024   --n_components 40 --arch=$model  --save-dir=save_labelnoise$c\_$model |& tee -a log_$model 

    CUDA_VISIBLE_DEVICES=0 python -u train_psgd.py --epochs 40 --datasets $datasets --lr 1 --corrupt $c --params_start 0 --params_end 81  --batch-size 128  --n_components 40 --arch=$model  --save-dir=save_labelnoise$c\_$model |& tee -a log_$model 
done


# ImageNet experiments
# c=0
# datasets=ImageNet
# for model in resnet18
# do
# 	CUDA_VISIBLE_DEVICES=0,1,2,3  python3 main.py -a $model --epochs 90  --dist-url 'tcp://127.0.0.1:8888' --dist-backend 'nccl' --multiprocessing-distributed --world-size 1 --rank 0 /home/datasets/ILSVRC2012

# 	CUDA_VISIBLE_DEVICES=0,1,2 python -u train_pbfgs_imagenet.py --epochs 4 --print-freq 1000 --datasets $datasets --corrupt $c --alpha 0 --params_start 0 --params_end 241  --batch-size 256  --n_components 120 --arch=$model  --save-dir=save_$model |& tee -a log_$model 
# done


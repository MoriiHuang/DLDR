c=0
datasets=CIFAR10
model=resnet110
pretrain='output/sgd-CIFAR10-resnet110-128-0.1-20211231-162234'
CUDA_VISIBLE_DEVICES=2 python -u train_psgd.py \
    --epochs=40 \
    --datasets=$datasets \
    --lr=1 \
    --corrupt=$c \
    --params_start=0 \
    --params_end=40 \
    --batch_size=128 \
    --n_components=20 \
    --arch=$model \
    --pretrain_dir=$pretrain \
    --save_dir=output/${datasets}/psgd \
    # --log_wandb \
    # --project=DLDR
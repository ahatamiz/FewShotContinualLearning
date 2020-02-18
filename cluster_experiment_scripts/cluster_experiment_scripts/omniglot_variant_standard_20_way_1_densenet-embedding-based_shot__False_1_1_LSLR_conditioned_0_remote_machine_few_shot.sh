#!/bin/sh
export CUDA_HOME=/opt/cuda-9.0.176.1/

export CUDNN_HOME=/opt/cuDNN-7.0/

export STUDENT_ID=$(whoami)

export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH

export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH

export CPATH=${CUDNN_HOME}/include:$CPATH

export PATH=${CUDA_HOME}/bin:${PATH}

export PYTHON_PATH=$PATH

export GPU_ID=$1
export CUDA_VISIBLE_DEVICES=$GPU_ID
echo $GPU_ID

cd ..
export DATASET_DIR="../datasets/"
# Activate the relevant virtual environment:
#python dataset_tools.py --name_of_args_json_file experiment_config/umaml_maml_omniglot_characters_20_1_seed_1.json
python train_continual_learning_few_shot_system.py --name_of_args_json_file experiment_config/omniglot_variant_standard_20_way_1_densenet-embedding-based_shot__False_1_1_LSLR_conditioned_0.json --gpu_to_use $GPU_ID
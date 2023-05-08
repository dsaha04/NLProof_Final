#!/bin/bash
#SBATCH --job-name=test     # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=32        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:1
#SBATCH --constraint=a100
#SBATCH --mem-per-cpu=12G         # memory per cpu-core (4G is default)
#SBATCH --time=48:00:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send email if job fails
#SBATCH --mail-user=kh20@princeton.edu

module purge

source ~/.bashrc
conda activate nlproofs

python main.py validate --config cli_task1_single_shot_t5-small.yaml --ckpt_path /scratch/network/kh20/NLProof_Final/prover/lightning_logs/version_1759676/checkpoints/epoch=19-step=16940.ckpt --model.verifier_weight 0.5 --model.verifier_ckpt /scratch/network/kh20/NLProof_Final/verifier/lightning_logs/version_1759680/checkpoints/epoch=49-step=92850.ckpt --model.proof_search true --trainer.limit_val_batches 1.0

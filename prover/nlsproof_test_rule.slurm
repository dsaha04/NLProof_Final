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
#SBATCH --mail-user=dsaha@princeton.edu

module purge

source ~/.bashrc
conda activate nlproofs
cd /scratch/network/dsaha/NLProof_Final/prover

python main.py test --config cli_ruletaker_stepwise_t5-small.yaml --ckpt_path /scratch/network/dsaha/NLProof_Final/prover/lightning_logs/version_1757557/checkpoints/epoch=19-step=16940.ckpt --model.verifier_weight 0.5 --model.verifier_ckpt /scratch/network/dsaha/NLProof_Final/verifier/lightning_logs/version_1758252/checkpoints/epoch=49-step=92850.ckpt --model.proof_search true

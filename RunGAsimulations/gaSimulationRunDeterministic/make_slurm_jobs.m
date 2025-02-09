for i=1:800
    mfile_name=['batch_run_' int2str(i) '.m'];
    job_name=['job_' int2str(i) '.sh'];
    
    j_fid=fopen(job_name,'w');
    fprintf(j_fid,'#!/bin/bash \n');
    fprintf(j_fid,'#SBATCH --export=ALL \n');
    fprintf(j_fid,'#SBATCH -D . \n');
    fprintf(j_fid,'#SBATCH -p pq \n');
    fprintf(j_fid,'#SBATCH --time=14:00:00 \n');
    fprintf(j_fid,'#SBATCH -A Research_Project-****** \n');
    fprintf(j_fid,'#SBATCH --nodes=1 \n');
    fprintf(j_fid,'#SBATCH --ntasks-per-node=8 \n'); 
    fprintf(j_fid,'#SBATCH --mail-type=END \n');
    fprintf(j_fid,'#SBATCH --mail-user=*****@exeter.ac.uk \n');
    fprintf(j_fid,'module load MATLAB/2017a \n');
    fprintf(j_fid,'echo Running on ; hostname \n');
    fprintf(j_fid,'mkdir ~/.matlab/$(($SLURM_JOB_ID-1000000)) \n');
    fprintf(j_fid,['matlab -nosplash -nodesktop -r "batch_run_' int2str(i) '($(($SLURM_JOB_ID-1000000)));quit;" \n']);
    fprintf(j_fid,'rm -r ~/.matlab/$(($SLURM_JOB_ID-1000000))');
    fclose(j_fid);
    
    m_fid=fopen(mfile_name,'w');
    fprintf(m_fid,['function batch_run_' int2str(i) '(ii) \n']);
% parpool
    fprintf(m_fid,'delete(gcp(''nocreate'')); \n');
    fprintf(m_fid,'pc=parcluster; \n');
    fprintf(m_fid,['pc.JobStorageLocation=sprintf(''~/.matlab/%%g'',ii); \n']);
    fprintf(m_fid,'pc.NumWorkers=8; \n');
    fprintf(m_fid,'parpool(pc,pc.NumWorkers); \n');
    fprintf(m_fid,'ps = parallel.Settings; \n');
    fprintf(m_fid,'ps.Pool.AutoCreate = false; \n');
    fprintf(m_fid,'ps.Pool.IdleTimeout = Inf; \n');
    fprintf(m_fid,['gaMain(' int2str(i) ' ,ii); \n']);
    fprintf(m_fid,'end \n');
    fclose(m_fid);
end

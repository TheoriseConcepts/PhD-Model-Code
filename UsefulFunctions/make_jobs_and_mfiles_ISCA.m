for k=1:10
    mfile_name=['batch_run_' num2str(k) '.m'];
    job_name=['job_' num2str(k) '.sh'];
    
    j_fid=fopen(job_name,'w');
    fprintf(j_fid,'#!/bin/sh \n');
    fprintf(j_fid,'#PBS -V \n');
    fprintf(j_fid,'#PBS -d . \n');
    fprintf(j_fid,'#PBS -q sq \n');
    fprintf(j_fid,'#PBS -l walltime=08:00:00 \n');
    fprintf(j_fid,'#PBS -A Research_Project-160887 \n');
    fprintf(j_fid,'#PBS -l procs=1 \n');
    fprintf(j_fid,'#PBS -m e -M te302@exeter.ac.uk \n');
    fprintf(j_fid,'module load MATLAB/2017a \n');
    fprintf(j_fid,'echo Running on ; hostname \n');
    fprintf(j_fid,['matlab -singleCompThread -nojvm -nosplash -nodisplay < ' mfile_name]);
    fclose(j_fid);
    
    m_fid=fopen(mfile_name,'w');
%     fprintf(m_fid,['all_data_i=all_data_new(' num2str(i) '); \n']);
%     fprintf(m_fid,'path=all_data_i.path; \n');
%     fprintf(m_fid,'fname=all_data_i.fname; \n');
%     fprintf(m_fid,'sl=all_data_i.sl; \n');
%     fprintf(m_fid,'sp=all_data_i.sp; \n');
    fprintf(m_fid,['batch_sim(' num2str(k) '); \n']);
    fprintf(m_fid,'quit \n');
    fclose(m_fid);
end
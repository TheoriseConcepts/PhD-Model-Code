function sim_z = gamultiobjWendling_post(Xemburn,ca,t,t3,bb,aa,Nn_conv,fs_conv)

        %Convolution of Wendling output
    
        full_conv = fconv(Xemburn, ca);
     
        conv_no_edge = full_conv(:,(30*fs_conv):(Nn_conv-(30*fs_conv)-1));
      
%Downsampling
        
        yr = resample(conv_no_edge,20,fs_conv);

        %Gaussian Filtering
        t3r = t3(1:50:end);
        conv_gfilt_r = gaussfilt(t3r, yr, 1.5);  
        conv_gfilt_rr = conv_gfilt_r(359:end-360);
        
ymmr = conv_gfilt_rr - mean(conv_gfilt_rr);

y_bpf_r = filtfilt(bb,aa,ymmr);

sim_z = zscore(y_bpf_r); 
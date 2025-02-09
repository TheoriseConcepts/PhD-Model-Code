function [y Xemburn] = gamultiobjWendlingWhite_mg(T, paramsinput,bb,aa)
[Xemburn,ca,t,t3,Nn_conv,fs_conv]=gamultiobjWendlingWhite_mex(T,paramsinput); 
y = gamultiobjWendling_post(Xemburn,ca,t,t3,bb,aa,Nn_conv,fs_conv);

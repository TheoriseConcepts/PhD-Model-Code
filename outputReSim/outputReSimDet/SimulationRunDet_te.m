function [XemburnSave, X3] = SimulationRunDet_te(H,bb,aa)
[Xemburn,XemburnSave,ca,t,t3,Nn_conv,fs_conv]=SimulationRunDet_mex(H); 
X3 = SimulationRunDet_post(Xemburn,ca,t,t3,bb,aa,Nn_conv,fs_conv);
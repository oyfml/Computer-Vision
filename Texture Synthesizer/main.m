clc;
clear;

load('workspace.mat');

%Input:
%- texture matrix (minimum 3x3 texture seed)
%- window size (only odd)
%- n-fold size

figure(1);
%Convert input texture file to double
t_in=im2double(t1); %###Choose input here t1 -> t11
%Run Texture Synthesis
t_out = my_Texture_Synthesiser(t_in,11,2); %###Choose odd window size (2nd argument),
                                           %### fold size (3rd argument)



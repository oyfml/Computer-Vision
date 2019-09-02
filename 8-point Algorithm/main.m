
clc,clear;
Establish point correspondences
%cpselect('inria1.tif','inria2.tif'); %1-moving,2-fixed
load('8p-workspace.mat');
x1 = cpstruct.inputPoints;
x2 = cpstruct.basePoints;

x1=x1';
x2=x2';

%Estimate F
F = estimateF(x1,x2); %x1,x2 are 2-by-n matrices

%Display Epipolar lines
I1=imread('inria1.tif');
I2=imread('inria2.tif');

displayEpipolarF(I1,I2, F);
clc;
clear;

imgA = imread('imgA.jpg');
imgB = imread('imgB.jpg');

imgA = double(imgA);
imgB = double(imgB);

%Choose (square) patch size; must be >= 1 & odd whole number
p_len = 3;
 
%Perform Patch Match
fprintf('Starting Patch Match...\n');
%Finding NNF for Red component
NNF_R = my_Patch_Match(imgA(:,:,1), imgB(:,:,1), p_len);
fprintf('Red Patch Match complete!\n');
% %Finding NNF for Green component
NNF_G = my_Patch_Match(imgA(:,:,2), imgB(:,:,2), p_len);
fprintf('Green Patch Match complete!\n');
% %Finding NNF for Blue component
NNF_B = my_Patch_Match(imgA(:,:,3), imgB(:,:,3), p_len);
fprintf('Blue Patch Match complete!\n');

%Perform Reconstruction using NNF
fprintf('Starting Reconstruction...\n');
recon_img = my_Reconstruction(NNF_R, NNF_G, NNF_B, imgA, imgB, p_len);
fprintf('Reconstruction complete!\n');

%Display results
figure();
recon_img = uint8(recon_img);
imshow(recon_img);
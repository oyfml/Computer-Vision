function [ recon_img ] = my_Reconstruction( RNNF, GNNF, BNNF, imgA, imgB, p_len )
%This function takes in NNF for R/G/B and replace every patch location with 
%their corresponding match, reconstructing image A using patches from image B

% Input:
%     -NNF Red, Green, Blue
%       (:,:,1) = row of offset; NNF(:,:,2) = column of offset
%     -Image A & B
%     -Patch length
%Output:
%     -reconstructed image matrix for RGB
    
w = (p_len - 1)/2;
recon_img = zeros(size(imgA));

for i = (1+w):p_len:size(imgA,1)-w
    for j = (1+w):p_len:size(imgA,2)-w
        recon_img(i-w:i+w,j-w:j+w,1) = imgB(i+RNNF(i,j,1)-w:i+RNNF(i,j,1)+w,j+RNNF(i,j,2)-w:j+RNNF(i,j,2)+w,1);
        recon_img(i-w:i+w,j-w:j+w,2) = imgB(i+GNNF(i,j,1)-w:i+GNNF(i,j,1)+w,j+GNNF(i,j,2)-w:j+GNNF(i,j,2)+w,2);
        recon_img(i-w:i+w,j-w:j+w,3) = imgB(i+BNNF(i,j,1)-w:i+BNNF(i,j,1)+w,j+BNNF(i,j,2)-w:j+BNNF(i,j,2)+w,3);
    end
end




end


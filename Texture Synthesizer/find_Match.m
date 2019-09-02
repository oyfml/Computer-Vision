function [ BestMatches , SSD ] = find_Match( window, texture, ValidMask, win_size)
%This function finds matching candidates between windows and orginal texture

%Define error threshold
ErrThreshold = 0.05;

%Create 2D Gaussian filter, for Gaussian Weighted SSD
sigma = win_size/6.4;
GaussMask = fspecial('gaussian',win_size,sigma);

%Calculate total weight
Total_Weight = sum(sum(GaussMask.*ValidMask));

%Zero pad out-of-bound boundary of texture so that centre of sliding window
%can reach every pixel in texture
os = (win_size-1)/2;
[r,c,D] = size(texture);
txt_zp = zeros(r+2*os,c+2*os,D);
txt_zp((os+1:os+r),(os+1:os+c),:)= texture; %Centre texture on new space

%Compile and vectorise Mask Coefficient
Mask = (GaussMask .* ValidMask) / Total_Weight;
Mask = Mask(:)';

if D > 1 %For colour

%Convert sliding window of texture sample into column vectors
R_txt = im2col(txt_zp(:,:,1), [win_size, win_size], 'sliding');
G_txt = im2col(txt_zp(:,:,2), [win_size, win_size], 'sliding');
B_txt = im2col(txt_zp(:,:,3), [win_size, win_size], 'sliding');

%Convert neighbour window of pixel into column vector formula
R_win = reshape(window(:, :, 1), [win_size*win_size, 1]);
G_win = reshape(window(:, :, 2), [win_size*win_size, 1]);
B_win = reshape(window(:, :, 3), [win_size*win_size, 1]);
R_win = repmat(R_win, [1, size(R_txt,2)]);
G_win = repmat(G_win, [1, size(G_txt,2)]);
B_win = repmat(B_win, [1, size(B_txt,2)]);

%Calculate Distance for individual colour
R_dist =  Mask * (R_win - R_txt).^2;
G_dist = Mask * (G_win - G_txt).^2 ;
B_dist = Mask * (B_win - B_txt).^2;
SSD = (R_dist + G_dist + B_dist);

else %For Greyscale

%Convert sliding window of texture sample into column vectors
GS_txt = im2col(txt_zp(:,:), [win_size, win_size], 'sliding');
%Convert neighbour window of pixel into column vector formula
GS_win = reshape(window(:,:), [win_size*win_size, 1]);
GS_win = repmat(GS_win, [1, size(GS_txt,2)]);

%Calculate Distance for greyscale
SSD =  Mask * (GS_win - GS_txt).^2;  

end

%Note: SSD is in vector form, every n-th element = SSD of n-th pixel in texture

%Assign pixels as candidates for match if SSD falls below 110% of lowest SSD
BestMatches = (SSD <= min(SSD) * (1 + ErrThreshold));
%Output pixel location of matches
BestMatches = find(BestMatches>0);
end


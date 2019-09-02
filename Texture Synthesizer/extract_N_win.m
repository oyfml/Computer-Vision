function [ window ] = extract_N_win(pix ,txt ,win_size)
%This function gets neighbours within window size of pixel in texture matrix

%Obtain row, column limits of input matrix
[r_max, c_max, D] = size(txt);

%Get row, column # of input pixel
[r,c] = ind2sub([r_max, c_max],pix);

%Get offset to set range of row, column # of window from centre pixel
os = (win_size-1)/2;
r_1 = r - os;
r_2 = r + os;
c_1 = c - os;
c_2 = c + os;

%Expand texture boundary for uniform window esp for boundary pixel 
%Set out-of-bound region to 0
txt_expand = zeros(r_max+(2*os));
txt_expand((os+1:os+r_max),(os+1:os+c_max),1:D) = txt;

%Set window around pixel, all coordinates shifted by offset
window = txt_expand((os+r_1:os+r_2),(os+c_1:os+c_2),1:D); 

end


function [ new_txt ] = my_Texture_Synthesiser( txt, win_size, n)
%This function performs Efros & Leung Algorithm for Texture Synthesis
%   Input: texture, window size (odd), texture synthesis n-fold size
%   Outputs: texture of size n times, synthesised given input texture

%Extract input texture matrix dimensions
[r,c,D] = size(txt);

%Create large empty image with n-fold of input
r_max = n*r;
c_max = n*c;
new_txt = zeros(r_max,c_max,D);

%Copy texture sample to leftmost top corner of new texture matrix
new_txt(1:r,1:c,1:D) = txt;

%Initialise fill counter
fill_count = 0;
fill_max = (r_max*c_max) - (r*c);
%Initialise filled location tracker
fill_curr = zeros(r_max,c_max);
fill_curr(1:r,1:c) = 1;

%Set max error threshold
MaxErrThreshold = 0.3;

%Fill in all unfilled empty pixels
while(fill_count < fill_max)
    %Track if any pixel is filled in this while loop iteration
    progress = 0;
    
    %Get unfilled pixels & sort in descending neighbours
    uf_pix = find_Unfilled(fill_curr,win_size);
    %For each sorted unfilled pixel
    for i=1:length(uf_pix)
        %Extract neighbourhood window of  unfilled pixel
        [win] = extract_N_win(uf_pix(i),new_txt,win_size); 
        %Extract neighbourhood window of fill location for Valid Mask
        [ValidMask] = extract_N_win(uf_pix(i),fill_curr,win_size);%Valid Mask sets 1 to pixels which are already filled
        %Compare texture sample with window to identify matches
        [BestMatches ,SSD] = find_Match(win,txt,ValidMask,win_size);
        %Randomly select match candidate from match list
        BestMatch = random_Pick(BestMatches);
        %Determine match error, SSD
        BestMatch_Err = SSD(BestMatch);
        
        if BestMatch_Err < MaxErrThreshold
            %Assign matched pixel value to unfilled pixel if below error threshold
            [BM_row, BM_col] = ind2sub([r, c],BestMatch);
            [ufp_row, ufp_col] = ind2sub([r_max, c_max],uf_pix(i));
            new_txt(ufp_row,ufp_col,:)= txt(BM_row,BM_col,:);
            %Action made in this while loop iteration
            fill_count = fill_count + 1;
            fill_curr(ufp_row, ufp_col) = 1;
            progress = 1;
        end
    end
    
    if progress == 0
        %Increases error threshold so that action is made every iteration 
        %to fill all unfilled pixels; prevents endless loop
        MaxErrThreshold = MaxErrThreshold * 1.1;
    end
  
    %Display run status, texture image
    fprintf('Pixels remaining: %d \n', (fill_max - fill_count));
    imshow(new_txt);
    if (fill_max - fill_count) == 0
        disp('Synthesis Complete!');
    end
end
end


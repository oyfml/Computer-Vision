function [ uf_pix ] = find_Unfilled(fill_txt, win_size)
%This function finds unfilled pixels and sort them from highest NN to lowest
    
%Creates a square structuring element object whose width is 3
SE = strel('square',3); 
%Perform dilation of image to detect unfilled pixels with neighbours 
%other than original filled input texture
dil_txt = imdilate(fill_txt, SE);
uf_txt_NN = dil_txt - 0.5*fill_txt;
%Identify row, column location of unfilled pixels with neighbours
uf_pix = find(uf_txt_NN == 1);

%Generate a randomly permutated list of unfilled pixels with neighbours
list = randperm(length(uf_pix));
%Arrange order of unfilled pixel according to list
uf_pix = uf_pix(list);

%Find list of # of NN (within window) for each unfilled pixels with neighbours
N_list = zeros(1,length(uf_pix));
for i=1:length(uf_pix)
    %Extract window of specified pixel
    [N_win] = extract_N_win(uf_pix(i),uf_txt_NN ,win_size);
    % Find # of neighbours in window
    N_list(i) = sum(N_win(:) == 0.5);
end

%Sort list by decreasing number of NN 
[N_list, list] = sort(N_list,'descend');
 uf_pix = uf_pix(list);
end


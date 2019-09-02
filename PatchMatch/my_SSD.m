function [ SSD ] = my_SSD(i,j,w,imgA,imgB,NNF )
%This function converts input patch coordinates to pixel coordinate &
%calculate the SSD between patch pair

%Input: 
%-i => row # for image A
%-j => col # for image A
%-w => width of patch (from centre pixel)
%-2D matrix Image A, Image B
%-NNF => current NNF offset matrix (must be updated outside this function)

%Output:
%-SSD => Error measure in Sum Squared Distance 

%Calculate error between patches mapped using SSD
    Diff = imgA(i-w:i+w,j-w:j+w) - imgB(i+NNF(i,j,1)-w:i+NNF(i,j,1)+w,j+NNF(i,j,2)-w:j+NNF(i,j,2)+w);
    SSD = sum(sum(Diff.^2));


end


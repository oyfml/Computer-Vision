function [ NNF ] = my_Patch_Match( imgA, imgB, p_len )
%This function performs Patch Match Algorithm, using patches from Image B
%to find the Nearest Neighbour Field to patch region in Image A.
%Input:
%   -2D matrix of Image A, B; grayscale img B yield better result
%   -Patch length (# of pixels in patch length)
%Output:
%   -Nearest Neighbour Field Mapping for one 3rd dimension component
%   (R/G/B)

imgA = double(imgA);
imgB = double(imgB);

%Set # of iterations
i_max = 4; %(3-5 is recommended)

%Obtain image dimensions
[A_r,A_c] = size(imgA(:,:,1));
[B_r,B_c] = size(imgB(:,:,1));

%Define patch width; between patch center and border
w = (p_len - 1)/2; 

%Create offset matrix; for 3rd dimension, 1-row, 2-column of offset
NNF = nan(A_r,A_c,2);
%Random Initialisation; random offset for every patch center
for i = 1+w:A_r-w
    for j = 1+w:A_c-w
        NNF(i,j,1) = randi([1+w,B_r-w]) - i;%row #
        NNF(i,j,2) = randi([1+w,B_r-w]) - j;%col #
    end
end

%Create distance function D matrix
D = inf(A_r,A_c);

for i = 1+w:A_r-w
    for j = 1+w:A_c-w
        %Calculate distance function for newly generated NNF values
        D(i,j) = my_SSD(i,j,w,imgA,imgB,NNF);
    end
end

%Iteration of propagation and random search
for iteration = 1:i_max

%Odd iteration flag    
i_odd = (mod(iteration,2) == 1);

%Move in normal scan order
if (i_odd == 1) % Odd iteration
    i_count = (w+1):(A_r-w); %L->R, T->B
    j_count = (w+1):(A_c-w);
%Move in reverse scan order
else % Even iteration
    i_count = (A_r-w):-1:(w+1); %R->L, B->T
    j_count = (A_c-w):-1:(w+1);
end

%Propagation
%Copy the offsets of neighboring pixels and update if a more similar patch is found
    for i = i_count
        for j = j_count        
             if rem(iteration,2) == 0 %Even
                %Find minimum patch distance error with top and left
                off_comp(1) = D(i,j);
                off_comp(2) = D(max(1+w,i-1),j);  %row patch index cannot <1+w
                off_comp(3) = D(i,max(1+w,j-1)); %col patch index cannot <1+w
                [~,n] = min(off_comp);
                
                if (off_comp(1)==off_comp(2))&&(off_comp(1)==off_comp(3))
                    n = 1; %patch on top left corner
                end
                
                switch(n)
                    case 2 %Propagate Top
                        % Make sure patch is not replacing itself & after offset is not shifted out-of-bound 
                        %(Occurs when [i-1,j] is mapped to outer perimeter patches and shifting [i,j] to new offset
                        %causes the patch to end up in out-of-bound region)
                        if (((i-1) >= 1+w) && (i+NNF(i-1,j,1)+1 <= B_r-w) && (j+NNF(i-1,j,2) <= B_c-w) ...
                                && (i+NNF(i-1,j,1) >= 1+w) && (j+NNF(i-1,j,2) >= 1+w)) 
                            %Update new (i,j) offset
                            NNF(i,j,1) = NNF(i-1,j,1)+1;
                            NNF(i,j,2) = NNF(i-1,j,2);
                            %Update element in distance function, using new offset
                            D(i,j) = my_SSD(i,j,w,imgA,imgB,NNF);
                        end
                        %Do nothing if otherwise
                    case 3 % Propagate Left
                        % Make sure patch is not replacing itself & after offset is not shifted out-of-bound
                        if (((j-1) >= 1+w) && (i+NNF(i,j-1,1) <= B_r-w) && (j+NNF(i,j-1,2)+1 <= B_c-w) ...
                                && (i+NNF(i,j-1,1) >= 1+w) && (j+NNF(i,j-1,2) >= 1+w))
                            %Change (i,j) offset
                            NNF(i,j,1) = NNF(i,j-1,1);
                            NNF(i,j,2) = NNF(i,j-1,2)+1;
                            %Update element in distance function, using new offset
                            D(i,j) = my_SSD(i,j,w,imgA,imgB,NNF);
                        end
                        %Do nothing if patch at corner boundary
                end
                    
            else %odd
                %Find minimum patch distance error with bottom and right
                off_comp(1) = D(i,j);
                off_comp(2) = D(min(A_r-w,i+1),j);  %row index cannot > p_r
                off_comp(3) = D(i,min(A_c-w,j+1)); %col index cannot > p_c
                [~,n] = min(off_comp);
                
                if (off_comp(1)==off_comp(2))&&(off_comp(1)==off_comp(3))
                    n = 1; %patch on bottom right corner
                end
                
                switch(n)
                    case 2
                        % Make sure patch is not replacing itself & after offset is not shifted out-of-bound
                        if (((i+1) <= A_r-w) && (i+NNF(i+1,j,1) <= B_r-w) && (j+NNF(i+1,j,2) <= B_c-w) ...
                                && (i+NNF(i+1,j,1)-1 >= 1+w) && (j+NNF(i+1,j,2) >= 1+w))
                            %Update new (i,j) offset
                            NNF(i,j,1) = NNF(i+1,j,1)-1;
                            NNF(i,j,2) = NNF(i+1,j,2);
                            %Update element in distance function, using new offset
                            D(i,j) = my_SSD(i,j,w,imgA,imgB,NNF);
                        end
                        %Do nothing if patch at corner boundary
                    case 3
                        % Make sure patch is not replacing itself & after offset is not shifted out-of-bound
                        if (((j+1) <= A_c-w) && (i+NNF(i,j+1,1) <= B_r-w) && (j+NNF(i,j+1,2) <= B_c-w) ...
                                && (i+NNF(i,j+1,1) >= 1+w) && (j+NNF(i,j+1,2)-1 >= 1+w))
                            %Change (i,j) offset
                            NNF(i,j,1) = NNF(i,j+1,1);
                            NNF(i,j,2) = NNF(i,j+1,2)-1;
                            %Update element in distance function, using new offset
                            D(i,j) = my_SSD(i,j,w,imgA,imgB,NNF);
                        end
                        %Do nothing if patch at corner boundary
                end 
            end
            
        end
    end


%Step 3.Random Search
%Randomly search in a neighborhood of current best offset 
%Start with a large neighborhood and reduce the size in each iteration 
%Stop if the neighborhood size is less than 1 pixel

%==Optional==%

fprintf('Iteration %d complete!\n',iteration);

end    %end of current iteration

end


function [ chosen ] = random_Pick( list )
%This function randomly selects pixel candidates from a pixel match
%candidate list

index = randi([1, length(list)]);
chosen = list(index);

end


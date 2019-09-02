function [ F ] = estimateF( x1, x2 )
%Perform estimate of Fundamental Matrix given pair of corresponding points

x1=x1';
x2=x2';

%4.2.2 Normalisation of data
% Compute Mean
n = length(x1);
x1_mean = mean(x1);
x2_mean = mean(x2);
% Set Mean as origin, reference all points to new origin
dist_x1 = x1 - x1_mean;
dist_x2= x2 - x2_mean;
% Set scale, s.t avg distance from origin is root2
% Note average dist. = rms
avg_dist_x1  = sqrt((sum(dist_x1.^2))/n);
avg_dist_x2 = sqrt((sum(dist_x2.^2))/n);
inv_s_x1 = sqrt(2)*(avg_dist_x1.^(-1)); %scaling vector containing 1/sx (1) & 1/sy (2) for x1
inv_s_x2 = sqrt(2)*(avg_dist_x2.^(-1)); %scaling vector containing 1/sx (1) & 1/sy (2) for x2
% Set T matrix
T_x1 = [inv_s_x1(1),           0, (-x1_mean(1)*inv_s_x1(1)); 
        0          , inv_s_x1(2), (-x1_mean(2)*inv_s_x1(2)); 
        0          ,           0,                        1];
    
T_x2 = [inv_s_x2(1),           0, (-x2_mean(1)*inv_s_x2(1)); 
        0          , inv_s_x2(2), (-x2_mean(2)*inv_s_x2(2)); 
        0          ,           0,                        1];       
% Convert to homogeneous coordinates
x1 = [x1 ones(n,1)];
x2 = [x2 ones(n,1)];
% Normalised coordinates
x1_norm = T_x1 * x1'; 
x2_norm = T_x2 * x2';

%4.2.3 Computation of Fundamental matrix
% Set matrix A
A = [];
for i=1:n
    x = x1_norm(1,i);
    x_prime = x2_norm(1,i);
    y = x1_norm(2,i);
    y_prime = x2_norm(2,i);
    A = [A;
         x_prime*x, x_prime*y, x_prime, y_prime*x, y_prime*y, y_prime, x, y, 1];
end

[U, D, V] = svd(A);
% Set Fundamental Matrix
F_norm = [V(1:3,9) V(4:6,9) V(7:end,9)]';
[Uf, Df, Vf] = svd(F_norm);
% Enforce singularity constraint
Df(end,end) = 0;
F_prime_norm = Uf*Df*Vf';

%4.2.4 Denormalisation
F = (T_x2)'* F_prime_norm *T_x1;

end


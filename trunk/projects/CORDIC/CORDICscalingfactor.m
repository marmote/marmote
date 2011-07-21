function [ K, invK ] = CORDICscalingfactor( n )
%CORDICSCALINGFACTOR Summary of this function goes here
%   Detailed explanation goes here

K=1;
for ii=0:n-1
    K=K*sqrt(1+2^(-2*ii));
end

invK = 1/K;

disp(K);
disp(invK);

end


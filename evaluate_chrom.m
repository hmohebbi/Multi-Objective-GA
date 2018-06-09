function [val1, val2] = evaluate_chrom(chrom, number_param, range)
%evaluate each individual
param_len = length(chrom)/number_param;
input = zeros(1, number_param);
for i = 1:number_param
	input(i) = binaryToFloat(chrom( (i-1)*param_len+1:i*param_len ), range(i,:));
end
val1 = f1(input(1),input(2));
val2 = f2(input(1),input(2));
end


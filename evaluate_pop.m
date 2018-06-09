function evaluatedAll = evaluate_pop(population,number_param,range)
%evaluate population
evaluatedAll = zeros(size(population,1), 2);
for i = 1:size(population,1)
	[evaluatedAll(i,1), evaluatedAll(i,2)] = evaluate_chrom (population(i,:), number_param, range);
end

end


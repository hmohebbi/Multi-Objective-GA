function new_pop = generate_pop(population, fitnessAll, crossover_prob, mutation_prob, elitism, elit_n)
%generate next population
pop_Size = size(population,1);
chrom_len = size(population,2);
new_pop = population;

%find elitism
if elitism
    tmp_fit = fitnessAll;
    index_elit = zeros(1,elit_n);
    for k=1:elit_n
        [max_val, index_elit(k)] = max(tmp_fit);	
        tmp_fit(index_elit(k)) = min(tmp_fit);
    end
    new_pop(1:elit_n, :) = population(index_elit, :);
end

%rollet wheel
for i=1:pop_Size
    r = rand * sum(fitnessAll); % get a random number in rollet wheel
    %find specific chrom in wheel
    a=0;
    dex = 1;
    for j=1:pop_Size        
        a = a + fitnessAll(j);
        if a > r
            dex = j;
            break;
        end
    end
    new_pop(i,:) = population(dex,:);
end

%crossover
for i=1:pop_Size-1
    parent1 = new_pop(i,:);
    parent2 = new_pop(i+1,:);
    
    if rand < crossover_prob
		crossover_point = ceil(rand*(chrom_len-1));
		child1 = [parent1(1:crossover_point) parent2(crossover_point+1:chrom_len)];
		child2 = [parent2(1:crossover_point) parent1(crossover_point+1:chrom_len)];
        
        new_pop(i,:) = child1;
        new_pop(i+1,:) = child2;
	end
end

%mutation
mask = rand(size(new_pop,1), chrom_len) < mutation_prob;
new_pop = xor(new_pop, mask);

%restore elites witout any change
if elitism
    new_pop(1:elit_n, :) = population(index_elit, :);
end

end


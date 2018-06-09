function rankingAll = paretoRanking(population,evaluatedAll)
%compute fitness all individuals using pareto ranking: Fonseca & Fleming approach
pop_size = size(population,1);
rankingAll = zeros(pop_size, 1);
for i=1:pop_size
   for j=1:pop_size
      if i == j
          continue; 
      end
      %how many individuals in the population they are dominated by
      if evaluatedAll(i,1) < evaluatedAll(j,1) ...
              && evaluatedAll(i,2) < evaluatedAll(j,2)
          rankingAll(j) = rankingAll(j) + 1;
      end
   end
end
end


%hosein.mohebbi75@gmail.com
%% parameters:
pop_Size = 20;
generation = 50;
mutation_prob = 0.02;
crossover_prob = 0.5;
chrom_len = 8;
range = [-2, 2 ; -2, 2];
number_param = 2;
elitism = 0; % 0 means no elitism and 1 means have elitism
elit_n = 5; % elitism number

%% initialization
xx = range(1,1):0.1:range(1,2);
yy = range(2,1):0.1:range(2,2);

%% plot functions space
figure;
[xx,yy] = meshgrid(range(1,1):0.1:range(1,2), range(2,1):0.1:range(2,2));
mesh(xx,yy,f1(xx,yy));
title('f1(x,y)');
figure;
mesh(xx,yy,f2(xx,yy));
title('f2(x,y)');

%% random initialization
%rng(1);
population = rand(pop_Size, chrom_len*number_param) > 0.5;

%% plot init population
figure;
title('individuals in generation 0');
hold on;
for i=1:pop_Size
    x = binaryToFloat(population(i, 1:chrom_len ), range(1,:));
    y = binaryToFloat(population(i, chrom_len+1:2*chrom_len ), range(2,:));
    scatter(f1(x,y), f2(x,y),'MarkerFaceColor',[1 .1 .1]);
    xlim([0 3650]); ylim([0 10]);
end
hold off;

%% main algorithm
for i=1:generation
    %fitness evaluation
    evaluatedAll = evaluate_pop(population,number_param,range);
    rankingAll = paretoRanking(population,evaluatedAll);
    %reverse fitnesses, because we want to minimum two objective functions
    maxFitness = max(rankingAll);
    fitnessAll = maxFitness - rankingAll;
    
    %plot during all generation
    fig = figure;
    str = sprintf('show individuals in generation %d', i);
    title(str);
    hold;
    for k=1:pop_Size
        x = binaryToFloat(population(k, 1:chrom_len ), range(1,:));
        y = binaryToFloat(population(k, chrom_len+1:2*chrom_len ), range(2,:));
        scatter(f1(x,y), f2(x,y),'MarkerFaceColor',[.1 1 .2]);
        xlim([0 3650]); ylim([0 10]);
    end
    str = sprintf('img\\fig%d.png',i);
    saveas(fig,str);
    close(fig);
    
    %generate next population
    population = generate_pop(population, fitnessAll, crossover_prob, mutation_prob,elitism,elit_n);
end

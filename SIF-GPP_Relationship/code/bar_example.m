%% Example for sci_bar
clear
clc

%% Create Mock data

% elements to pick from
groups = [{'Sugar'} {'Spice'} {'Nice'} {'Chem X'}];
samples = [{'Professor'} {'Blossom'} {'Bubbles'} {'Buttercup'} {'Mojo'}];

% generate data
Ndata = 200;
group_ids = groups(randi(length(groups),Ndata,1));
sample_ids = samples(randi(length(samples),Ndata,1));
data = rand(Ndata,1);

% sci_bar labels follows the order of the data
group_ids(1:length(groups)) = groups;
sample_ids(1:length(samples)) = samples;

%% Make bar plot with sci_bar
h = sci_bar(data, group_ids, sample_ids, true, 'Ingredients', 'Level');
h.plot

% touch-up
set(gca, 'Position', [0.097 0.12 0.65 0.8])

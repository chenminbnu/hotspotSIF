%% Cdm
%% LAI
load('different_Cdm.mat');
hotspot_data = results_hotspot;
nadir_data = results_nadir;

num = size(hotspot_data, 1);
% sif, gpp, apar
SZA = hotspot_data(:, :, 1);
apar = hotspot_data(:, :, 8) * 4.57;
sif_total = hotspot_data(:, :, 3);
sif_hotspot = hotspot_data(:, :, 4);
sif_hemi = hotspot_data(:, :,5);
sif_nadir = nadir_data(:, :, 4);
gpp = hotspot_data(:, :,6);
% lue
luep = gpp ./ apar;
sifyield  = sif_total ./ apar;
luef_hotspot = sif_hotspot ./ apar;
luef_hemi = sif_hemi ./ apar;
luef_nadir =  sif_nadir ./ apar;
%fesc
fesc_hotspot = sif_hotspot ./ sif_total;
fesc_hemi = sif_hemi ./ sif_total;
fesc_nadir =  sif_nadir ./ sif_total;

%% reshape
apar = reshape(permute(apar,[2 1]),18*num,1);
sif_total = reshape(permute(sif_total,[2 1]),18*num,1);
sif_hotspot = reshape(permute(sif_hotspot,[2 1]),18*num,1);
sif_hemi = reshape(permute(sif_hemi,[2 1]),18*num,1);
sif_nadir = reshape(permute(sif_nadir,[2 1]),18*num,1);
gpp = reshape(permute(gpp,[2 1]),18*num,1);
luep = reshape(permute(luep,[2 1]),18*num,1);
sifyield = reshape(permute(sifyield,[2 1]),18*num,1);
luef_hotspot = reshape(permute(luef_hotspot,[2 1]),18*num,1);
luef_hemi = reshape(permute(luef_hemi,[2 1]),18*num,1);
luef_nadir = reshape(permute(luef_nadir,[2 1]),18*num,1);
fesc_hotspot = reshape(permute(fesc_hotspot,[2 1]),18*num,1);
fesc_hemi = reshape(permute(fesc_hemi,[2 1]),18*num,1);
fesc_nadir = reshape(permute(fesc_nadir,[2 1]),18*num,1);
vars = repmat(1:num,18,1);
vars = vars(:);
SZA = reshape(permute(SZA,[2 1]),18*num,1);
data = [SZA, vars, apar, gpp,sif_total,...
    sif_hotspot ,sif_hemi ,sif_nadir,...
luep,sifyield,luef_hotspot,luef_hemi,luef_nadir,...
fesc_hotspot,fesc_hemi,fesc_nadir];
save('different_Cdm_reshape.mat','data');

%%
%% LAI
load('different_LAI.mat');
hotspot_data = results_hotspot;
nadir_data = results_nadir;

num = size(hotspot_data, 1);
% sif, gpp, apar
SZA = hotspot_data(:, :, 1);
apar = hotspot_data(:, :, 8) * 4.57;
sif_total = hotspot_data(:, :, 3);
sif_hotspot = hotspot_data(:, :, 4);
sif_hemi = hotspot_data(:, :,5);
sif_nadir = nadir_data(:, :, 4);
gpp = hotspot_data(:, :,6);
% lue
luep = gpp ./ apar;
sifyield  = sif_total ./ apar;
luef_hotspot = sif_hotspot ./ apar;
luef_hemi = sif_hemi ./ apar;
luef_nadir =  sif_nadir ./ apar;
%fesc
fesc_hotspot = sif_hotspot ./ sif_total;
fesc_hemi = sif_hemi ./ sif_total;
fesc_nadir =  sif_nadir ./ sif_total;

%% reshape
apar = reshape(permute(apar,[2 1]),18*num,1);
sif_total = reshape(permute(sif_total,[2 1]),18*num,1);
sif_hotspot = reshape(permute(sif_hotspot,[2 1]),18*num,1);
sif_hemi = reshape(permute(sif_hemi,[2 1]),18*num,1);
sif_nadir = reshape(permute(sif_nadir,[2 1]),18*num,1);
gpp = reshape(permute(gpp,[2 1]),18*num,1);
luep = reshape(permute(luep,[2 1]),18*num,1);
sifyield = reshape(permute(sifyield,[2 1]),18*num,1);
luef_hotspot = reshape(permute(luef_hotspot,[2 1]),18*num,1);
luef_hemi = reshape(permute(luef_hemi,[2 1]),18*num,1);
luef_nadir = reshape(permute(luef_nadir,[2 1]),18*num,1);
fesc_hotspot = reshape(permute(fesc_hotspot,[2 1]),18*num,1);
fesc_hemi = reshape(permute(fesc_hemi,[2 1]),18*num,1);
fesc_nadir = reshape(permute(fesc_nadir,[2 1]),18*num,1);
vars = repmat(1:num,18,1);
vars = vars(:);
SZA = reshape(permute(SZA,[2 1]),18*num,1);
data = [SZA, vars, apar, gpp,sif_total,...
    sif_hotspot ,sif_hemi ,sif_nadir,...
luep,sifyield,luef_hotspot,luef_hemi,luef_nadir,...
fesc_hotspot,fesc_hemi,fesc_nadir];
save('different_LAI_reshape.mat','data');

%% Cab
load('different_Cab.mat');
hotspot_data = results_hotspot;
nadir_data = results_nadir;

num = size(hotspot_data, 1);
% sif, gpp, apar
SZA = hotspot_data(:, :, 1);
apar = hotspot_data(:, :, 8) * 4.57;
sif_total = hotspot_data(:, :, 3);
sif_hotspot = hotspot_data(:, :, 4);
sif_hemi = hotspot_data(:, :,5);
sif_nadir = nadir_data(:, :, 4);
gpp = hotspot_data(:, :,6);
% lue
luep = gpp ./ apar;
sifyield  = sif_total ./ apar;
luef_hotspot = sif_hotspot ./ apar;
luef_hemi = sif_hemi ./ apar;
luef_nadir =  sif_nadir ./ apar;
%fesc
fesc_hotspot = sif_hotspot ./ sif_total;
fesc_hemi = sif_hemi ./ sif_total;
fesc_nadir =  sif_nadir ./ sif_total;

%reshape
apar = reshape(permute(apar,[2 1]),18*num,1);
sif_total = reshape(permute(sif_total,[2 1]),18*num,1);
sif_hotspot = reshape(permute(sif_hotspot,[2 1]),18*num,1);
sif_hemi = reshape(permute(sif_hemi,[2 1]),18*num,1);
sif_nadir = reshape(permute(sif_nadir,[2 1]),18*num,1);
gpp = reshape(permute(gpp,[2 1]),18*num,1);
luep = reshape(permute(luep,[2 1]),18*num,1);
sifyield = reshape(permute(sifyield,[2 1]),18*num,1);
luef_hotspot = reshape(permute(luef_hotspot,[2 1]),18*num,1);
luef_hemi = reshape(permute(luef_hemi,[2 1]),18*num,1);
luef_nadir = reshape(permute(luef_nadir,[2 1]),18*num,1);
fesc_hotspot = reshape(permute(fesc_hotspot,[2 1]),18*num,1);
fesc_hemi = reshape(permute(fesc_hemi,[2 1]),18*num,1);
fesc_nadir = reshape(permute(fesc_nadir,[2 1]),18*num,1);
vars = repmat(1:num,18,1);
vars = vars(:);
SZA = reshape(permute(SZA,[2 1]),18*num,1);
data = [SZA, vars, apar, gpp,sif_total,...
    sif_hotspot ,sif_hemi ,sif_nadir,...
luep,sifyield,luef_hotspot,luef_hemi,luef_nadir,...
fesc_hotspot,fesc_hemi,fesc_nadir];
save('different_Cab_reshape.mat','data');

%% Cab
load('different_Cab.mat');
hotspot_data = results_hotspot;
nadir_data = results_nadir;

num = size(hotspot_data, 1);
% sif, gpp, apar
SZA = hotspot_data(:, :, 1);
apar = hotspot_data(:, :, 8) * 4.57;
sif_total = hotspot_data(:, :, 3);
sif_hotspot = hotspot_data(:, :, 4);
sif_hemi = hotspot_data(:, :,5);
sif_nadir = nadir_data(:, :, 4);
gpp = hotspot_data(:, :,6);
% lue
luep = gpp ./ apar;
sifyield  = sif_total ./ apar;
luef_hotspot = sif_hotspot ./ apar;
luef_hemi = sif_hemi ./ apar;
luef_nadir =  sif_nadir ./ apar;
%fesc
fesc_hotspot = sif_hotspot ./ sif_total;
fesc_hemi = sif_hemi ./ sif_total;
fesc_nadir =  sif_nadir ./ sif_total;

%reshape
apar = reshape(permute(apar,[2 1]),18*num,1);
sif_total = reshape(permute(sif_total,[2 1]),18*num,1);
sif_hotspot = reshape(permute(sif_hotspot,[2 1]),18*num,1);
sif_hemi = reshape(permute(sif_hemi,[2 1]),18*num,1);
sif_nadir = reshape(permute(sif_nadir,[2 1]),18*num,1);
gpp = reshape(permute(gpp,[2 1]),18*num,1);
luep = reshape(permute(luep,[2 1]),18*num,1);
sifyield = reshape(permute(sifyield,[2 1]),18*num,1);
luef_hotspot = reshape(permute(luef_hotspot,[2 1]),18*num,1);
luef_hemi = reshape(permute(luef_hemi,[2 1]),18*num,1);
luef_nadir = reshape(permute(luef_nadir,[2 1]),18*num,1);
fesc_hotspot = reshape(permute(fesc_hotspot,[2 1]),18*num,1);
fesc_hemi = reshape(permute(fesc_hemi,[2 1]),18*num,1);
fesc_nadir = reshape(permute(fesc_nadir,[2 1]),18*num,1);
vars = repmat(1:num,18,1);
vars = vars(:);
SZA = reshape(permute(SZA,[2 1]),18*num,1);
data = [SZA, vars, apar, gpp,sif_total,...
    sif_hotspot ,sif_hemi ,sif_nadir,...
luep,sifyield,luef_hotspot,luef_hemi,luef_nadir,...
fesc_hotspot,fesc_hemi,fesc_nadir];
save('different_Cab_reshape.mat','data');

%% LIDF
load('different_LIDF.mat');
hotspot_data = results_hotspot;
nadir_data = results_nadir;

num = size(hotspot_data, 1);
% sif, gpp, apar
SZA = hotspot_data(:, :, 1);
apar = hotspot_data(:, :, 8) * 4.57;
sif_total = hotspot_data(:, :, 3);
sif_hotspot = hotspot_data(:, :, 4);
sif_hemi = hotspot_data(:, :,5);
sif_nadir = nadir_data(:, :, 4);
gpp = hotspot_data(:, :,6);
% lue
luep = gpp ./ apar;
sifyield  = sif_total ./ apar;
luef_hotspot = sif_hotspot ./ apar;
luef_hemi = sif_hemi ./ apar;
luef_nadir =  sif_nadir ./ apar;
%fesc
fesc_hotspot = sif_hotspot ./ sif_total;
fesc_hemi = sif_hemi ./ sif_total;
fesc_nadir =  sif_nadir ./ sif_total;

%% reshape
apar = reshape(permute(apar,[2 1]),18*num,1);
sif_total = reshape(permute(sif_total,[2 1]),18*num,1);
sif_hotspot = reshape(permute(sif_hotspot,[2 1]),18*num,1);
sif_hemi = reshape(permute(sif_hemi,[2 1]),18*num,1);
sif_nadir = reshape(permute(sif_nadir,[2 1]),18*num,1);
gpp = reshape(permute(gpp,[2 1]),18*num,1);
luep = reshape(permute(luep,[2 1]),18*num,1);
sifyield = reshape(permute(sifyield,[2 1]),18*num,1);
luef_hotspot = reshape(permute(luef_hotspot,[2 1]),18*num,1);
luef_hemi = reshape(permute(luef_hemi,[2 1]),18*num,1);
luef_nadir = reshape(permute(luef_nadir,[2 1]),18*num,1);
fesc_hotspot = reshape(permute(fesc_hotspot,[2 1]),18*num,1);
fesc_hemi = reshape(permute(fesc_hemi,[2 1]),18*num,1);
fesc_nadir = reshape(permute(fesc_nadir,[2 1]),18*num,1);
vars = repmat(1:num,18,1);
vars = vars(:);
SZA = reshape(permute(SZA,[2 1]),18*num,1);
data = [SZA, vars, apar, gpp,sif_total,...
    sif_hotspot ,sif_hemi ,sif_nadir,...
luep,sifyield,luef_hotspot,luef_hemi,luef_nadir,...
fesc_hotspot,fesc_hemi,fesc_nadir];
save('different_LIDF_reshape.mat','data');

%% Vcmax
load('different_Vcmax.mat');
hotspot_data = results_hotspot;
nadir_data = results_nadir;

num = size(hotspot_data, 1);
% sif, gpp, apar
SZA = hotspot_data(:, :, 1);
apar = hotspot_data(:, :, 8) * 4.57;
sif_total = hotspot_data(:, :, 3);
sif_hotspot = hotspot_data(:, :, 4);
sif_hemi = hotspot_data(:, :,5);
sif_nadir = nadir_data(:, :, 4);
gpp = hotspot_data(:, :,6);
% lue
luep = gpp ./ apar;
sifyield  = sif_total ./ apar;
luef_hotspot = sif_hotspot ./ apar;
luef_hemi = sif_hemi ./ apar;
luef_nadir =  sif_nadir ./ apar;
%fesc
fesc_hotspot = sif_hotspot ./ sif_total;
fesc_hemi = sif_hemi ./ sif_total;
fesc_nadir =  sif_nadir ./ sif_total;

% reshape
apar = reshape(permute(apar,[2 1]),18*num,1);
sif_total = reshape(permute(sif_total,[2 1]),18*num,1);
sif_hotspot = reshape(permute(sif_hotspot,[2 1]),18*num,1);
sif_hemi = reshape(permute(sif_hemi,[2 1]),18*num,1);
sif_nadir = reshape(permute(sif_nadir,[2 1]),18*num,1);
gpp = reshape(permute(gpp,[2 1]),18*num,1);
luep = reshape(permute(luep,[2 1]),18*num,1);
sifyield = reshape(permute(sifyield,[2 1]),18*num,1);
luef_hotspot = reshape(permute(luef_hotspot,[2 1]),18*num,1);
luef_hemi = reshape(permute(luef_hemi,[2 1]),18*num,1);
luef_nadir = reshape(permute(luef_nadir,[2 1]),18*num,1);
fesc_hotspot = reshape(permute(fesc_hotspot,[2 1]),18*num,1);
fesc_hemi = reshape(permute(fesc_hemi,[2 1]),18*num,1);
fesc_nadir = reshape(permute(fesc_nadir,[2 1]),18*num,1);
vars = repmat(1:num,18,1);
vars = vars(:);
SZA = reshape(permute(SZA,[2 1]),18*num,1);
data = [SZA, vars, apar, gpp,sif_total,...
    sif_hotspot ,sif_hemi ,sif_nadir,...
luep,sifyield,luef_hotspot,luef_hemi,luef_nadir,...
fesc_hotspot,fesc_hemi,fesc_nadir];
save('different_Vcmax_reshape.mat','data');
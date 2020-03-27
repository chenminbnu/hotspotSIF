%%% calculate R2 between hotspot and nadir SIF and GPP
%%% written by dalei hao
%%%

siteData = importdata('sites_used.csv');
siteData = siteData.textdata;
siteNames = siteData(2:end,1);
siteLCs = siteData(2:end,7);
StartYears = siteData(2:end, 4);
EndYears = siteData(2:end, 5);
LC_unique = unique(siteLCs);
LC_unique([2,4]) = [];
load('statistics/good_sites.mat');
load('statistics/gpp_errors.mat');
gpp_errors = gpp_errors(:,1);
%R2s(~(R2s(:,1)>0.1 & R2s(:,2)>0.1 & R2s(:,5)>10),:)=nan;
load('statistics/R2_daily_limit.mat');
R2s(good_sites == 0,1:4) = nan;
% R2s(gpp_errors<0.6, :)=nan;     
R2s_daily_lc = zeros(11,4);
std_R2s_daily_lc = zeros(11, 4);
for i = 1:9
    data_tmp = R2s(strcmp(siteLCs,LC_unique(i))  & R2s(:,5)>10,1:4);
    R2s_daily_lc(i,:) = nanmean(data_tmp);
  std_R2s_daily_lc(i,:) = nanstd(data_tmp);
end


figure;
subplot(2,1,2)
colormap(jet)
hold on
barwitherr(std_R2s_daily_lc, R2s_daily_lc)

axis([0.5 9.5 0 1])
box on
ylabel('mean R^2')
set(gca, 'xTick',[1:9],'xTicklabel',LC_unique ,'linewidth', 1.5,'Fontsize',12)
title('Daily SIF-GPP')

load('statistics/R2_hourly_limit_0.8.mat');
R2s(good_sites == 0,1:4) = nan;
% R2s(gpp_errors<0.4, :)=nan;     
%R2s(gpp_errors>0.6, :)=nan;     
%R2s(50,:,:) = nan;
R2s_hourly_lc = zeros(11,4);
std_R2s_hourly_lc = zeros(11,4);
R2s_hourly = R2s;
for i = 1:9
    data_tmp = R2s_hourly(strcmp(siteLCs,LC_unique(i)) &  R2s_hourly(:,5)>10,1:4);
    R2s_hourly_lc(i,:) = nanmean(data_tmp);
   std_R2s_hourly_lc(i,:) = nanstd(data_tmp);
end


%% hourly-4
subplot(2,1,1)
colormap(jet)
hold on
barwitherr(std_R2s_hourly_lc, R2s_hourly_lc)
axis([0.5 9.5 0 1])
box on
ylabel('mean R^2')
set(gca, 'xTick',[1:9],'xTicklabel',LC_unique, 'linewidth', 1.5,'Fontsize',12)
title('Hourly SIF-GPP')


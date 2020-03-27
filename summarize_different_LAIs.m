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



load('LAI_0_2_R2_hourly_limit_0.7.mat');
%R2s(R2_Daily_GPP<0.3 | R2_Daily_GPP>0.6, :)=nan;       
%R2s(50,:,:) = nan;
R2s_hourly_lc = zeros(11,4);
std_R2s_hourly_lc = zeros(11,4);
R2s_hourly = R2s;
for i = 1:9
    data_tmp = R2s_hourly(strcmp(siteLCs,LC_unique(i)) & R2s_hourly(:,1)>0.1 & R2s_hourly(:,2)>0.1 & R2s_hourly(:,5)>100,1:4);
    R2s_hourly_lc(i,:) = nanmean(data_tmp);
   std_R2s_hourly_lc(i,:) = nanstd(data_tmp);
end


%% hourly-4
subplot(3,1,1)
colormap(jet)
hold on
barwitherr(std_R2s_hourly_lc, R2s_hourly_lc)
axis([0.5 9.5 0 1])
box on
ylabel('mean R^2')
set(gca, 'xTick',[1:9],'xTicklabel',LC_unique, 'linewidth', 1.5)
title('hourly SIF-GPP (clear\_index>0.70)')

% 0.75
load('LAI_2_4_R2_hourly_limit_0.7.mat');
%R2s(R2_Daily_GPP<0.3 | R2_Daily_GPP>0.6, :)=nan;     
%R2s(50,:,:) = nan;
R2s_hourly_lc = zeros(11,4);
std_R2s_hourly_lc = zeros(11,4);
R2s_hourly = R2s;
for i = 1:9
    data_tmp = R2s_hourly(strcmp(siteLCs,LC_unique(i)) & R2s_hourly(:,1)>0.1 & R2s_hourly(:,2)>0.1 & R2s_hourly(:,5)>100,1:4);
    R2s_hourly_lc(i,:) = nanmean(data_tmp);
   std_R2s_hourly_lc(i,:) = nanstd(data_tmp);
end


subplot(3,1,2)

colormap(jet)
hold on
barwitherr(std_R2s_hourly_lc, R2s_hourly_lc)
axis([0.5 9.5 0 1])
box on
ylabel('mean R^2')
set(gca, 'xTick',[1:9],'xTicklabel',LC_unique, 'linewidth', 1.5)
title('hourly SIF-GPP (clear\_index>0.75)')


% 4
load('LAI_4_8_R2_hourly_limit_0.7.mat');
%R2s(R2_Daily_GPP<0.3 | R2_Daily_GPP>0.6, :)=nan;     
%R2s(50,:,:) = nan;
R2s_hourly_lc = zeros(11,4);
std_R2s_hourly_lc = zeros(11,4);
R2s_hourly = R2s;
for i = 1:9
    data_tmp = R2s_hourly(strcmp(siteLCs,LC_unique(i)) & R2s_hourly(:,1)>0.1 & R2s_hourly(:,2)>0.1 & R2s_hourly(:,5)>100,1:4);
    R2s_hourly_lc(i,:) = nanmean(data_tmp);
   std_R2s_hourly_lc(i,:) = nanstd(data_tmp);
end


subplot(3,1,3)

colormap(jet)
hold on
barwitherr(std_R2s_hourly_lc, R2s_hourly_lc)
axis([0.5 9.5 0 1])
box on
ylabel('mean R^2')
set(gca, 'xTick',[1:9],'xTicklabel',LC_unique, 'linewidth', 1.5)
title('hourly SIF-GPP (clear\_index>0.80)')

% %% hourly-4
% 
% % 0.85
% load('morning_R2_hourly_limit_0.85.mat');
% R2s(R2_Daily_GPP<0.5, :)=nan;     
% %R2s(50,:,:) = nan;
% R2s_hourly_lc = zeros(11,4);
% std_R2s_hourly_lc = zeros(11,4);
% R2s_hourly = R2s;
% for i = 1:9
%     data_tmp = R2s_hourly(strcmp(siteLCs,LC_unique(i)) & R2s_hourly(:,1)>0.1 & R2s_hourly(:,2)>0.1 & R2s_hourly(:,5)>10,1:4);
%     R2s_hourly_lc(i,:) = nanmean(data_tmp);
%    std_R2s_hourly_lc(i,:) = nanstd(data_tmp);
% end
% 
% 
% figure
% 
% colormap(jet)
% hold on
% barwitherr(std_R2s_hourly_lc, R2s_hourly_lc)
% axis([0.5 9.5 0 1])
% box on
% ylabel('mean R^2')
% set(gca, 'xTick',[1:9],'xTicklabel',LC_unique, 'linewidth', 1.5)
% title('hourly SIF-GPP (clear\_index>0.85)')
% 
% % 
% R2s_hourly = squeeze(R2s(:,2,:));
% 
% for i = 1:11
%     R2s_hourly_lc(i,:) = nanmean(R2s_hourly(strcmp(siteLCs,LC_unique(i)) & R2s_hourly(:,1)>0.1 & R2s_hourly(:,5)>100,1:4));
% end
% subplot(1,2,2)
% hold on
% bar(R2s_hourly_lc)
% axis([0.5 11.5 0 1])
% box on
% ylabel('mean R^2')
% set(gca, 'xTick',[1:11],'xTicklabel',LC_unique, 'linewidth', 1.5)
% title('hourly SIF-GPP (clear\_index>0.75)')
% 
% R2s_hourly = squeeze(R2s(:,3,:));
% for i = 1:11
%     R2s_hourly_lc(i,:) = nanmean(R2s_hourly(strcmp(siteLCs,LC_unique(i)) & R2s_hourly(:,1)>0.2 & R2s_hourly(:,5)>10,1:4));
% end
% subplot(2,2,3)
% hold on
% bar(R2s_hourly_lc)
% axis([0.5 11.5 0 1])
% box on
% ylabel('mean R^2')
% set(gca, 'xTick',[1:11],'xTicklabel',LC_unique, 'linewidth', 1.5)
% title('hourly SIF-GPP (clear\_index>0.8)')
% 
% subplot(2,2,4)
% hold on
% bar(R2s_daily_lc)
% axis([0.5 11.5 0 1])
% box on
% ylabel('mean R^2')
% set(gca, 'xTick',[1:11],'xTicklabel',LC_unique ,'linewidth', 1.5)
% title('daily SIF-GPP (70% of one day: clear\_index>0.7)')
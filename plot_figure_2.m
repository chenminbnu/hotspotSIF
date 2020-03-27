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
LC_unique = {'ENF','DBF','MF','OSH','WSA','SAV','GRA','WET','CRO'};
load('statistics/homogeneous_sites2.mat');


%% hourly
load('statistics/R2_hourly_limit_0.8_new.mat');
R2s_hourly_lc = zeros(9,4);
std_R2s_hourly_lc = zeros(9,4);
R2s_hourly = R2s;

%% boxplot
data = R2s_hourly(R2s_hourly(:,5)>=10 & good_sites == 1,1:4);

%plot
figure; 
set(gcf,'unit','normalized','position',[0.2,0.2,0.5,0.62]);
set(gca, 'Position', [0 0 1 1])

subplot('position',[0.08 0.55 0.4 0.4])
text(0.1,1.1,'a','fontsize',10,'fontname','time new roman','fontweight','bold')
hold on;
h = boxplot(data, 'color','k');%,'Notch','on');
MarkSize = 25;
set(h,{'linew'},{1})
f1 = scatter(1+(rand(size(data,1),1)-0.5)/5,data(:,1),MarkSize,'k','filled');
f1.MarkerFaceAlpha = 0.2;
f1 = scatter(2+(rand(size(data,1),1)-0.5)/5,data(:,2),MarkSize,'k','filled');
f1.MarkerFaceAlpha = 0.2;
f1 = scatter(3+(rand(size(data,1),1)-0.5)/5,data(:,3),MarkSize,'k','filled');
f1.MarkerFaceAlpha = 0.2;
f1 = scatter(4+(rand(size(data,1),1)-0.5)/5,data(:,4),MarkSize,'k','filled');
f1.MarkerFaceAlpha = 0.2;
set(gca,'linewidth',0.5,'xTick',[1 2 3 4],'xTickLabel',{'Hotspot','Nadir','Hemispherical','Total'},...
    'fontSize',8)
ylabel('R^2')
ylim([0 1])
title('Hourly SIF-GPP across all sites')
%% differernt LCs
for i = 1:9
    data_tmp = R2s_hourly(strcmp(siteLCs,LC_unique(i)) &  R2s_hourly(:,5)>=10 & good_sites == 1,1:4);
    R2s_hourly_lc(i,:) = nanmean(data_tmp);
    std_R2s_hourly_lc(i,:) = nanstd(data_tmp);
end

% plot
subplot('position',[0.08 0.05 0.4 0.4])
text(-0.2,1.55,'c','fontsize',10,'fontname','time new roman','fontweight','bold')
hold on
barwitherr(std_R2s_hourly_lc, R2s_hourly_lc)
axis([0.5 9.5 0 1.4])
box on
ylabel('mean R^2')
legend({'Hotspot','Nadir','Hemispherical','Total'},'box','off','location','best')
set(gca, 'xTick',[1:9],'xTicklabel',LC_unique, 'linewidth', 0.5,'Fontsize',8)
title('Hourly SIF-GPP across different PFTs')

%% daily
load('statistics/R2_daily_limit.mat');
R2s_daily_lc = zeros(9,4);
std_R2s_daily_lc = zeros(9, 4);
R2s_daily = R2s;

%% boxplot
data = R2s_daily(R2s_daily(:,5)>=10 & good_sites == 1,1:4);

%plot
subplot('position',[0.55 0.55 0.4 0.4])
text(0.1,1.1,'b','fontsize',10,'fontname','time new roman','fontweight','bold')
hold on;
h = boxplot(data, 'color','k');%,'Notch','on');
set(h,{'linew'},{1})
f1 = scatter(1+(rand(size(data,1),1)-0.5)/5,data(:,1),MarkSize,'k','filled');
f1.MarkerFaceAlpha = 0.2;
f1 = scatter(2+(rand(size(data,1),1)-0.5)/5,data(:,2),MarkSize,'k','filled');
f1.MarkerFaceAlpha = 0.2;
f1 = scatter(3+(rand(size(data,1),1)-0.5)/5,data(:,3),MarkSize,'k','filled');
f1.MarkerFaceAlpha = 0.2;
f1 = scatter(4+(rand(size(data,1),1)-0.5)/5,data(:,4),MarkSize,'k','filled');
f1.MarkerFaceAlpha = 0.2;
set(gca,'linewidth',0.5,'xTick',[1 2 3 4],'xTickLabel',{'Hotspot','Nadir','Hemispherical','Total'},...
    'fontSize',8)
ylabel('R^2')
ylim([0 1])
title('Daily SIF-GPP across all sites')

%% different LCs
for i = 1:9
    data_tmp = R2s(strcmp(siteLCs,LC_unique(i))  & R2s_daily(:,5)>=10 & good_sites == 1,1:4);
    R2s_daily_lc(i,:) = nanmean(data_tmp);
    std_R2s_daily_lc(i,:) = nanstd(data_tmp);
end

% plot
subplot('position',[0.55 0.05 0.4 0.4])
text(-0.2,1.55,'d','fontsize',10,'fontname','time new roman','fontweight','bold')
hold on
barwitherr(std_R2s_daily_lc, R2s_daily_lc)

%%
axis([0.5 9.5 0 1.4])
box on
ylabel('mean R^2')
set(gca, 'xTick',[1:9],'xTicklabel',LC_unique ,'linewidth', 0.5,'Fontsize',8)
title('Daily SIF-GPP across different PFTs')

% save figure
print(gcf, '-dtiff', '-r600', 'figure_2.tif')
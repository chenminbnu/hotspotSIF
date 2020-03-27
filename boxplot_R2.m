figure;
hold on
load('statistics/good_sites.mat');
data = R2s(R2s(:,5)>10 & good_sites == 1,1:4);

h = boxplot(R2s(R2s(:,5)>10 & good_sites == 1,1:4), 'color','k')
set(h,{'linew'},{1.5})
f1 = scatter(1+(rand(size(data,1),1)-0.5)/5,data(:,1),'k','filled');
f1.MarkerFaceAlpha = 0.2;
f1 = scatter(2+(rand(size(data,1),1)-0.5)/5,data(:,2),'k','filled');
f1.MarkerFaceAlpha = 0.2;
f1 = scatter(3+(rand(size(data,1),1)-0.5)/5,data(:,3),'k','filled');
f1.MarkerFaceAlpha = 0.2;
f1 = scatter(4+(rand(size(data,1),1)-0.5)/5,data(:,4),'k','filled');
f1.MarkerFaceAlpha = 0.2;
set(gca,'linewidth',1.5,'xTick',[1 2 3 4],'xTickLabel',{'Hotspot','Nadir','Hemispherical','All leafs'},...
    'fontSize',15)
ylabel('R^2')

%%
siteData = importdata('sites_used.csv');
siteData = siteData.textdata;
siteNames = siteData(2:end,1);
siteLCs = siteData(2:end,7);
StartYears = siteData(2:end, 4);
EndYears = siteData(2:end, 5);
LC_unique = unique(siteLCs);
LC_unique([2,4]) = [];

%%% calculate R2 between hotspot and nadir SIF and GPP
%%% written by dalei hao
%%%

siteData = importdata('sites_used.csv');
siteData = siteData.textdata;
siteNames = siteData(2:end,1);
siteLCs = siteData(2:end,7);
StartYears = siteData(2:end, 4);
EndYears = siteData(2:end, 5);

mainFolder = 'results_retrieved_ab/varied_Vcmax_a_b/';
Folders = dir(mainFolder);

[count,~] = size(Folders);

R2s = zeros(count-2,5);
P_values = zeros(count-2, 4);
RMSEs = zeros(count-2, 5);
for i = 3:count
    % disp(i-2)
    %% load data
    load([mainFolder, '/', Folders(i).name, '/results.mat']);
    Years = results_hotspot(:,3);
    DOYs = results_hotspot(:,4);
    SZAs = results_hotspot(:,5);
    LAIs = results_hotspot(:,6);
    CLC_indexs = results_hotspot(:,7);
    GPPs = results_hotspot(:,11);
    GPP_sunlits = results_hotspot(:,12);
    SIF_hotspots = results_hotspot(:,14);
    SIF_hemis = results_hotspot(:,15);
    SIF_leafs = results_hotspot(:,16);
    SIF_nadirs = results_nadir(:,14);
    Tas = results_hotspot(:,21);
    
    GPP_dailys = [];
    SIF_hotspot_dailys = [];
    SIF_hemi_dailys = [];
    SIF_nadir_dailys = [];
    SIF_leaf_dailys = [];
    Ta_dailys = [];
    tt = 0;
    for j = 1:106
        if(strcmp(siteNames{j}, Folders(i).name))
            tt = j;
            break;
        end
    end
    %% filter day
    load(['results_ab/gpp_errors/filter_doy/' Folders(i).name '.mat']);
    startyear = min(Years);
    endyear = max(Years);
    for year_i = startyear:endyear
        for day_i = 1:1:365
            filters = Years == year_i & Years>=2003 ...
                & DOYs>=day_i & DOYs<day_i+1 ...
                & GPPs>0 & GPPs<100 ...
                & SZAs<90 & SZAs>0 ...
                & SIF_nadirs > 0 ...
                & CLC_indexs<=1 & CLC_indexs>=0 ...
                & SIF_hotspots>0 & SIF_hemis>0 & SIF_leafs>0 & SIF_nadirs>0 ; ...
                filters_clear = filters & CLC_indexs>=0.7;
            if(sum(filters)>7 && sum(filters_clear)>=sum(filters)*0.7 && filter_doys((year_i - startyear)*365+day_i,3)==1) %% screen clear dat
                GPP_dailys  = [GPP_dailys; nanmean(GPPs(filters))];
                SIF_hotspot_dailys  = [SIF_hotspot_dailys; nanmean(SIF_hotspots(filters))];
                SIF_hemi_dailys  = [SIF_hemi_dailys; nanmean(SIF_hemis(filters))];
                SIF_leaf_dailys  = [SIF_leaf_dailys; nanmean(SIF_leafs(filters))];
                SIF_nadir_dailys  = [SIF_nadir_dailys; nanmean(SIF_nadirs(filters))];
                Ta_dailys = [Ta_dailys; nanmean(Tas(filters))];
            end
        end
    end
    %% calculate R2
    %  save(['daily_open_results_const/', siteNames{tt}, '.mat'],'GPP_dailys','SIF_hotspot_dailys','SIF_hemi_dailys','SIF_leaf_dailys','SIF_nadir_dailys')
    filters = GPP_dailys>0;
    Ta_dailys = Ta_dailys(filters);
    GPP_dailys = GPP_dailys(filters);
    SIF_hotspot_dailys  = SIF_hotspot_dailys(filters);
    SIF_hemi_dailys  =SIF_hemi_dailys(filters);
    SIF_leaf_dailys  = SIF_leaf_dailys(filters);
    SIF_nadir_dailys  = SIF_nadir_dailys(filters);
    
    R2s(i-2,1) = calculateR2(GPP_dailys, SIF_hotspot_dailys);
    R2s(i-2,2) = calculateR2(GPP_dailys, SIF_nadir_dailys);
    R2s(i-2,3) = calculateR2(GPP_dailys, SIF_hemi_dailys);
    R2s(i-2,4) = calculateR2(GPP_dailys, SIF_leaf_dailys);
    R2s(i-2,5) = size(GPP_dailys, 1);
    if(R2s(i-2, 5) > 0 )
    [b1,bint,r,rint,stats] = regress(GPP_dailys, [ ones(size(SIF_hotspot_dailys,1),1) SIF_hotspot_dailys ]);
    P_values(i-2, 1) = stats(3);
    [b2,bint,r,rint,stats] = regress(GPP_dailys, [ ones(size(SIF_nadir_dailys,1),1) SIF_nadir_dailys ]);
    P_values(i-2, 2) = stats(3);
    [b3,bint,r,rint,stats] = regress(GPP_dailys, [ ones(size(SIF_hemi_dailys,1),1) SIF_hemi_dailys ]);
    P_values(i-2, 3) = stats(3);
    [b4,bint,r,rint,stats] = regress(GPP_dailys, [ ones(size(SIF_leaf_dailys,1),1) SIF_leaf_dailys ]);
    P_values(i-2, 4) = stats(3);
    
    figure;
    subplot(221)
    hold on
    colormap jet
    scatter(SIF_hotspot_dailys, GPP_dailys,25,'filled','MarkerEdgeColor','k',...
              'MarkerFaceColor','r','linewidth',0.5)
    min_value = max([min(SIF_hotspot_dailys)-0.1, 0]);
    max_value = max(SIF_hotspot_dailys)+ 0.1;
    plot([min_value max_value], [ b1(1,1) + min_value*b1(2,1) b1(1,1) + max_value*b1(2,1) ], 'b', 'linewidth', 1.5)
    text(0.05,18.5,['R^2=' num2str(R2s(i-2,1),'%4.2f'),',p < 0.0001'])
    xlabel('Hotspot SIF')
     ylabel('GPP')
    %  colorbar
    box on
    set(gca, 'linewidth', 1.5)
       ylim([0 20])
    subplot(222)
    hold on
    
    colormap jet
    
    scatter(SIF_nadir_dailys, GPP_dailys,25,'filled','MarkerEdgeColor','k',...
              'MarkerFaceColor','r')
    min_value = max([min(SIF_nadir_dailys)-0.1, 0]);
    max_value = max(SIF_nadir_dailys)+ 0.25;
    plot([min_value max_value], [ b2(1,1) + min_value*b2(2,1) b2(1,1) + max_value*b2(2,1) ], 'b', 'linewidth', 1.5)
      text(0.05,18.5,['R^2=' num2str(R2s(i-2,2),'%4.2f'),',p < 0.0001'])
   % title(['R^2£º' num2str(R2s(i-2,2),'%4.2f'),'; p-value:' num2str(P_values(i-2, 2),'%3.3f')])
    xlabel('Nadir SIF')
    box on
      set(gca, 'linewidth', 1.5)
    %  colorbar
       ylim([0 20])
    subplot(223)
    hold on
    
    colormap jet
    
    scatter( SIF_hemi_dailys, GPP_dailys,25,'filled','MarkerEdgeColor','k',...
              'MarkerFaceColor','r')
    
    min_value = max([min(SIF_hemi_dailys)-0.1, 0]);
    max_value = max(SIF_hemi_dailys)+ 0.5;
    plot([min_value max_value], [ b3(1,1) + min_value*b3(2,1) b3(1,1) + max_value*b3(2,1) ], 'b', 'linewidth', 1.5)
      text(0.25,18.5,['R^2=' num2str(R2s(i-2,3),'%4.2f'),',p < 0.0001'])
   % title(['R^2£º' num2str(R2s(i-2,3),'%4.2f'),'; p-value:' num2str(P_values(i-2, 3),'%3.3f')])
   
    xlabel('Hemispherical SIF')
     ylabel('GPP')
    box on
    % colorbar
    set(gca, 'linewidth', 1.5)
       ylim([0 20])
       
    subplot(224)
    hold on
    
    colormap jet
    
    scatter(SIF_leaf_dailys, GPP_dailys,25,'filled','MarkerEdgeColor','k',...
              'MarkerFaceColor','r')
    min_value = max([min(SIF_leaf_dailys)-0.1, 0]);
    max_value = max(SIF_leaf_dailys)+ 1;
    plot([min_value max_value], [ b4(1,1) + min_value*b4(2,1) b4(1,1) + max_value*b4(2,1) ], 'b', 'linewidth', 1.5)
    text(0.5,18.5,['R^2=' num2str(R2s(i-2,4),'%4.2f'),',p < 0.0001'])
    %text(0.1,18.5,['R^2£º' num2str(R2s(i-2,4),'%4.2f'),' p-value<0.0001'])
    xlabel('All leafs SIF')
    ylim([0 20])
   % xlim([0 15])
  %  ylabel('GPPs')
    box on
    %  colorbar
    set(gca, 'linewidth', 1.5)
    
    suptitle([siteNames{tt},'-',siteLCs{tt}])
    saveas(gcf,['results_ab/','daily_results_limit/' siteLCs{tt} '-' siteNames{tt} '_daily.png'])
    close all
    end
    %     close all
end
%
% figure;
% hold on
% plot(R2s(:,1),'r')
% plot(R2s(:,2),'g')
% plot(R2s(:,3),'b')
% plot(R2s(:,4),'k')
% subplot(1,2,2)
% hist(R2s(:,1:4))
% figure;
% hold on
% plot(RMSEs(:,1),'r')
% plot(RMSEs(:,2),'g')
% plot(RMSEs(:,3),'b')
% plot(RMSEs(:,4),'k')
% subplot(155)
% hist(R2s(:,5,1:4))

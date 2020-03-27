%%% calculate R2 between hotspot and nadir SIF and GPP
%%% written by dalei hao
%%%
%
siteData = importdata('sites_used.csv');
siteData = siteData.textdata;
siteNames = siteData(2:end,1);
siteLCs = siteData(2:end,7);
StartYears = siteData(2:end, 4);
EndYears = siteData(2:end, 5);


mainFolder = 'update_varied_Vcmax/';
Folders = dir(mainFolder);
[count,~] = size(Folders);

R2s = zeros(count-2,4); % hotspot, nadir, hemi, all leaf, all photosystem
P_values =  zeros(count-2,4);
for i =3:count
    %% get landcover type
    tt = 0;
    for j = 1:106
        if(strcmp(siteNames{j}, Folders(i).name))
            tt = j;
            break;
        end
    end
    
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
    Tas2 = results_nadir(:,21);
    %% filter out
    
    %% filter winter
    %      load(['gpp_errors/filter_doy/' Folders(i).name '.mat']);
    %
    %      counts_i = size(Years,1);
    %      filter_doy_all =zeros(counts_i,1);
    %      for tt = 1:counts_i
    %           counts_ii = size(filter_doys,1);
    %         for ttt = 1:counts_ii
    %             if(filter_doys(ttt,1) == Years(tt) & filter_doys(ttt,2) == floor(DOYs(tt)))
    %                 filter_doy_all(tt) = filter_doys(ttt,3);
    %                 break;
    %             end
    %         end
    %      end
    %
    % filter invalida values
    filters = GPPs>0 & GPPs<60 ... 
        &  LAIs>=2   ...% LAIs<2 &LAIs>=2 & LAIs<4 LAIs<4 & (DOYs-floor(DOYs))>10/24 & (DOYs-floor(DOYs))<15/24 ...% & (DOYs-floor(DOYs))<10/24  ...
        & SZAs<70 & Years>=2003 ...
        & SIF_nadirs > 0 ...     
        & CLC_indexs<=1 & CLC_indexs>=0.7 ...
        & SIF_hotspots>0 & SIF_hemis>0 & SIF_leafs>0 & SIF_nadirs>0; ...
   
        if sum(filters)>0
        SZAs = SZAs(filters);
        LAIs = LAIs(filters);
        CLC_indexs = CLC_indexs(filters);
        GPPs = GPPs(filters);
        GPP_sunlits = GPP_sunlits(filters);
        SIF_hotspots = SIF_hotspots(filters);
        SIF_hemis = SIF_hemis(filters);
        SIF_leafs = SIF_leafs(filters);
        SIF_nadirs = SIF_nadirs(filters);
        Tas = Tas(filters);
        %% calculate R2
        R2s(i-2,1) = calculateR2(GPPs, SIF_hotspots);
        [b,bint,r,rint,stats] = regress(GPPs, [ ones(size(SIF_hotspots,1),1) SIF_hotspots ]);
        P_values(i-2, 1) = stats(3);
        
        R2s(i-2,2) = calculateR2(GPPs, SIF_nadirs);
        [b,bint,r,rint,stats] = regress(GPPs, [ ones(size(SIF_nadirs,1),1) SIF_nadirs ]);
        P_values(i-2, 2) = stats(3);
        
        R2s(i-2,3) = calculateR2(GPPs, SIF_hemis);
        [b,bint,r,rint,stats] = regress(GPPs, [ ones(size(SIF_hemis,1),1) SIF_hemis ]);
        P_values(i-2, 3) = stats(3);
        
        R2s(i-2,4) = calculateR2(GPPs, SIF_leafs);
        [b,bint,r,rint,stats] = regress(GPPs, [ ones(size(SIF_leafs,1),1) SIF_leafs ]);
        P_values(i-2, 4) = stats(3);
        
        R2s(i-2,5) = sum(filters);
        
        
%         %% plot
%         figure;
%         subplot(221)
%         colormap jet
%         scatter(GPPs, SIF_hotspots,10,SZAs,'filled')
%         title(['R^2£º' num2str(R2s(i-2,1),'%4.2f'),'; p-value:' num2str(P_values(i-2, 1),'%3.3f')])
%         ylabel('Hotspot SIF')
%         maxy = max([SIF_hotspots' SIF_nadirs']);
%         ylim([0 maxy])
%         set(gca, 'linewidth',1.5)
%         colorbar
%         box on
%         subplot(222)
%         colormap jet
%         scatter(GPPs, SIF_nadirs,10,SZAs,'filled')
%         title(['R^2£º' num2str(R2s(i-2,2),'%4.2f'),'; p-value:' num2str(P_values(i-2, 2),'%3.3f')])
%         ylabel('Nadir SIF')
%         box on
%         ylim([0 maxy])
%         set(gca, 'linewidth',1.5)
%         % colorbar
%         subplot(223)
%         colormap jet
%         scatter(GPPs, SIF_hemis,10,SZAs,'filled')
%         title(['R^2£º' num2str(R2s(i-2,3),'%4.2f'),'; p-value:' num2str(P_values(i-2, 3),'%3.3f')])
%         xlabel('GPPs')
%         ylabel('Hemisphere SIF')
%         box on
%         set(gca, 'linewidth',1.5)
%         %  colorbar
%         subplot(224)
%         colormap jet
%         scatter(GPPs, SIF_leafs,10,SZAs,'filled')
%         title(['R^2£º' num2str(R2s(i-2,4),'%4.2f'),'; p-value:' num2str(P_values(i-2, 4),'%3.3f')])
%         xlabel('GPPs')
%         ylabel('All leaf SIF')
%         box on
%         set(gca, 'linewidth',1.5)
%         % colorbar
%         suptitle([Folders(i).name, '-', siteLCs{tt}])
%         saveas(gcf,['hourly_results_limit_0.7_midday/' siteLCs{tt} '-' Folders(i).name '.png'])
%         close all
        end
end
% % show figure
% R2s(R2s(:,5)<100,:) = nan;
% figure;
% subplot(121)
% hold on
% plot(R2s(:,1),'r')
% plot(R2s(:,2),'g')
% plot(R2s(:,3),'b')
% plot(R2s(:,4),'k')
% subplot(122)
% hist(R2s(:,1:4))
% nanmean(R2s(:,1:4))
%
%
% figure;
% subplot(131)
% hist(R2s_0_8(:,1:4))
% subplot(132)
% hist(R2s_0_85(:,1:4))
% subplot(133)
% hist(R2s_0_9(:,1:4))
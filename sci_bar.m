classdef sci_bar
    %% Plot professional scientific bar plot the fun and easy way
    % Made by an actual scientist, almost publication ready
    % Author: Jiun Yen
    % Date: 2017.7.21
    % Version: 2017.7.21
    
    properties
        data
        groupIDs
        sampleIDs
        plotSE
        labelX
        labelY
    end
    properties(GetAccess = private)
        Ndata
        groups
        Ngroups
        samples
        Nsamples
    end
    properties(Dependent)
        stat
    end
    
    methods
        %% initialize object
        function obj = sci_bar(data,groupIDs,sampleIDs,plotSE,labelX,labelY)
            
            % a vector of numeric data
            if nargin < 1 || isempty(data)
                error('Gotta have data, bro! i.e. h=sci_bar(data)');
            else
                obj.data = data;
                obj.Ndata = length(data);
            end
            
            % an array of names of groups
            if nargin < 2 || isempty(groupIDs)
                obj.groupIDs = repmat({'Group 1'},obj.Ndata,1);
                obj.groups = {'Group 1'};
                obj.Ngroups = 1;
                fprintf('Just 1 group, eh mate!\n');
            else
                [i,~] = size(groupIDs);
                if i == 1
                    obj.groupIDs = groupIDs';
                else
                    obj.groupIDs = groupIDs;
                end
                obj.groups = unique(groupIDs,'stable');
                obj.Ngroups = length(obj.groups);
            end
            
            % an array of names of samples
            if nargin < 3 || isempty(sampleIDs)
                obj.sampleIDs = repmat({'Sample 1'},obj.Ndata,1);
                obj.samples = {'Sample 1'};
                obj.Nsamples = 1;
                fprintf('All the same stuff, yea?!\n');
            else
                [i,~] = size(sampleIDs);
                if i == 1
                    obj.sampleIDs = sampleIDs';
                else
                    obj.sampleIDs = sampleIDs;
                end
                obj.samples = unique(sampleIDs,'stable');
                obj.Nsamples = length(obj.samples);
            end
            
            % Whether to plot standard deviation or standard error
            if nargin < 4 || isempty(plotSE)
                obj.plotSE = true;
                fprintf('Standard error alright?!\n');
            else
                obj.plotSE = plotSE;
            end
            
            % X-axis label
            if nargin < 5 || isempty(labelX)
                fprintf('Keeping your X a secret, eh?!\n');
            else
                obj.labelX = labelX;
            end
            
            % Y-axis label
            if nargin < 6 || isempty(labelY)
                fprintf('Y not?!\n');
            else
                obj.labelY = labelY;
            end
            
        end
        
        %% do stat
        function stat = get.stat(obj)
            stat.mean = zeros(obj.Ngroups, obj.Nsamples);
            stat.std = stat.mean;
            stat.se = stat.mean;
            stat.size = stat.mean;
            for i = 1:obj.Ngroups
                g_indicies = ismember(obj.groupIDs, obj.groups(i));
                for j = 1:obj.Nsamples
                    sub_data = obj.data(g_indicies & ismember(obj.sampleIDs, obj.samples(j)));
                    if ~isempty(sub_data)
                        stat.mean(i,j) = mean(sub_data);
                        stat.size(i,j) = length(sub_data);
                        stat.std(i,j) = std(sub_data);
                        stat.se(i,j) = stat.std(i,j)/sqrt(stat.size(i,j));
                    end
                end
            end
        end
        
        %% make plot
        function plot(obj)
            
            set(0,'DefaultAxesFontName', 'Times New Roman')
            
            % calculate x-coordinates for bars/error bars
            if obj.Ngroups == 1
                groupwidth = min(0.8, obj.Nsamples/(obj.Nsamples+1.5));
                x(1:obj.Nsamples,1) = (1:obj.Nsamples) - groupwidth/2 + 1 * groupwidth / 2;
                xlim([0.4 obj.Nsamples+0.6]);
                xticklabel = obj.samples;
            else
                groupwidth = min(0.8, obj.Nsamples/(obj.Nsamples+1.5));
                x = zeros(obj.Ngroups,obj.Nsamples);
                for i = 1:obj.Nsamples
                    x(1:obj.Ngroups,i) = (1:obj.Ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*obj.Nsamples);
                end
                xticklabel = obj.groups;
            end
            
            % plot bars
            if obj.Ngroups > 1 && obj.Nsamples > 1
                c = linspace(0.4, 1, obj.Nsamples)';
                colormap([c c c])
                bar(obj.stat.mean,'LineWidth',0.5,'EdgeColor','k');
                legend(obj.samples,'box','off')
            else
                bar(x,obj.stat.mean,0.5,'LineWidth',0.5,'FaceColor',[0.75 0.75 0.75],'EdgeColor','k');
            end
            box off
            
            % plot error bars
            hold on
            if obj.plotSE
                errorbar(x,obj.stat.mean,obj.stat.se,'k','LineWidth',0.5,'LineStyle','none');
            else
                errorbar(x,obj.stat.mean,obj.stat.std,'k','LineWidth',0.5,'LineStyle','none');
            end
            
            % write text
            set(gca,'XTickLabel',xticklabel,'FontSize',12)
            if ~isempty(obj.labelX)
                xlabel(obj.labelX,'FontSize',12);
            end
            if ~isempty(obj.labelY)
                ylabel(obj.labelY,'FontSize',14);
            end
            
        end
    end
end

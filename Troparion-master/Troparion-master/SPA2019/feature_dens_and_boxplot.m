function [] = feature_dens_and_boxplot(h_data,p_data, feature_name,band_width, feature_lim)
%FEATURE_DENS_PLOT Displays ksdensity for some feature for healthy and
%pathology groups.
%   h_data - healthy group values
%   p_data - pathology group values.

%   h_data - healthy group values
%   p_data - pathology group values.
h_len = length(h_data);
p_len = length(p_data);


Group = [];
for n=1:length(h_data)
    data(n) = h_data(n);
%     Group = [Group; 'Healthy'];
    Group = [Group; '��������'];
end
k = 1;
for n=h_len+1:h_len+p_len
    data(n) = p_data(k);
%     Group = [Group; 'ALS    '];
    Group = [Group; '���     '];
    k = k + 1;
end

%% Drawing
    FontSize = 11;
    FontSize2 = 13;
    
    
%     Width=round(480);
%     Height=round(200);
    
    Width=round(390);
    Height=round(160);
    
    figure('Position',[100 100 100+Width 100+Height]);
    
    ax1_x_offset = 0.07;      % offset
    ax1_y_offset = 0.2;      % offset
    ax1_width  = 0.29;      % width
    ax1_height = 0.72;
    axes('Position',[ax1_x_offset, ax1_y_offset, ax1_width, ax1_height]);
    
    
    
%     subplot(1,5,[1 2]);
% boxplot(data, Group,'color','k');
    h = boxplot(data, Group,'colors',[[0 136 190]/255; [205 92 92]/255]);
    set(h,{'linew'},{1.5});    
        ylim(feature_lim);
    
    set (gca                    ,...
        'FontName', 'Helvetica',...
        'FontSize', FontSize);
    
    set(gca, ...
        'Box'       ,'off'          ,...
        'TickDir'   ,'out'          ,...
        'TickLength',[0.02,0.02]    ,...
        'XMinorTick','on'           ,...
        'YMinorTick','on'           ,...
        'YGrid'     ,'on'           ,...
        'XGrid'     ,'on'           ,...
        'XColor'    ,[0.1 0.1 0.1]  ,...
        'YColor'    ,[0.1 0.1 0.1]  ,...
        ...'XTick'     ,round((Lim(1):0.50:Lim(2))*10)/10        ,...
    ...  'YTick'     ,-0.6:0.3:0.6       ,...
    ...     'YTick'     ,-0.07:0.02:0.07        ,...
        'FontSize', FontSize             ,...
        'LineWidth' ,1.5            );
    
    ylabel(['$$' feature_name '$$'],'Interpreter','latex', 'FontSize', FontSize2);
    
    
    %% ks_density
    [y,x]   = ksdensity(h_data,'Bandwidth',band_width); 
    [y1,x1] = ksdensity(p_data,'Bandwidth',band_width);
   
    
%     subplot(1,5,[3 4 5]);
    ax2_x_offset = 0.45;      % offset
    ax2_y_offset = ax1_y_offset;      % offset
    ax2_width  = 0.46;      % width
    ax2_height = ax1_height;
    axes('Position',[ax2_x_offset, ax2_y_offset, ax2_width, ax2_height]);

%     hLine=plot(x,y,'DisplayName','Healthy');
    hLine=plot(x,y,'DisplayName','��������');
    
    hYLabel = ylabel([]);

    set (gca                    ,...
        'FontName', 'Helvetica');
    
    set ([hYLabel]      ,...
        'FontSize', FontSize,...
        'FontName', 'Times New Roman');


    set(hLine,...
        ...'Color',[0,0,0.0]          ,...
        'Color',[0 136 190]/255,...
        'LineWidth',1.5);

    set ([hYLabel]      ,...
        'FontSize', FontSize,...
        'FontName', 'Times New Roman');

    set(gca, ...
        'Box'       ,'off'          ,...
        'TickDir'   ,'out'          ,...
        'TickLength',[0.02,0.02]    ,...
        'XMinorTick','on'           ,...
        'YMinorTick','on'           ,...
        'YGrid'     ,'on'           ,...
        'XGrid'     ,'on'           ,...
        'XColor'    ,[0.1 0.1 0.1]  ,...
        'YColor'    ,[0.1 0.1 0.1]  ,...
        ...'XTick'     ,round((Lim(1):0.50:Lim(2))*10)/10        ,...
    ...  'YTick'     ,-0.6:0.3:0.6       ,...
    ...     'YTick'     ,-0.07:0.02:0.07        ,...
        'FontSize', FontSize             ,...
        'LineWidth' ,1.5            );


    hold on;

%     hLine1=plot(x1,y1,'--','DisplayName','ALS');
    hLine1=plot(x1,y1,'--','DisplayName','���');
    xlim(feature_lim);
    
    set(hLine1                               ,...
        ...'Color',[0,0,0.0]          ,...
        'Color',[205 92 92]/255          ,...
        'LineWidth',2.0);

    set(gca, ...
        'Box'       ,'off'          ,...
        'TickDir'   ,'out'          ,...
        'TickLength',[0.02,0.02]    ,...
        'XMinorTick','on'           ,...
        'YMinorTick','on'           ,...
        'YGrid'     ,'on'           ,...
        'XGrid'     ,'on'           ,...
        'XColor'    ,[0.1 0.1 0.1]  ,...
        'YColor'    ,[0.1 0.1 0.1]  ,...
        ...'XTick'     ,round((Lim(1):0.50:Lim(2))*10)/10        ,...
    ...     'YTick'     ,-0.6:0.3:0.6       ,...
    ...     'YTick'     ,-0.07:0.02:0.07        ,...
        'FontSize', FontSize             ,...
        'LineWidth' ,1.5);

    legend(gca,'show');
    
    xlabel(['$$' feature_name '$$'],'Interpreter','latex', 'FontSize', FontSize2);
    
    
%% Print png

    set(gcf, 'PaperPositionMode', 'auto');
    FileName = [feature_name '_dens_box_plot.png'];
    print('-dpng', '-zbuffer','-r300',FileName);
    
% %     FileName = [feature_name '_dens_boxplot.pdf'];
% %     print('-dpdf', '-zbuffer','-r300',FileName);
end

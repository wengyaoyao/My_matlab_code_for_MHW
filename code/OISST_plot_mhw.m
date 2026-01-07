%This is view the MHW duration and max intensitty
%Edit data：2026.1.4
%==========================================================================
% Edit:2026.1.7
% change the load data in line 11
%==========================================================================
clc;clear;close all;

%data input
%load('../output/OISST_MHW_20151101_20160430.mat')
load('../output/OISST_MHW_20151101_20160430_1982_2016.mat')

[nlon,nlat] = meshgrid(lon,lat);
[a,b] = size(MHW);

%% calculate the durition day
mhw_dur = zeros(241,101);
for i = 1:a
    x = MHW.xloc(i);
    y = MHW.yloc(i);
    mhw_dur(x,y) = mhw_dur(x,y) + MHW.mhw_dur(i);
end
mhw_dur(mhw_dur == 0) = NaN;

%% color for picture
cmap1 = [
    0   0 130
    0   0 255
    0 120 255
    0 200 200
    0 255 120
  120 255   0
  200 255   0
  255 255   0
  255 180   0
  255 120   0
  255  50   0
  180   0   0
] / 255;

cmap2 = [
    255 255 255
    255 255 210
    255 255   0
    255 200   0
    255 140   0
    255   0   0
    180   0   0
    100   0   0
] / 255;

%% Plot the duration day
figure;
set(gcf,'position',[10,45,1550,770],'color','w');
m_proj('miller','lon',[100,160],'lat',[-25,-5]);
% m_pcolor(nlon,nlat,mhw_dur');
levels = [0,25,50,75,100,125,150,175,200,225,250,275,300];
h = m_contourf(nlon,nlat,mhw_dur',levels,'linestyle','none');
m_grid('fontsize',25,'linewidth',3, ...
    'xtick',[115,145],'ytick',[-20,-10], ...
    'fontname','Times Newrom','fontweight','bold');
m_coast('patch',[.7 .7 .7]);
title('OISST 20151101-20160430  MHW duration days','fontsize',20);

colormap(cmap1);
b1 = colorbar('southoutside');
b1.Ticks = 0:50:300;

b1.FontSize = 20;
b1.Label.String = 'Days';

caxis([0,300]);

set(b1,'position',[.17 .1 .7 .03])

clear mhw_dur

%% calculate max intensity

mhw_max = zeros(241,101);

for i = 1:a
    if i ==1
        x2 = MHW.xloc(i);
        y2 = MHW.yloc(i);       
        mhw_max(x2,y2) = MHW.int_max(i);
        x1 = x2;
        y1 = y2;
    else
        x2 = MHW.xloc(i);
        y2 = MHW.yloc(i);
        if x1 == x2 && y1 == y2
            mhw_max(x2,y2) = max(MHW.int_max(i),MHW.int_max(i-1));
            x1 = x2;
            y1 = y2;
        else
            mhw_max(x2,y2) = MHW.int_max(i);
            x1 = x2;
            y1 = y2;
        end
    end
end

mhw_max(mhw_max == 0) = NaN;

%% plot max intensity

figure;
set(gcf,'position',[10,45,1550,770],'color','w');
m_proj('miller','lon',[100,160],'lat',[-25,-5]);
% m_pcolor(nlon,nlat,mhw_dur');
levels = 0:0.5:4;
h = m_contourf(nlon,nlat,mhw_max',levels,'linestyle','none');
m_grid('fontsize',25,'linewidth',3, ...
    'xtick',[115,145],'ytick',[-20,-10], ...
    'fontname','Times Newrom','fontweight','bold');
m_coast('patch',[.7 .7 .7]);
title('OISST 20151101-20160430  MHW max intensity','fontsize',20);

colormap(cmap2);
b1 = colorbar('southoutside');
b1.Ticks = 0:1:4;
b1.FontSize = 20;
b1.Label.String = '℃';

caxis([0,4]);

set(b1,'position',[.17 .1 .7 .03])

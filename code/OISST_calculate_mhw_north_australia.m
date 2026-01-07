%This is using OISST data to calculate MHW
% Edit：2026.1.3
%==========================================================================
clc;clear;close all;

%data input
load('../output/OISST_t_interp_0_25_north_australia.mat','t','lon','lat','time');

%% calculate MHW
% [MHW,mclim,m90,mhw_ts]=detect(t,datenum(1982,1,1):datenum(2020,12,31),datenum(1993,1,1),datenum(2012,12,31),datenum(2016,1,1),datenum(2017,12,30));
[MHW,mclim,m90,mhw_ts]=detect(t,datenum(1982,1,1):datenum(2020,12,31),datenum(1993,1,1),datenum(2012,12,31),datenum(2015,11,1),datenum(2016,4,31));

%% save data

% save('../output/OISST_MHW_20160101_20171230.mat','MHW','m90','mclim','mhw_ts','lon','lat');
save('../output/OISST_MHW_20151101_20160431.mat','MHW','m90','mclim','mhw_ts','lon','lat');
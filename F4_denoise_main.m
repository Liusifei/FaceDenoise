% F4_denoise_main.m
clear;clc;close all
%% set up
pos = find(pwd=='\',3);
root = pwd; root = root(1:pos(3));

im_src = fullfile(root,'yuli');
im_dst = fullfile(root,'results_yuli');
if ~exist(im_dst,'dir')
    mkdir(im_dst);
end
mode = 4;
% method = {'nonlocalmeans','TV','bilateral','gaussian','bandpass'};
% printf('which method: [1]. nonlocal means; [2] TV\n');
method = 'bandpass';
addpath(genpath(fullfile(root,'face denosing')));
resultfolder = fullfile(im_dst,sprintf('%s_%d', method, mode));
if ~exist(resultfolder,'dir')
    mkdir(resultfolder);
end
%% main
im_list = dir([im_src,'\','*.png']);
imnum = length(im_list);

for m = 1:imnum
    fprintf('implementing image %s\n',im_list(m).name);
    imname = fullfile(im_src,im_list(m).name);
    I = imread(imname);
    [L,c1,c2] = imreadbw(imname, 3);
    dL = T1_imdenoise(I,method);
    
    edge_bw = edge(L,'canny',[0.03,0.12]);
    dimg = T1_EdgeSmoothing(I, dL, edge_bw);
    
figure(1);subplot(121);imshow(I);

h1 = figure(1);subplot(122);imshow(dimg,[]);

savename1 = fullfile(resultfolder, [method,'_',im_list(m).name]);
imwrite(dimg,savename1);
savename2 = fullfile(resultfolder, ['comp_',im_list(m).name]);
if strcmp(savename2(end-2:end),'JPG')
    savename2(end-2:end) = 'jpg';
end
saveas(h1,savename2);
end
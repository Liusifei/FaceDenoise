function [cimg,dimg] = T1_TVcompensation(img, sigma)
%% baseline TV
[r,c] = size(img);
x = TVD_mm(img(:), sigma, 20);
y = reshape(x,[r,c])';
y = TVD_mm(y(:), sigma, 20);
dimg = reshape(y,[c,r])';
%% image filter
h = fspecial('gaussian', [3,3], 1.6);
gimg = imfilter(img, h);
%% compensation
[gx,gy] = gradient(gimg);
[dx,dy] = gradient(dimg);
grad_g = (gx + gy)/2;
grad_d = (dx + dy)/2;
% grad_g = min(gx , gy);
% grad_d = min(dx , dy);
cimg = dimg;
cimg(grad_g > grad_d) = gimg(grad_g > grad_d);

function [dimg,cimg] = T1_imdenoise(img, method)
cimg = 0;
sigma = 0.2 * max(size(img));
switch method
    case 'nonlocalmeans'
        dimg = FAST_NLM_II(img,3,2,sigma);
    case 'TV'
        %%
        sigma = (.02/400) * max(size(img));
        [cimg,dimg] = T1_TVcompensation(img, sigma);
        %         x = TVD_mm(img(:), sigma, 20);
        %         y = reshape(x,[r,c])';
        %         y = TVD_mm(y(:), sigma, 20);
        %         dimg = reshape(y,[c,r])';
        %         %%
        %         detail = img - dimg;
        %         h = fspecial('gaussian', [9,9], 3);
        %         detail = imfilter(detail, h);
        %         detail = imadjust(detail);
        %         %%
        %         dimg = dimg + detail;
    case 'bilateral'
        % Set bilateral filter parameters.
        w     = 3;       % bilateral filter half-width
        sigma = [1.5 20]; % bilateral filter standard deviations
        sigma = (sigma / 600) * max(size(img));
        dimg = bfilter2(img,w,sigma);
    case 'gaussian'
        %% image filter
        h = fspecial('gaussian', [10,10], 8);
        dimg = imfilter(img, h);
    case 'bandpass'
        dimg = T2_MultiDoG(img);
end
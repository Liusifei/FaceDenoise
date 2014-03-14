% EDGESOMMTHIMG.m produce the edages by preserveing the edge-data in
% ref_im, and generates new pixels of other regions from dst_im.
% In face denoising it helps preserving the edge area. 
% In face beautification, it helps manipulating the mask's boundaries.
% Input:
% ref_im: original image or image layer;
% dst_im: processed image or image layer
% edge_bw: binary image of edge map;
% Output:
% rut_im: combined result image
% Sifei Liu, 05/30/2013

function rut_im = T1_EdgeSmoothing(ref_im, dst_im, edge_bw)
%% parameters configuration
w_im = double(edge_bw);
% thr = 10;
[r,c,n] = size(ref_im);
thr = floor(min(r,c)/40);
w_im(1:thr,:) = 1; w_im(end-thr:end,:) = 1;
w_im(:,1:thr) = 1; w_im(:,end-thr:end) = 1;
%% find the nearest edge point
[er,ec] = find(edge_bw == 1);
e_len = length(er);
mat = T1_RangeMat(thr);
for m = 1:e_len
    if and(and(er(m)>thr+1,er(m)<r-thr-1),and(ec(m)>thr+1,ec(m)<c-thr-1))
    w_im(er(m)-thr:er(m)+thr,ec(m)-thr:ec(m)+thr) = max(w_im(er(m)-thr:er(m)+thr,ec(m)-thr:...
        ec(m)+thr),mat);
    end
end
%% update image according to weighing map
rut_im = uint8(repmat(w_im,[1,1,n]) .* double(ref_im) + (1-repmat(w_im,[1,1,n])) .* double(dst_im));

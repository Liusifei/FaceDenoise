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

function rut_im = EdgeSmoothing(ref_im, dst_im, edge_bw, mask)
%% parameters configuration
w_im = double(edge_bw);
thr = 7;
% k_im = (1 - w_im) * thr;
[r,c] = size(ref_im);
if edge_bw == 0
edge_bw = edge(mask,'canny',[0.022,0.08]);    
end
%% find the nearest edge point
[er,ec] = find(edge_bw == 1);
e_len = length(er);
mat = T1_RangeMat(thr);
for m = 1:e_len
    if and(and(er(m)>thr,er(m)<r-thr),and(ec(m)>thr,ec(m)<c-thr))
    w_im(er(m)-thr:er(m)+thr,ec(m)-thr:ec(m)+thr) = max(w_im(er(m)-thr:er(m)+thr,ec(m)-thr:...
        ec(m)+thr),mat);
    end
end
%% update image according to weighing map
rut_im = w_im .* ref_im + (1-w_im) .* dst_im;

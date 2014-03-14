function [L,c1,c2,MAX,MIN]= imreadbw(impath, mode)
MAX = zeros(1,3);MIN = MAX;
img = imread(impath);
% if max(size(img)) > 1000
%    img = imresize(img,1000/max(size(img)),'bilinear');
% end
figure(1);subplot(121);imshow(img);
switch mode
    case 1
        [L,c1,c2] = rgb2hsv(img);
    case 2
        img = rgb2ycbcr(im2double(img)); 
        c1 = img(:,:,2);
        c2 = img(:,:,3);
    case 3
        [L,c1,c2] = RGB2Lab(img);
        [L,MAX(1),MIN(1)] = normalization(L);
        % ========== color ===========
        [c1,MAX(2),MIN(2)] = normalization(c1);
        [c2,MAX(3),MIN(3)] = normalization(c2);
        % ============================
end
end

function [L,MAX,MIN] = normalization(L)

MIN = min(min(L));MAX = max(max(L));
L = (L-MIN)/(MAX-MIN);
end
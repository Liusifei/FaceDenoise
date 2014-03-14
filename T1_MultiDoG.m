function [DI,RI] = T1_MultiDoG(I,layer)

savepath = 'D:\Tools\百度云同步盘\face denosing\multi-layer';
if nargin == 1
layer = 8;
end
h = fspecial('gaussian',[3,3],sqrt(2));

if length(size(I)) == 3
    [L,a,b] = RGB2Lab(I);
    maxL = max(max(L));minL = min(min(L));
    L = Normalize(L,maxL,minL);
else
    maxL = max(max(I));minL = min(min(I));
    L = Normalize(I,maxL,minL);
end
DI = cell(1,layer+1);
DI{1,1} = L;
da = a;
db = b;
for m = 1:layer
    DI{1,m+1} = imfilter(DI{1,m},h);
    da = imfilter(da,h);
    db = imfilter(db,h);
    imwrite(DI{1,m+1},fullfile(savepath,sprintf('%.2d.png',m)));
end
RL = DI{1,1}-(DI{1,2}-DI{1,4})-(DI{1,5}-DI{1,39});
RI = ReNormalize(RL, maxL,minL);
if length(size(I)) == 3
    RI = lab2RGB(RI,da,db);
end
close all
imshow(RI);
end

function I = Normalize(I,MAX,MIN)
I = (I - MIN)/(MAX-MIN);
end

function I = ReNormalize(I, MAX, MIN)
I = I * (MAX-MIN) + MIN;
end
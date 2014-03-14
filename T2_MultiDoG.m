function RI = T2_MultiDoG(I)

layer = 6;
l = floor(min(size(I,1),size(I,2))/10);
if l >= 50
    hl = fspecial('gaussian',[3,3],sqrt(2));
    l1=2;l2=3;l3=5;
else
    hl = fspecial('gaussian',[2,2],sqrt(2));
    l1=1;l2=5;l3 = l2;
end
hh = fspecial('gaussian',[l,l],sqrt(l/2));

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
da = imfilter(a,hh);
db = imfilter(b,hh);

for m = 1:layer
    DI{1,m+1} = imfilter(DI{1,m},hl);
end
Dh = imfilter(L,hh);

% RL = DI{1,1}-(DI{1,l1}-DI{1,l2})-(DI{1,l3}-Dh);
RL = DI{1,1}-(DI{1,2}-Dh);

RI = ReNormalize(RL, maxL,minL);

if length(size(I)) == 3
    RI = Lab2RGB(RI,da,db);
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
function img = imcombin(L, c1, c2, mode)

switch mode
    case 1
        hsv(:,:,1) = L;
        hsv(:,:,2) = c1;
        hsv(:,:,3) = c2;
        img = hsv2rgb(hsv);
    case 2
        ycbcr(:,:,1)=L;
        ycbcr(:,:,2)=c1;
        ycbcr(:,:,3)=c2;
        img = ycbcr2rgb(ycbcr);
    case 3
        [r,g,b] =  Lab2RGB(L, c1, c2);
        img(:,:,1) = uint8(r);
        img(:,:,2) = uint8(g);
        img(:,:,3) = uint8(b);
end
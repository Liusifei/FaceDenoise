function mask = T1_GenerateMasks(exemplar,uv)

load('ind.mat');
mask.eye = logical(roipoly(exemplar,uv(lefteye_ind,1),uv(lefteye_ind,2)) + ...
    roipoly(exemplar,uv(righteye_ind,1),uv(righteye_ind,2)));
mask.eyeshade = logical(roipoly(exemplar,uv(lefteyeshade_ind,1),uv(lefteyeshade_ind,2)) + ...
    roipoly(exemplar,uv(righteyeshade_ind,1),uv(righteyeshade_ind,2)));
mask.lip = logical(roipoly(exemplar,uv(mouup_ind,1),uv(mouup_ind,2)) + ...
    roipoly(exemplar,uv(moulo_ind,1),uv(moulo_ind,2)));
mask.lipcv = logical(roipoly(exemplar,uv(moucv_ind,1),uv(moucv_ind,2)));

mask.c1 = logical(1 - mask.eye - mask.lip - mask.lipcv); % skin region
mask.c2 = logical(mask.lip);                             % lips
mask.c3 = logical(mask.lipcv + mask.eye);                % eyes and mouth cavity


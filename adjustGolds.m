%fill holes all
%{
goldFolder = 'dataset/golds/imageNamePre*';
imgs = dir(goldFolder);
for i=1:length(imgs)
    if imgs(i).isdir == 0
        im = imread(['dataset/golds/' imgs(i).name]);
        im = imfill(im);
        imwrite(im,['dataset/golds/' imgs(i).name]);
    end
end
%}
%fill holes
%{
L={'imageName'};

for i=1:length(L)
    im = imread(['dataset/golds/' L{i} '.png']);
    im = imfill(im);
    imwrite(im,['dataset/golds/' L{i} '.png']);
end
%}

%{
goldFolder = 'dataset/golds/imageNamePre*';
imgs = dir(goldFolder);
for i=1:length(imgs)
    if imgs(i).isdir == 0
        im = imread(['dataset/golds/' imgs(i).name]);
        goldB = uint8(im>0);
        imwrite(goldB,['dataset/goldsBinary/' imgs(i).name]);
        figure;
        title(imgs(i).name);
        imshow(imread(['dataset/goldsBinary/' imgs(i).name]),[]);
    end
end
%}

%{
L={'imageName1'; 'imageName2'};
for i=1:length(L)
    im = imread(['dataset/golds/' L{i} '.png']);
    goldB = uint8(im>0);
    imwrite(goldB,['dataset/goldsBinary/' L{i} '.png']);
    %save(['dataset/goldsMat/' L{i} '.mat'],'im');
    figure;
    title(L{i});
    imshow(imread(['dataset/goldsBinary/' L{i} '.png']),[]);
end
%}

%{
% find conjoint golds
M = [0 0 0; 1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1; 0.9185    0.1661    0.6518; 0.8635    0.8641    0.8927; 0.5289    0.5740    0.8669; 0.5218    0.2743    0.4502];
goldFolder = 'dataset/golds/aorta12*';
imgs = dir(goldFolder);
for i=1:length(imgs)
    if imgs(i).isdir == 0
        im = imread(['dataset/golds/' imgs(i).name]);
        [dx, dy] = size(im);
         found = 0;
         for j=1:dx
            for k=1:dy
                if j<dx && im(j+1,k)~= 0 && im(j,k)~= 0 && im(j+1,k)~= im(j,k); disp(imgs(i).name); ...
                            figure; imshow(im,M); found=1; break; end
                 if k<dy && im(j,k+1)~= 0 && im(j,k)~= 0 && im(j,k+1)~= im(j,k); disp(imgs(i).name); ...
                            figure; imshow(im,M); found=1; break; end
                 if j<dx && k>1 && im(j+1,k-1)~= 0 && im(j,k)~= 0 && im(j+1,k-1)~= im(j,k); disp(imgs(i).name); ...
                            figure; imshow(im,M); found=1; break; end
                 if j<dx && k<dy && im(j+1,k+1)~= 0 && im(j,k)~= 0 && im(j+1,k+1)~= im(j,k); disp(imgs(i).name); ...
                            figure; imshow(im,M); found=1; break; end                    
             end
             if found; break; end
         end
    end
end
%}
%%{
S = {'imageName1.png'; 'imageName1.png'};
%%}
%%{
for i=1:length(S)
    im = imread(['dataset/golds/' S{i}]);
    goldB = uint8(im>0);
    imwrite(goldB,['dataset/goldsBinary/' S{i}]);
%    splt = split(S{i},'.');
%    save(['dataset/goldsMat/' splt{1} '.mat'],'im');
    figure;
    imshow(imread(['dataset/goldsBinary/' S{i}]),[]);
end
%%}
%{
for i=1:length(S)
    im = imread(['dataset/golds/' S{i}]);
    imtmp = im;
    [dx,dy] = size(im);
    c=containers.Map;
    U = unique(im);
    for m=2:length(U)
        c(num2str(U(m))) = sum(sum((im==U(m))));
    end
    for j=1:dx
        for k=1:dy
            if j<dx && im(j+1,k)~= 0 && im(j,k)~= 0 && im(j+1,k)~= im(j,k)
                if c(num2str(im(j+1,k))) > c(num2str(im(j,k)))
                    imtmp(j+1,k) = 0;
                    if im(j,k+1) == im(j+1,k); imtmp(j,k+1) = 0; end
                    if im(j+1,k+1) == im(j+1,k); imtmp(j+1,k+1) = 0; end
                    if im(j+2,k+1) == im(j+1,k); imtmp(j+2,k+1) = 0; end
                    if im(j+2,k) == im(j+1,k); imtmp(j+2,k) = 0; end
                    if im(j+2,k-1) == im(j+1,k); imtmp(j+2,k-1) = 0; end
                    if im(j+1,k-1) == im(j+1,k); imtmp(j+1,k-1) = 0; end
                    if im(j,k-1) == im(j+1,k); imtmp(j,k-1) = 0; end
                else
                    imtmp(j,k) = 0;
                    if im(j+1,k-1) == im(j,k); imtmp(j+1,k-1) = 0; end
                    if im(j,k-1) == im(j,k); imtmp(j,k-1) = 0; end
                    if im(j-1,k-1) == im(j,k); imtmp(j-1,k-1) = 0; end
                    if im(j-1,k) == im(j,k); imtmp(j-1,k) = 0; end
                    if im(j-1,k+1) == im(j,k); imtmp(j-1,k+1) = 0; end
                    if im(j,k+1) == im(j,k); imtmp(j,k+1) = 0; end
                    if im(j+1,k+1) == im(j,k); imtmp(j+1,k+1) = 0; end
                end
            end
            if k<dy && im(j,k+1)~= 0 && im(j,k)~= 0 && im(j,k+1)~= im(j,k)
                if c(num2str(im(j,k+1))) > c(num2str(im(j,k)))
                    imtmp(j,k+1) = 0;
                    if im(j+1,k) == im(j,k+1); imtmp(j+1,k) = 0; end
                    if im(j+1,k+1) == im(j,k+1); imtmp(j+1,k+1) = 0; end
                    if im(j+1,k+2) == im(j,k+1); imtmp(j+1,k+2) = 0; end
                    if im(j,k+2) == im(j,k+1); imtmp(j,k+2) = 0; end
                    if im(j-1,k+2) == im(j,k+1); imtmp(j-1,k+2) = 0; end
                    if im(j-1,k+1) == im(j,k+1); imtmp(j-1,k+1) = 0; end
                    if im(j-1,k) == im(j,k+1); imtmp(j-1,k) = 0; end
                else
                    imtmp(j,k) = 0;
                    if im(j+1,k-1) == im(j,k); imtmp(j+1,k-1) = 0; end
                    if im(j,k-1) == im(j,k); imtmp(j,k-1) = 0; end
                    if im(j-1,k-1) == im(j,k); imtmp(j-1,k-1) = 0; end
                    if im(j-1,k) == im(j,k); imtmp(j-1,k) = 0; end
                    if im(j-1,k+1) == im(j,k); imtmp(j-1,k+1) = 0; end
                    if im(j+1,k) == im(j,k); imtmp(j+1,k) = 0; end
                    if im(j+1,k+1) == im(j,k); imtmp(j+1,k+1) = 0; end
                end   
            end
            if j<dx && k>1 && im(j+1,k-1)~= 0 && im(j,k)~= 0 && im(j+1,k-1)~= im(j,k)
                if c(num2str(im(j+1,k-1))) > c(num2str(im(j,k)))
                    imtmp(j+1,k-1) = 0;
                    if im(j+1,k) == im(j+1,k-1); imtmp(j+1,k) = 0; end
                    if im(j+2,k) == im(j+1,k-1); imtmp(j+2,k) = 0; end
                    if im(j+2,k-1) == im(j+1,k-1); imtmp(j+2,k-1) = 0; end
                    if im(j+2,k-2) == im(j+1,k-1); imtmp(j+2,k-2) = 0; end
                    if im(j+1,k-2) == im(j+1,k-1); imtmp(j+1,k-2) = 0; end
                    if im(j,k-2) == im(j+1,k-1); imtmp(j,k-2) = 0; end
                    if im(j,k-1) == im(j+1,k-1); imtmp(j,k-1) = 0; end
                else
                    imtmp(j,k) = 0;
                    if im(j,k+1) == im(j,k); imtmp(j,k+1) = 0; end
                    if im(j,k-1) == im(j,k); imtmp(j,k-1) = 0; end
                    if im(j-1,k-1) == im(j,k); imtmp(j-1,k-1) = 0; end
                    if im(j-1,k) == im(j,k); imtmp(j-1,k) = 0; end
                    if im(j-1,k+1) == im(j,k); imtmp(j-1,k+1) = 0; end
                    if im(j+1,k) == im(j,k); imtmp(j+1,k) = 0; end
                    if im(j+1,k+1) == im(j,k); imtmp(j+1,k+1) = 0; end
                end   
            end
            if j<dx && k<dy && im(j+1,k+1)~= 0 && im(j,k)~= 0 && im(j+1,k+1)~= im(j,k)
                if c(num2str(im(j+1,k+1))) > c(num2str(im(j,k)))
                    imtmp(j+1,k+1) = 0;
                    if im(j,k+1) == im(j+1,k+1); imtmp(j,k+1) = 0; end
                    if im(j,k+2) == im(j+1,k+1); imtmp(j,k+2) = 0; end
                    if im(j+1,k+2) == im(j+1,k+1); imtmp(j+1,k+2) = 0; end
                    if im(j+2,k+2) == im(j+1,k+1); imtmp(j+2,k+2) = 0; end
                    if im(j+2,k+1) == im(j+1,k+1); imtmp(j+2,k+1) = 0; end
                    if im(j+2,k) == im(j+1,k+1); imtmp(j+2,k) = 0; end
                    if im(j+1,k) == im(j+1,k+1); imtmp(j+1,k) = 0; end
                else
                    imtmp(j,k) = 0;
                    if im(j,k+1) == im(j,k); imtmp(j,k+1) = 0; end
                    if im(j,k-1) == im(j,k); imtmp(j,k-1) = 0; end
                    if im(j-1,k-1) == im(j,k); imtmp(j-1,k-1) = 0; end
                    if im(j-1,k) == im(j,k); imtmp(j-1,k) = 0; end
                    if im(j-1,k+1) == im(j,k); imtmp(j-1,k+1) = 0; end
                    if im(j+1,k) == im(j,k); imtmp(j+1,k) = 0; end
                    if im(j+1,k-1) == im(j,k); imtmp(j+1,k-1) = 0; end
                end
            end                    
        end
    end
    imwrite(imtmp,['dataset/golds/' S{i}]);
    figure;
    imshowpair(im,imtmp,'montage');
end
%}

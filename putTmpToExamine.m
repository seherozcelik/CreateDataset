%%{
M = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1; 0.9185    0.1661    0.6518; 0.8635    0.8641    0.8927; 0.5289    0.5740    0.8669; 0.5218    0.2743    0.4502];
imgs = dir('folder/imageNamePre*');
for i=1:length(imgs)
    if imgs(i).isdir == 0
        im = imread(['folder/' imgs(i).name]);
        iml = label2rgb(im,M,[0 0 0]);
        imwrite(iml, ['tmp/' imgs(i).name]);
    end
end
%%}
%{
imgs = dir('folder/imageNamePre*');
for i=1:length(imgs)
    splt1=split(imgs(i).name,'.');
    splt2=split(splt1{1},'_');
    imgs(i).order = str2double(splt2{2});
end
T = struct2table(imgs);
sortedT = sortrows(T, 'order');
imgs2 = table2struct(sortedT);
counter = 0;
for i=1:length(imgs2)
    counter = counter + 1;
    if mod(counter,4) == 1
        figure
        k=1;
    end
    subplot(2,2,k)
    imdicom = dicomread(['folder/' imgs2(i).name]);
    splt = split(imgs2(i).name,'.');
    goldBinary = imread(['folder/' splt{1} '.png']);
    imWithBoundaries = drawBoundaries(imdicom, goldBinary);
    imshowpair(goldBinary,imWithBoundaries,'montage')
    title(strrep(imgs2(i).name,'_','-'))
    k=k+1;
    hold on
end
%}
%M = [0 0 0; 1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1; 0.9185    0.1661    0.6518; 0.8635    0.8641    0.8927; 0.5289    0.5740    0.8669; 0.5218    0.2743    0.4502];

%L={'imName1';'imName2'};
%{
imgs = dir('dataset/goldsNew');
for i=1:length(imgs)
    if imgs(i).isdir == 0
        im = imread(['folder/' imgs(i).name]);
        iml = label2rgb(im,M,[0 0 0]);
        imNew = imread(['folder/' imgs(i).name]);
        imNewl = label2rgb(imNew,M,[0 0 0]);
        sep = ones(256,3,3);
        ims = [iml sep imNewl];
        imwrite(ims, ['tmp/' imgs(i).name]);
    end
end
%}
%{
S = {'imName1.png', 'imName2.png'};

for i=1:length(S)
    imadj = imread(['folder/' S{i}]);
    imadjl = label2rgb(imadj,M,[0 0 0]);
    im = imread(['folder/' S{i}]);
    iml = label2rgb(im,M,[0 0 0]);
    sep = ones(256,3,3);
    ims = [iml sep imadjl];
    imwrite(ims, ['tmp/' S{i}]);
end
%}
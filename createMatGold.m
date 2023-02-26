imgs = dir('folder/imageNamePre*');
for i=1:length(imgs)
    if imgs(i).isdir == 0
        im = imread(['folder/' imgs(i).name]);
        splt = split(imgs(i).name,'.');
        save(['folder/' splt{1} '.mat'],'im');
    end
end
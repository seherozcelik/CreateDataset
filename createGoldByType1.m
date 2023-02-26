imgs = dir('folder');
for i=3:length(imgs)
    im = imread(['folder/' imgs(i).name]);
    if max(max(im)) > 3
        if sum(sum(im==1)) > 0 || sum(sum(im==2)) > 0 || sum(sum(im==3)) > 0
            for j=4:10
                im(im==j)=0;
            end
            imwrite(uint8(im>0), ['folder/' imgs(i).name]);
            splt = split(imgs(i).name,'.');
            save(['folder/' splt{1} '.mat'],'im');
        end
    else
        imwrite(uint8(im>0), ['folder/' imgs(i).name]);
        splt = split(imgs(i).name,'.');
        save(['folder/' splt{1} '.mat'],'im');
    end
end
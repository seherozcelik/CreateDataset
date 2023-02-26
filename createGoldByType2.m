imgs = dir('folder');
for i=3:length(imgs)
    im = imread(['folder/' imgs(i).name]);
    if sum(sum(im==1)) == 0 && sum(sum(im==2)) == 0 && sum(sum(im==3)) == 0
        imwrite(uint8(im>0), ['folder/' imgs(i).name]);
        splt = split(imgs(i).name,'.');
        save(['folder/' splt{1} '.mat'],'im');
    else
        if sum(sum(im==4)) > 0 || sum(sum(im==5)) > 0 || sum(sum(im==6)) > 0 || ...
                sum(sum(im==7)) > 0 || sum(sum(im==8)) > 0 || sum(sum(im==9)) > 0 || ...
                sum(sum(im==10)) > 0
            for j=1:3
                im(im==j)=0;
            end
            imwrite(uint8(im>0), ['folder/' imgs(i).name]);
            splt = split(imgs(i).name,'.');
            save(['folder/' splt{1} '.mat'],'im');
        end
    end
end
patient = 'someNum';
im = niftiread(['name ' patient '/name_' patient '.nii']);
niiDepth = size(im,3);
counter = 0;
for i=1:niiDepth
    imr = uint8(zeros(512,512));
    img = uint8(zeros(512,512));
    imb = uint8(zeros(512,512));
    if max(im(:,:,i),[],'all') > 0
        counter = counter + 1;
        if sum(im(:,:,i)==1,'all') > 0
            imr(im(:,:,i)==1)=255;
        end
        if sum(im(:,:,i)==2,'all') > 0
            img(im(:,:,i)==2)=255;
        end
        if sum(im(:,:,i)==3,'all') > 0
            imb(im(:,:,i)==3)=255;
        end
        if sum(im(:,:,i)==4,'all') > 0
            imr(im(:,:,i)==4)=255;
            img(im(:,:,i)==4)=255;
        end
        if sum(im(:,:,i)==5,'all') > 0
            img(im(:,:,i)==5)=255;
            imb(im(:,:,i)==5)=255;
        end
        if sum(im(:,:,i)==6,'all') > 0
            imr(im(:,:,i)==6)=255;
            imb(im(:,:,i)==6)=255;
        end
        if sum(im(:,:,i)==7,'all') > 0
            imr(im(:,:,i)==7)=122;
            img(im(:,:,i)==7)=195;
            imb(im(:,:,i)==7)=226;
        end
        if sum(im(:,:,i)==8,'all') > 0
            imr(im(:,:,i)==8)=145;
            img(im(:,:,i)==8)=78;
            imb(im(:,:,i)==8)=226;
        end
        if sum(im(:,:,i)==9,'all') > 0
            imr(im(:,:,i)==9)=203;
            img(im(:,:,i)==9)=65;
            imb(im(:,:,i)==9)=23;
        end
        if sum(im(:,:,i)==10,'all') > 0
            imr(im(:,:,i)==10)=171;
            img(im(:,:,i)==10)=208;
            imb(im(:,:,i)==10)=68;
        end
        
        imr=imr';
        imr=imr(144:399,125:380);
        img=img';
        img=img(144:399,125:380);
        imb=imb';
        imb=imb(144:399,125:380);
        
        iml=cat(3,imr,img,imb);
        if mod(counter,4) == 1
        %if mod(counter,2) == 1
            figure
            k=1;
        end
        subplot(2,2,k)
        %subplot(1,2,k)
        j=niiDepth+1-i;
        imNum = num2str(j);
        if j < 10
            imname = ['IM0000' imNum];
        elseif j<100
            imname = ['IM000' imNum];
        else
            imname = ['IM00' imNum];
        end
        imgold = im(:,:,i)';
        imgold = imgold(144:399,125:380);
        imdicom = dicomread(['name ' patient '/' imname]);
        imdicom = imdicom(144:399,125:380);
        goldBinary = uint8(imgold>0);
        imWithBoundaries = drawBoundaries(imdicom, goldBinary);
        dicomwrite(imdicom, ['folder/name' patient '_' imNum '.dcm']);
        imwrite(imgold, ['folder/name' patient '_' imNum '.png']);
        imwrite(goldBinary, ['folder/name' patient '_' imNum '.png']);
        imshowpair(iml,imWithBoundaries,'montage')
        %montage({iml,imBounded,imdicom})
        title(['aorta' patient '\_' imNum]);
        k=k+1;
        hold on
    end
end
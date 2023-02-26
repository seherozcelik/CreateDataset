folderAddr = '../dataset/goldsBinary';
patientNum = '12';
imgs = dir([folderAddr '/aorta' patientNum '*']);
disp(imgs(1))
disp(['total ' num2str(length(imgs)) ' images']);
for i = 1 : length(imgs)
    for j = i+1 : length(imgs)
        tmp = sum(imread([folderAddr '/' imgs(i).name]) ~= imread([folderAddr '/' imgs(j).name]),'all');
        if tmp == 0
            fprintf('%s\t%s\n', imgs(i).name, imgs(j).name);
        end
    end
end


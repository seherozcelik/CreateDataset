gold_names = dir('folder');

s='{';

for i = 3:length(gold_names)
    im = imread(['folder/' gold_names(i).name]);
    splt = split(gold_names(i).name,'.');
    
    write_f = false;
    write_s = false;

    if sum(im == 1,'all') > 0
        write_f = true;
    end
    if sum(im == 2,'all') > 0
        write_f = true;
    end
    if sum(im == 3,'all') > 0
        write_f = true;
    end
    if sum(im == 4,'all') > 0
        write_s = true;
    end
    if sum(im == 5,'all') > 0
        write_s = true;
    end
    if sum(im == 6,'all') > 0
        write_s = true;
    end
    if sum(im == 7,'all') > 0
        write_s = true;
    end
    if sum(im == 8,'all') > 0
        write_s = true;
    end
    if sum(im == 9,'all') > 0
        write_s = true;
    end
    if sum(im == 10,'all') > 0
        write_s = true;
    end
    
    dcm_name = [splt{1} '.dcm'];
    if write_f && write_s
        s = strcat(s,'"',dcm_name,'"', ':"m",');
    elseif write_f
        s = strcat(s,'"',dcm_name,'"', ':"f",');
    else
        s = strcat(s,'"',dcm_name,'"', ':"s",');
    end
end
s = s(1:length(s)-1);
s = strcat(s,'}');
fid = fopen('types.json', 'w');
fprintf(fid, '%s', s);
fclose(fid);

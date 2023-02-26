function im = drawBoundaries(im, gold)

    im = double(im);
    im = im - min(im,[],'all');
    im = im / max(im,[],'all') * 255;
    im(:, :, 2) = im;
    im(:, :, 3) = im(:, :, 1);
    
    im = uint8(im);
    
    bnd = findBnd(gold);
    bnd = imdilate(bnd, strel('disk', 1));
    
    tmp = im(:, :, 1); tmp(bnd == 1) = 255; im(:, :, 1) = tmp;
    tmp = im(:, :, 2); tmp(bnd == 1) = 0; im(:, :, 2) = tmp;
    tmp = im(:, :, 3); tmp(bnd == 1) = 0; im(:, :, 3) = tmp;

end

function bnd = findBnd(gold)

    [dx, dy] = size(gold);
    
    bnd = zeros(dx, dy);
    for i = 1 : dx
        for j = 1 : dy
            if gold(i, j)
                if i > 1  && gold(i, j) ~= gold(i-1, j); bnd(i, j) = 1; end
                if i < dx && gold(i, j) ~= gold(i+1, j); bnd(i, j) = 1; end
                if j > 1  && gold(i, j) ~= gold(i, j-1); bnd(i, j) = 1; end
                if j < dy && gold(i, j) ~= gold(i, j+1); bnd(i, j) = 1; end
            end
        end
    end

end

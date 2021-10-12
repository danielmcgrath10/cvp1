function [masked] = mask_images(images, mask)
    n = size(mask, 1);
    border = floor(n/2);
    
    masked = zeros(size(images));
    for x = 1:size(images, 3)
        img = images(:,:,x);
        length = size(img, 1);
        
        filt = img(:,:);
        for i = (border + 1) : (length - border)
           for j = (border + 1) : (length - border)
              slice = img((i - border):(i + border), (j - border):(j + border));
              filt(i, j) = sum(slice .* mask, 'all');
           end
        end
        
        masked(:,:,x) = filt;
    end
end



function [masked] = mask_images(images, mask)
    n = size(mask, 1);
    border = floor(n/2);
    
    masked = zeros(size(images));
    for k = 1:size(images, 3)
        img = images(:,:,k);
        x = size(img, 1);
        y = size(img, 2);
        
        filt = img(:,:);
        for i = (border + 1) : (x - border)
           for j = (border + 1) : (y - border)
              slice = img((i - border):(i + border), (j - border):(j + border));
              filt(i, j) = sum(slice .* mask, 'all');
           end
        end
        
        masked(:,:,k) = filt;
    end
end



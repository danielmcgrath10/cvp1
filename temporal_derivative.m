function [temporal_derivative] = temporal_derivative(images, filter)
%TEMPORAL_DERIVATIVE Summary of this function goes here
%   Detailed explanation goes here   
    h = floor(size(filter) / 2);
    if (mod(size(filter), 2))
        l = h;
    else
        l = h - 1;
    end
    
    x = size(images, 1);
    y = size(images, 2);
    n = size(images, 3);
    
    temporal_derivative = zeros(x, y, n);
    
    for i = (1+l):(n-h)
%         img_0 = images(:,:,i);
%         img_1 = images(:,:,i + 1);
        
        imgs = images(:,:,(i-l):(i+h));
        for j = 1:size(filter)
            imgs(:,:,j) = imgs(:,:,j) .* filter(j);
        end
        diff = sum(imgs, 3);

        temporal_derivative(:,:,i) = diff;
    end
end


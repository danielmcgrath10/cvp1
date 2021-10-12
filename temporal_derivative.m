function [temporal_derivative] = temporal_derivative(images)
%TEMPORAL_DERIVATIVE Summary of this function goes here
%   Detailed explanation goes here
    x = size(images, 1);
    y = size(images, 2);
    n = size(images, 3);
    
    temporal_derivative = zeros(x, y, n - 1);
    
    for i = 1:(n-1)
        img_0 = images(:,:,i);
        img_1 = images(:,:,i + 1);
        diff = img_1 - img_0;

        temporal_derivative(:,:,i) = diff;
    end
end


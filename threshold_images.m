function [thresholded] = threshold_images(images, threshold)
%THRESHOLD_IMAGES Summary of this function goes here
%   Detailed explanation goes here
    x = size(images, 1);
    y = size(images, 2);
    n = size(images, 3);
    
    thresholded = zeros(x,y,n);
    for i = 1:n
        img = images(:,:,i);
        zeroindices = find(abs(img) < threshold);
        oneindices = find(abs(img) >= threshold);
        th_img = img;
        th_img(zeroindices) = 0;
        th_img(oneindices) = 1;
        
        thresholded(:,:,i) = th_img;
    end
end


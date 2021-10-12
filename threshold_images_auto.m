function [thresholded] = threshold_images_auto(images)
    x = size(images, 1);
    y = size(images, 2);
    n = size(images, 3);
    
    % Generate deviation scalars as temporal noise estimates
    pixel_deviations = est_noise(images);
    threshold = mean(pixel_deviations, 'all') * 3;
    thresholded = zeros(x,y,n);
    for i = 1:n
        img = images(:,:,i);
        f = abs(img);
        better_threshold = threshold * sqrt(mean(f, 'all'));
        zeroindices = find(f < better_threshold);
        oneindices = find(f >= better_threshold);

        th_img = img;
        th_img(zeroindices) = 0;
        th_img(oneindices) = 1;
        
        thresholded(:,:,i) = th_img;
    end
end
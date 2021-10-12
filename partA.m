start_img = 1;
stop_img = 1070;

[images, numImages] = import_images(240, 320, start_img, stop_img);

filter = 0.5 * [-1, 1]';
temporal_d = temporal_derivative(images, filter);

threshold = 11;
thresholded_d = threshold_images(temporal_d, threshold);
% 
% threshold = 11;

% temporal_d = zeros(240, 320, 1069);
% for i = 1:(numImages - 1)
%     img_0 = images(:,:,i);
%     img_1 = images(:,:,i + 1);
%     diff = img_1 - img_0;
%     zeroindices = find(abs(diff) < threshold);
%     oneindices = find(abs(diff) >= threshold);
%     maskedDiff = diff; 
%     maskedDiff(zeroindices) = 0;
%     maskedDiff(oneindices) = 1;
%     temporal_d(:,:,i) = maskedDiff;
% end



    
start_img = 1;
stop_img = 1070;

t_choice = 2;
s_choice = 0;
th_choice = 1;

threshold = 9;
ssigma = 1;
tsigma = 1;
tlength = 5;

[images, numImages] = import_images(240, 320, start_img, stop_img);
images = images(:,:,start_img:stop_img);

masked_images = zeros(size(images));
switch s_choice
    case 0
        masked_images = images;
    case 1
        mask = (1/9) * ones(3,3);
        masked_images = mask_images(images, mask);
    case 2
        mask = (1/25) * ones(5,5);
        masked_images = mask_images(images, mask);
    case 3
        for i = 1:size(images, 3)
           masked_images(:,:,i) = imgaussfilt(images(:,:,i), ssigma); 
        end
    otherwise
        disp("error");
end

temporal_d = zeros(size(images) - [0,0,1]);
switch t_choice
    case 0
        temporal_d = masked_images;
    case 1
        filter = 0.5 * [-1, 0, 1]';
        temporal_d = temporal_derivative(masked_images, filter);
    case 2
        filter = gauss_tmask(tlength, tsigma);
        temporal_d = temporal_derivative(masked_images, filter);
    otherwise
        disp("error");
end

thresholded_d = zeros(size(temporal_d));
switch th_choice
    case 0
        thresholded_d = temporal_d;
    case 1
        thresholded_d = threshold_images(temporal_d, threshold);
    case 2
        thresholded_d = threshold_images_dynm(temporal_d, threshold);
    case 3
        thresholded_d = threshold_images_auto(temporal_d);
    otherwise
        disp("error");
end

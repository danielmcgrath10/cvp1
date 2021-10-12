directory = uigetdir(pwd, 'Select a Folder');
filePattern = fullfile(directory, '*.jpg');
% filePattern = '/Users/danielmcgrath/Documents/fifth-year-northeastern/Fall/computer-vision/Project 1/cvp1/Office/*.jpg';
files = dir(filePattern);
numFiles = length(files);
threshold = 9;
tsigma = 1;
ssigma = 1;
choice = 3;

images = zeros(240,320,1070);
for i = 1:numFiles
   file = files(i);
   images(:,:,i) = rgb2gray(imread(strcat(file.folder,'/',file.name)));
end

% temporal_d = simple_filter(images, numFiles, threshold);
temporal_d = spatial_smoothing(images, numFiles, threshold, ssigma, choice);


function [temporal_d] = simple_filter(images, numFiles, threshold)
    temporal_d(:,:,1) = zeros(240, 320);
    temporal_d(:,:,numFiles) = zeros(240, 320);
    for i = 2:(numFiles - 2)
        img_0 = images(:,:,i-1);
        img_1 = images(:,:,i);
        img_2 = images(:,:,i + 1);
        diff = 0.5 * ((img_0 .* -1) + (img_1 .* 0) + (img_2 .* 1));
        zeroindices = find(abs(diff) < threshold);
        oneindices = find(abs(diff) >= threshold);
        maskedDiff = diff;
        maskedDiff(zeroindices) = 0;
        maskedDiff(oneindices) = 1;
        temporal_d(:,:,i) = maskedDiff;
    end
end

function [temporal_d] = one_d_gaussian(images, numFiles, threshold, tsigma)
    temporal_d(:,:,numFiles) = zeros(240, 320);
    for i = 1:(numFiles - 1)
        img_0 = images(:,:,i-1);
        img_1 = images(:,:,i);
        diff = img_1 - img_0;
        zeroindices = find(abs(diff) < threshold);
        oneindices = find(abs(diff) >= threshold);
        maskedDiff = diff;
        maskedDiff(zeroindices) = 0;
        maskedDiff(oneindices) = 1;
        temporal_d(:,:,i) = maskedDiff;
    end
end

function [temporal_d] = spatial_smoothing(images, numFiles, threshold, ssigma, choice)
    switch choice
        case 1
            filter = (1/9) * [1 1 1; 1 1 1; 1 1 1];
            temporal_d(:,:,numFiles) = images(:,:,numFiles);
            for i = 1:(numFiles-1)
                image_0 = images(:, :, i);
                image_1 = images(:, :, i+1);
                for j = 2:(size(images,1)-1)
                    for k = 2:(size(images,2)-1)
                        image_0(j,k) = sum(image_0(j-1:j+1,k-1:k+1) .* filter, 'all');
                        image_1(j,k) = sum(image_1(j-1:j+1,k-1:k+1) .* filter, 'all');
                    end
                end
                diff = image_1 - image_0;
                zeroindices = find(abs(diff) < threshold);
                oneindices = find(abs(diff) >= threshold);
                maskedDiff = diff;
                maskedDiff(zeroindices) = 0;
                maskedDiff(oneindices) = 1;
                temporal_d(:,:,i) = maskedDiff;
            end
        case 2
            filter = (1/25) * ones(5,5);
            temporal_d(:,:,numFiles) = images(:,:,numFiles);
            for i = 1:(numFiles-1)
                image_0 = images(:, :, i);
                image_1 = images(:, :, i+1);
                for j = 3:(size(images,1)-2)
                    for k = 3:(size(images,2)-2)
                        image_0(j,k) = sum(image_0(j-2:j+2,k-2:k+2) .* filter, 'all');
                        image_1(j,k) = sum(image_1(j-2:j+2,k-2:k+2) .* filter, 'all');
                    end
                end
                diff = image_1 - image_0;
                zeroindices = find(abs(diff) < threshold);
                oneindices = find(abs(diff) >= threshold);
                maskedDiff = diff;
                maskedDiff(zeroindices) = 0;
                maskedDiff(oneindices) = 1;
                temporal_d(:,:,i) = maskedDiff;
            end
        case 3
            temporal_d(:,:,numFiles) = images(:,:,numFiles);
            for i = 1:(numFiles-1)
                image_0 = imgaussfilt(images(:, :, i), ssigma);
                image_1 = imgaussfilt(images(:, :, i+1), ssigma);
                diff = image_1 - image_0;
                zeroindices = find(abs(diff) < threshold);
                oneindices = find(abs(diff) >= threshold);
                maskedDiff = diff;
                maskedDiff(zeroindices) = 0;
                maskedDiff(oneindices) = 1;
                temporal_d(:,:,i) = maskedDiff;
            end
        otherwise
            print("error");
    end
end

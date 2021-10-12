function [images, numImages] = import_images(x, y)
%IMPORT_IMAGES Summary of this function goes here
%   Detailed explanation goes here
    directory = uigetdir(pwd, 'Select a Folder');
    filePattern = fullfile(directory, '*.jpg');
    imageFiles = dir(filePattern);
    numImages = length(imageFiles);
    images = zeros(x, y, numImages);
    for i = 1:numImages
        file = imageFiles(i);
        images(:,:,i) = rgb2gray(imread(strcat(file.folder,'/',file.name)));
    end
end


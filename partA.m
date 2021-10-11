% directory = uigetdir(pwd, 'Select a Folder');
% filePattern = fullfile(directory, '*.jpg');
filePattern = '/Users/danielmcgrath/Documents/fifth-year-northeastern/Fall/computer-vision/Project 1/cvp1/Office/*.jpg';
officeFiles = dir(filePattern);
numOfficeFiles = length(officeFiles);

images = zeros(240,320,3,1070);
for i = 1:numOfficeFiles
   file = officeFiles(i);
   images(:,:,:,i) = imread(strcat(file.folder,'/',file.name));
end


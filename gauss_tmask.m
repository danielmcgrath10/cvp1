function [raw, first_drv] = gauss_tmask(length, sigma)
%GAUSSIAN_TEMPORAL_MASK Summary of this function goes here
%   Detailed explanation goes here
raw = fspecial('gauss',[length, 1], sigma);
first_drv = gradient(raw);
end


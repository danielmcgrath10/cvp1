function [sigma] = est_noise(images)    
    x = size(images, 1);
    y = size(images, 2);
    n = size(images, 3);
    
    E_bar = (1/n) .* sum(images, 3);
    sigma = zeros(x, y);
    for k = 1:n
        img = images(:,:,k);
       for i = 1:x  
          for j = 1:y
              inner = (E_bar(i, j) - img(i, j))^2;
              sigma(i,j) = sigma(i,j) + inner;
          end
       end
     end
     sigma = (sigma .* (1/(n-1))).^(1/2);
end


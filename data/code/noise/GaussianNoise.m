
function noisy = addGaussianNoise(img,var)

img = uint8(img);

noisy = imnoise(img,'gaussian',0,var);

end

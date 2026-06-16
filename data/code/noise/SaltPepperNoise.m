function noisy = addSaltPepperNoise(img,density)

img = uint8(img);

noisy = imnoise(img,'salt & pepper',density);

end

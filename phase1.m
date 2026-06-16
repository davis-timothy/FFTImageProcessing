%% Fourier Transform Image Processing - Phase 1

clear;
clc;
close all;

% Load built-in image
img = imread('cameraman.tif');

% Show original
figure;
imshow(img);
title('Original Image');

% Fourier Transform
F = fft2(img);
Fshift = fftshift(F);

figure;
imshow(log(abs(Fshift)+1),[]);
title('FFT Magnitude Spectrum');

% Reconstruct image
reconstructed = real(ifft2(F));

figure;
imshow(uint8(reconstructed));
title('Reconstructed Image');

% Add Gaussian noise
gaussianNoisy = imnoise(img,'gaussian',0,0.01);

figure;
imshow(gaussianNoisy);
title('Gaussian Noise');

% Add Salt & Pepper noise
spNoisy = imnoise(img,'salt & pepper',0.05);

figure;
imshow(spNoisy);
title('Salt & Pepper Noise');

% Box filter
boxKernel = ones(7,7)/49;
boxFiltered = imfilter(gaussianNoisy,boxKernel);

figure;
imshow(boxFiltered);
title('Box Filter Result');

% Gaussian filter
gaussianKernel = fspecial('gaussian',[7 7],2);
gaussianFiltered = imfilter(gaussianNoisy,gaussianKernel);

figure;
imshow(gaussianFiltered);
title('Gaussian Filter Result');

disp('Level 1 Complete');

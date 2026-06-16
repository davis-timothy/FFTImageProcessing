%% Image Processing Using Fourier Transforms
clear;
clc;
close all;

%% Load Image

img = imread('cameraman.tif');

if size(img,3) == 3
    img = rgb2gray(img);
end

img = imresize(img,[256 256]);

img = double(img);

figure;
imshow(uint8(img));
title('Original Image');

%% Fourier Transform

F = fft2(img);

Fshift = fftshift(F);

magnitude = log(abs(Fshift)+1);

figure;
imshow(magnitude,[]);
title('FFT Magnitude Spectrum');

%% Image Reconstruction

reconstructed = ifft2(F);

reconstructed = real(reconstructed);

figure;
imshow(uint8(reconstructed));
title('Reconstructed Image');

%% Add Noise

gaussianNoisy = imnoise(uint8(img),'gaussian',0,0.01);

saltPepperNoisy = imnoise(uint8(img),'salt & pepper',0.05);

figure;

subplot(1,2,1);
imshow(gaussianNoisy);
title('Gaussian Noise');

subplot(1,2,2);
imshow(saltPepperNoisy);
title('Salt & Pepper Noise');

%% Box Filter

boxKernel = ones(7,7)/49;

boxFiltered = imfilter(gaussianNoisy,boxKernel);

figure;

subplot(1,2,1);
imshow(gaussianNoisy);
title('Noisy Image');

subplot(1,2,2);
imshow(boxFiltered);
title('Box Filter');

%% Gaussian Filter

gaussianKernel = fspecial('gaussian',[7 7],2);

gaussianFiltered = imfilter(gaussianNoisy,gaussianKernel);

figure;

subplot(1,2,1);
imshow(gaussianNoisy);
title('Noisy Image');

subplot(1,2,2);
imshow(gaussianFiltered);
title('Gaussian Filter');

%% Low Pass Frequency Filter

[M,N] = size(img);

[X,Y] = meshgrid(1:N,1:M);

centerX = N/2;
centerY = M/2;

radius = 30;

D = sqrt((X-centerX).^2 + (Y-centerY).^2);

lowPassMask = D <= radius;

F_low = Fshift .* lowPassMask;

lowPassImage = real(ifft2(ifftshift(F_low)));

figure;

subplot(1,2,1);
imshow(uint8(img));
title('Original');

subplot(1,2,2);
imshow(uint8(lowPassImage));
title('Low Pass Filter');

%% High Pass Frequency Filter

highPassMask = D > radius;

F_high = Fshift .* highPassMask;

highPassImage = real(ifft2(ifftshift(F_high)));

figure;

subplot(1,2,1);
imshow(uint8(img));
title('Original');

subplot(1,2,2);
imshow(mat2gray(highPassImage));
title('High Pass Filter');

%% Band Pass Frequency Filter

innerRadius = 20;
outerRadius = 60;

bandPassMask = (D >= innerRadius) & (D <= outerRadius);

F_band = Fshift .* bandPassMask;

bandPassImage = real(ifft2(ifftshift(F_band)));

figure;

subplot(1,2,1);
imshow(uint8(img));
title('Original');

subplot(1,2,2);
imshow(mat2gray(bandPassImage));
title('Band Pass Filter');

%% Edge Detection

edges = edge(uint8(img),'canny');

figure;
imshow(edges);
title('Canny Edge Detection');

%% Evaluation Metrics

mseBox = mean((double(img(:)) - double(boxFiltered(:))).^2);

mseGaussian = mean((double(img(:)) - double(gaussianFiltered(:))).^2);

psnrBox = psnr(boxFiltered,uint8(img));

psnrGaussian = psnr(gaussianFiltered,uint8(img));

fprintf('\n');
fprintf('Box Filter MSE: %.2f\n',mseBox);
fprintf('Box Filter PSNR: %.2f dB\n',psnrBox);

fprintf('\n');

fprintf('Gaussian Filter MSE: %.2f\n',mseGaussian);
fprintf('Gaussian Filter PSNR: %.2f dB\n',psnrGaussian);

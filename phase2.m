%% Fourier Transform Image Processing - Level 2

clear;
clc;
close all;

%% Load Image

img = imread('cameraman.tif');

if size(img,3) == 3
    img = rgb2gray(img);
end

img = imresize(img,[256 256]);

%% Original Image

figure;
imshow(img);
title('Original Image');

%% Fourier Transform

F = fft2(img);
Fshift = fftshift(F);

figure;
imshow(log(abs(Fshift)+1),[]);
title('FFT Magnitude Spectrum');

%% Frequency Grid

[M,N] = size(img);

[X,Y] = meshgrid(1:N,1:M);

centerX = N/2;
centerY = M/2;

D = sqrt((X-centerX).^2 + (Y-centerY).^2);

%% LOW PASS FILTER

radiusLP = 30;

lowPassMask = D <= radiusLP;

F_low = Fshift .* lowPassMask;

lowPassImage = real(ifft2(ifftshift(F_low)));

%% HIGH PASS FILTER

radiusHP = 30;

highPassMask = D > radiusHP;

F_high = Fshift .* highPassMask;

highPassImage = real(ifft2(ifftshift(F_high)));

%% BAND PASS FILTER

innerRadius = 20;
outerRadius = 60;

bandPassMask = (D >= innerRadius) & (D <= outerRadius);

F_band = Fshift .* bandPassMask;

bandPassImage = real(ifft2(ifftshift(F_band)));

%% Display Frequency Filters

figure;

subplot(2,2,1);
imshow(img);
title('Original');

subplot(2,2,2);
imshow(uint8(lowPassImage));
title('Low Pass');

subplot(2,2,3);
imshow(mat2gray(highPassImage));
title('High Pass');

subplot(2,2,4);
imshow(mat2gray(bandPassImage));
title('Band Pass');

%% Display Masks

figure;

subplot(1,3,1);
imshow(lowPassMask);
title('Low Pass Mask');

subplot(1,3,2);
imshow(highPassMask);
title('High Pass Mask');

subplot(1,3,3);
imshow(bandPassMask);
title('Band Pass Mask');

%% Edge Detection

edgesOriginal = edge(img,'canny');

edgesLowPass = edge(uint8(lowPassImage),'canny');

edgesBandPass = edge(mat2gray(bandPassImage),'canny');

figure;

subplot(1,3,1);
imshow(edgesOriginal);
title('Original Edges');

subplot(1,3,2);
imshow(edgesLowPass);
title('Low Pass Edges');

subplot(1,3,3);
imshow(edgesBandPass);
title('Band Pass Edges');

%% MSE Calculations

mseLowPass = mean((double(img(:)) - double(lowPassImage(:))).^2);

mseHighPass = mean((double(img(:)) - double(highPassImage(:))).^2);

mseBandPass = mean((double(img(:)) - double(bandPassImage(:))).^2);

%% PSNR Calculations

psnrLowPass = psnr(uint8(lowPassImage),img);

psnrBandPass = psnr(uint8(mat2gray(bandPassImage)*255),img);

%% Results

fprintf('\n');
fprintf('========== LEVEL 2 RESULTS ==========\n');

fprintf('\nLow Pass Filter\n');
fprintf('MSE  = %.2f\n',mseLowPass);
fprintf('PSNR = %.2f dB\n',psnrLowPass);

fprintf('\nHigh Pass Filter\n');
fprintf('MSE  = %.2f\n',mseHighPass);

fprintf('\nBand Pass Filter\n');
fprintf('MSE  = %.2f\n',mseBandPass);
fprintf('PSNR = %.2f dB\n',psnrBandPass);

%% Final Comparison Figure

figure;

subplot(2,3,1);
imshow(img);
title('Original');

subplot(2,3,2);
imshow(uint8(lowPassImage));
title('Low Pass');

subplot(2,3,3);
imshow(mat2gray(highPassImage));
title('High Pass');

subplot(2,3,4);
imshow(mat2gray(bandPassImage));
title('Band Pass');

subplot(2,3,5);
imshow(edgesOriginal);
title('Original Edges');

subplot(2,3,6);
imshow(edgesLowPass);
title('Low Pass Edges');

disp('Level 2 Complete');

clear;
clc;
close all;

% Add all code folders
addpath(genpath('code'));

%% Load Image

img = loadImage('data/original/TestingImage.jpeg');

figure;
imshow(uint8(img));
title('Original Image');

%% FFT

Fshift = computeFFT(img);

showSpectrum(Fshift);

%% Reconstruction

reconstructed = reconstructImage(Fshift);

figure;
imshow(uint8(reconstructed));
title('Reconstructed');

%% Noise

gaussianNoisy = addGaussianNoise(img,0.01);

saltPepperNoisy = addSaltPepperNoise(img,0.05);

%% Spatial Filters

boxImg = boxFilter(gaussianNoisy,7);

gaussImg = gaussianFilter(gaussianNoisy,[7 7],2);

%% Frequency Filters

lowPass = lowPassFFT(img,30);

highPass = highPassFFT(img,30);

bandPass = bandPassFFT(img,20,60);

%% Edge Detection

edges = cannyEdges(img);

%% Metrics

mseVal = calculateMSE(img,gaussImg);

psnrVal = calculatePSNR(img,gaussImg);

fprintf('MSE = %.2f\n',mseVal);
fprintf('PSNR = %.2f dB\n',psnrVal);

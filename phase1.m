%% Image Processing Using Fourier Transforms
clear;
clc;
close all;

%% Load Image

img = imread('data/original/cameraman.tif');

% Convert to grayscale if needed
if size(img,3) == 3
    img = rgb2gray(img);
end

% Standardize size
img = imresize(img,[256 256]);

% Convert to double
img = double(img);

figure;
imshow(uint8(img));
title('Original Image');

%% Fourier Transform

F = fft2(img);

Fshift = fftshift(F);

figure;
imshow(log(abs(Fshift)+1),[]);
title('FFT Magnitude Spectrum');

%% Image Reconstruction

reconstructed = real(ifft2(F));

figure;
imshow(uint8(reconstructed));
title('Reconstructed Image');

%% Add Gaussian Noise

gaussianNoisy = imnoise(uint8(img),'gaussian',0,0.01);

figure;
imshow(gaussianNoisy);
title('Gaussian Noise');

%% Add Salt & Pepper Noise

spNoisy = imnoise(uint8(img),'salt & pepper',0.05);

figure;
imshow(spNoisy);
title('Salt & Pepper Noise');

%% Box Filter

boxKernel = ones(7,7)/49;

boxFiltered = imfilter(gaussianNoisy,boxKernel);

figure;
subplot(1,2,1);
imshow(gaussianNoisy);
title('Gaussian Noisy');

subplot(1,2,2);
imshow(boxFiltered);
title('Box Filter');

%% Gaussian Filter

gaussianKernel = fspecial('gaussian',[7 7],2);

gaussianFiltered = imfilter(gaussianNoisy,gaussianKernel);

figure;
subplot(1,2,1);
imshow(gaussianNoisy);
title('Gaussian Noisy');

subplot(1,2,2);
imshow(gaussianFiltered);
title('Gaussian Filter');

%% Compare All Results

figure;

subplot(2,2,1);
imshow(uint8(img));
title('Original');

subplot(2,2,2);
imshow(gaussianNoisy);
title('Gaussian Noise');

subplot(2,2,3);
imshow(boxFiltered);
title('Box Filter');

subplot(2,2,4);
imshow(gaussianFiltered);
title('Gaussian Filter');

%% Save Images (Optional)

imwrite(gaussianNoisy,'gaussianNoise.png');
imwrite(spNoisy,'saltPepperNoise.png');
imwrite(boxFiltered,'boxFilterResult.png');
imwrite(gaussianFiltered,'gaussianFilterResult.png');

disp('Level 1 Complete');

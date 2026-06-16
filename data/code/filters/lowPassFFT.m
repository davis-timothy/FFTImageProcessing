function filtered = lowPassFFT(img,radius)

[M,N] = size(img);

F = fftshift(fft2(img));

[X,Y] = meshgrid(1:N,1:M);

centerX = N/2;
centerY = M/2;

D = sqrt((X-centerX).^2 + (Y-centerY).^2);

H = D <= radius;

Ffiltered = F .* H;

filtered = real(ifft2(ifftshift(Ffiltered)));

end

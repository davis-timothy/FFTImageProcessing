function Fshift = computeFFT(img)

F = fft2(img);

Fshift = fftshift(F);

end

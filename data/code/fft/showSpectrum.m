function showSpectrum(Fshift)

magnitude = log(abs(Fshift)+1);

figure;
imshow(magnitude,[]);
title('Magnitude Spectrum');

end

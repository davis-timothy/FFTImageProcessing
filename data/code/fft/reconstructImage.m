function reconstructed = reconstructImage(Fshift)

F = ifftshift(Fshift);

reconstructed = ifft2(F);

reconstructed = real(reconstructed);

end

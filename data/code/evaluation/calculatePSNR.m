function psnrVal = calculatePSNR(original,processed)

psnrVal = psnr(uint8(processed),uint8(original));

end

function mseVal = calculateMSE(original,processed)

error = double(original)-double(processed);

mseVal = mean(error(:).^2);

end

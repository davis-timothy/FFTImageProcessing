function filtered = gaussianFilter(img,kernelSize,sigma)

kernel = fspecial('gaussian',kernelSize,sigma);

filtered = imfilter(img,kernel);

end

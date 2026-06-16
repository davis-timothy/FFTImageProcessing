function filtered = boxFilter(img,kernelSize)

kernel = ones(kernelSize)/kernelSize^2;

filtered = imfilter(img,kernel);

end

function img = loadImage(filename)

img = imread(filename);

if size(img,3) == 3
    img = rgb2gray(img);
end

img = imresize(img,[256 256]);

img = double(img);

end

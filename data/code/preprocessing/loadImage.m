function img = loadImage(filename)

img = imread(filename);

% Convert RGB to grayscale if needed
if size(img,3) == 3
    img = rgb2gray(img);
end

% Standardize size
img = imresize(img,[256 256]);

% Convert to double
img = double(img);

end

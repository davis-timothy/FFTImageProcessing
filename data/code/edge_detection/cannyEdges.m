function edges = cannyEdges(img)

edges = edge(uint8(img),'canny');

end

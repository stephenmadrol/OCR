I = imread('image.jpg');

% Perform OCR
results = ocr(I);

% Display one of the recognized words
word = results.Words{2}
% Location of the word in I
wordBBox = results.WordBoundingBoxes(2,:)
% Show the location of the word in the original image
figure;
Iname = insertObjectAnnotation(I, 'rectangle', wordBBox, word);
imshow(Iname);
warning off %#ok<WNOFF>
% Clear all
clc, close all, clear all
% Read image
[a,b] = uigetfile({'*.jpg';'*.bmp';'*.jpeg'},'Select Image to convert into Text');
imagen = imread([b a]);
imshow(imagen)
% Show image
imagen = rgb2gray(imagen);


% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen = rgb2gray(imagen);  
end
% Convert to BW
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);
% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
%Storage matrix word from image
word=[ ];
re=imagen;
%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');
% Load templates
load templates
global templates
% Compute the number of letters in template file
num_letras=size(templates,2);
while 1
    %Fcn 'lines' separate lines in text
    [fl, re]=lines(re);
    imgn=fl;
    %Uncomment line below to see lines one by one
    %imshow(fl);pause(0.5)    
    %-----------------------------------------------------------------     
    % Label and count connected components
    [L Ne] = bwlabel(imgn);    
    for n=1:Ne
        [r,c] = find(L==n);
        % Extract letter
        n1=imgn(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[42 24]);
        imshow(img_r)
        %Uncomment line below to see letters one by one
        %imshow(img_r);pause(0.5)
        %-------------------------------------------------------------------
        % Call fcn to convert image to text
        letter=read_letter(img_r,num_letras);
        % Letter concatenation
        word=[word letter];
    end
    %fprintf(fid,'%s\n',lower(word));%Write 'word' in text file (lower)
    fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
    % Clear 'word' variable
    word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end    
end
fclose(fid);
%Open 'text.txt' file
winopen('text.txt')


%add noise to image
%img  = imread('image.jpg');
%imshow(img)
%noice = imnoise(img,'salt & pepper')
%imshow(noice)

i = imread('image.jpg');
ia = rgb2gray(i);
imshow(ia)



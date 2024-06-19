close all; clear; clc
% leo una imagen y la convierto a escala de grises
[file,dir] = uigetfile('*.bmp;*.jpg;*.png; *.tif'); %filtro para archivos bmp, jpg y png
filename = [dir,file];
info = imfinfo(filename);

switch info.ColorType
    case 'indexed'
        [Iorig,map] = imread(filename);
        I = ind2gray(Iorig,map); %convierto de indexada a escala de grises

    case 'grayscale'
        I = imread(filename);
        
    case 'truecolor'
        Iorig = imread(filename);
        I = rgb2gray(Iorig); %convierto de RGB a escala de grises       
end


figure(1);imshow(Iorig)

im_red = double(Iorig(:,:,1));
im_blue = double(Iorig(:,:,2));
im_green = double(Iorig(:,:,3));

imar = im_red - im_blue - im_blue;

imabin = imar > 40;
figure(2);imshow(imabin);
% I = rgb2gray(imabin);
% I=im2double(I); %convierto a clase double
% 
BW = edge(imabin, 'sobel');

figure(3)
subplot(1,2,1)
imshow(Iorig)

subplot(1,2,2)
imshow(BW)
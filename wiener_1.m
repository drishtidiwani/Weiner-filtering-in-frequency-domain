% Wiener filtering in frequency domain
clc;
clear;
close all;

% Reading input image
a = imread('cameraman.tif');
a = double(a(:,:,1));
[r,c] = size(a);

% Degradation function
h = ones(5,5)/25; %normalised matrix

% Random noise
n =w0*randn(r,c);
disp(std2(n)^2)

% Transformation to frequency domain
freq_a = fft2(a);
freq_h = fft2(h,r,c);
freq_n = fft2(n);
 
% Degraded image in spatial domain
% Convolution in spatial domain = multiplication in frequency domain
g = real(ifft2(freq_h.*freq_a))+ n; 

% Wiener filtering
freq_g = fft2(g);
pow_n = abs(freq_n).^2;
pow_a = abs(freq_a).^2;
pow_h = abs(freq_h).^2;
res_freq_a = ((1./freq_h).*(pow_h./(pow_h + pow_n./pow_a))).*freq_g;

% Restored image in spatial domain
res_a = ifft2(res_freq_a);

% Display of input and output images
imshow(uint8(a))
title('original image')
figure
imshow(uint8(g))
title('degraded image')
figure
imshow(uint8(res_a))
title('restored image after wiener filtering')
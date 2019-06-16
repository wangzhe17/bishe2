clc;
clear all;
I = imread('126.png');
im = im2bw(I);
b = bwboundaries(im);
boundary = b{1};

[np, nc] = size(boundary);
if np/2 ~= round(np/2);
   boundary(end + 1, :) = boundary(end, :);
   np = np + 1;
end

% Create an alternating sequence of 1s and -1s for use in centering
% the transform.
x = 0:(np - 1);
m = ((-1) .^ x)';
 
% Multiply the input sequence by alternating 1s and -1s to
% center the transform.
boundary(:, 1) = m .* boundary(:, 1);
boundary(:, 2) = m .* boundary(:, 2);
% Convert coordinates to complex numbers.
s = boundary(:, 1) + 1i*boundary(:, 2);
% Compute the descriptors.
z = fft(s);

np = length(z); 
% Check inputs. 
nd=100;
x = 0:(np - 1); 
m = ((-1) .^ x)'; 

d = round((np - nd)/2); % Round in case nd is odd. 
z(1:d) = 0; 
z(np - d + 1:np) = 0; 

zz = ifft(z); 
s(:, 1) = real(zz); 
s(:, 2) = imag(zz); 

s(:, 1) = m.*s(:, 1); 
s(:, 2) = m.*s(:, 2); 
bb=bound2im(s);
figure,imshow(bb);
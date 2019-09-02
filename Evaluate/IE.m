clc; close all;
X0 = imread('1.png');
X0 = rgb2gray(X0);
X1 = imread('He3.png');
X1 = rgb2gray(X1);
X2 = imread('Meng3.png');
X2 = rgb2gray(X2);
X3 = imread('Retinex3.png');
X3 = rgb2gray(X3);
X4 = imread('our41205.png');
X4 = rgb2gray(X4);

x0 = Imentropy(double(X0))
x1 = Imentropy(double(X1))
x2 = Imentropy(double(X2))
x3 = Imentropy(double(X3))
x4 = Imentropy(double(X4))
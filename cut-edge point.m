%%%%%%%%%%%%%%%%%%%%%%%%%%直接对图像进行分割
% close all;
% clear all;
% 
% image = imread('edge.jpg');
% image_r = image(:,:,1);
% image_g = image(:,:,2);
% image_b = image(:,:,3);
% 
% YCbCr=rgb2ycbcr(image);
% YCbCr_Y=YCbCr(:,:,1);
% YCbCr_Cb=YCbCr(:,:,2);
% YCbCr_Cr=YCbCr(:,:,3);
% 
% figure(1);
% imshow(image);
% title('原图');
% hold on;  %光plot是不行的，必须要有这句，才能实现在 原图 标记点这一目标
% 
% [y,x] = size(image_r); %图像共y行，x列
% 
% for Row_number=1:10:y;
% Row = image_r(Row_number,:); 
% Maximum_Difference=0;
%   for a = 300:1200
%   AverageL=mean(Row(1:(a-1)));
%   AverageR=mean(Row((a+1):x));
%   Difference=abs(AverageL-AverageR);
%     if Difference>Maximum_Difference
%         Maximum_Difference = Difference;
%         boundary = a;
%     end  
%   end
% plot(boundary, Row_number,'Marker','.','MarkerEdgeColor','r');  %标记点并设置点的样式
% 
% end

%%%%%%%%%%%%%%%%%%%%%%%%%对图像进行分割并且将分割点存入矩阵
%%%%%%%%%%%%%%
close all;
clc;
image = imread('test.jpg');
image_r = image(:,:,1);
image_g = image(:,:,2);
image_b = image(:,:,3);
YCbCr=rgb2ycbcr(image);
YCbCr_Y=YCbCr(:,:,1);
YCbCr_Cb=YCbCr(:,:,2);
YCbCr_Cr=YCbCr(:,:,3);

[y,x]=size(YCbCr(:,:,1)); %获取图像尺寸
[X,Y] = meshgrid(1:x,1:y);%设置网格坐标

%%%%%%%%%图像分割
figure;  
imshow(image);
title('原图');
hold on;

boundary=linspace(0,0,y);%设置一个数组，将每一行的分割点横坐标存入
A=[];
n=1

for Row_number=1:10:y
Row = image_r(Row_number,:); %读取第Row_number行
Maximum_Difference=0;
  for a = 200:900
  AverageL=mean(Row(1:(a-1)));
  AverageR=mean(Row((a+1):x));
  Difference=abs(AverageL-AverageR);
    if Difference>Maximum_Difference
        Maximum_Difference = Difference;
        A(n,1)=a;  %分割点存入矩阵第n行的第一个位置
        boundary(Row_number) = a;          %将每一行的分割点横坐标存入
    end  
  end
  
  A(n,2)=Row_number;%当前行数存入矩阵第n行第二个位置
  point(n)=boundary(Row_number);%将分界线数组存入一个连续数组以计算
  n=n+1;
end



for m=1:y  %画出分割点
    if boundary(m)>0
    plot(boundary(m), m,'Marker','.','MarkerEdgeColor','r');  %标记点并设置点的样式
    end
end
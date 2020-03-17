%%%%%%%%%%%%%%%%%%%%%%%%%%ֱ�Ӷ�ͼ����зָ�
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
% title('ԭͼ');
% hold on;  %��plot�ǲ��еģ�����Ҫ����䣬����ʵ���� ԭͼ ��ǵ���һĿ��
% 
% [y,x] = size(image_r); %ͼ��y�У�x��
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
% plot(boundary, Row_number,'Marker','.','MarkerEdgeColor','r');  %��ǵ㲢���õ����ʽ
% 
% end

%%%%%%%%%%%%%%%%%%%%%%%%%��ͼ����зָ�ҽ��ָ��������
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

[y,x]=size(YCbCr(:,:,1)); %��ȡͼ��ߴ�
[X,Y] = meshgrid(1:x,1:y);%������������

%%%%%%%%%ͼ��ָ�
figure;  
imshow(image);
title('ԭͼ');
hold on;

boundary=linspace(0,0,y);%����һ�����飬��ÿһ�еķָ����������
A=[];
n=1

for Row_number=1:10:y
Row = image_r(Row_number,:); %��ȡ��Row_number��
Maximum_Difference=0;
  for a = 200:900
  AverageL=mean(Row(1:(a-1)));
  AverageR=mean(Row((a+1):x));
  Difference=abs(AverageL-AverageR);
    if Difference>Maximum_Difference
        Maximum_Difference = Difference;
        A(n,1)=a;  %�ָ���������n�еĵ�һ��λ��
        boundary(Row_number) = a;          %��ÿһ�еķָ����������
    end  
  end
  
  A(n,2)=Row_number;%��ǰ������������n�еڶ���λ��
  point(n)=boundary(Row_number);%���ֽ����������һ�����������Լ���
  n=n+1;
end



for m=1:y  %�����ָ��
    if boundary(m)>0
    plot(boundary(m), m,'Marker','.','MarkerEdgeColor','r');  %��ǵ㲢���õ����ʽ
    end
end
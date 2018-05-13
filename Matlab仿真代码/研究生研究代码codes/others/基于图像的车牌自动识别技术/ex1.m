% 读取待处理的图像，将其转化为二值图像
I = imread('car.jpg'); 
I2 = rgb2gray(I);
I4 = im2bw(I2, 0.2);
% 去除图像中面积过小的、可以肯定不是车牌的区域
bw = bwareaopen(I4, 500);
% 为定位车牌，将白色区域膨胀，腐蚀去无关的小物件
se = strel('disk',15);
bw = imclose(bw,se);
bw = imfill(bw,[1 1]);
% 查找连通域边界
[B,L] = bwboundaries(bw,4);
imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
% 找出所有连通域中最可能是车牌的那一个
for k = 1:length(B)
 boundary = B{k};
 plot(boundary(:,2),boundary(:,1),'w','LineWidth',2)
end
% 找到每个连通域的质心
stats = regionprops(L,'Area','Centroid');
% 循环历遍每个连通域的边界
for k = 1:length(B)
  % 获取一条边界上的所有点
  boundary = B{k};
  % 计算边界周长
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  % 获取边界所围面积
  area = stats(k).Area;
  % 计算匹配度
  metric = 27*area/perimeter^2;
  % 要显示的匹配度字串
  metric_string = sprintf('%2.2f',metric);
  % 标记出匹配度接近1的连通域
  if metric >= 0.9 && metric <= 1.1
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
    % 提取该连通域所对应在二值图像中的矩形区域
    goalboundary = boundary; 
    s = min(goalboundary, [], 1);
    e = max(goalboundary, [], 1);
  goal = imcrop(I4,[s(2) s(1) e(2)-s(2) e(1)-s(1)]); 
  end
  % 显示匹配度字串
  text(boundary(1,2)-35,boundary(1,1)+13,...
    metric_string,'Color','g',...
'FontSize',14,'FontWeight','bold');
end
goal = ~goal;
goal(256,256) = 0;
figure;
imshow(goal);
w = imread('P.bmp');
w = ~w;
C=real(ifft2(fft2(goal).*fft2(rot90(w,2),256,256)));
thresh = 240;
%figure;
%imshow(C > thresh);

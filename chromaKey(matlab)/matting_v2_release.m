close all;
clear all;
clc;

%% set fg|bg path and save path
imgPath =  '.\images\foreground\'; 
allImgs = dir([imgPath,'*.jpg']);
background = 'images/background/bg2.jpg';

downSample_ratio = 1;  % �²����ʣ�����ᵼ��ͼ������
%% knn kernel filter matting
disp('Chromakeing')
for i = 4:length(allImgs)
    %% read bg and fg
    fg = double(imread([imgPath, allImgs(i).name]));
    height = size(fg,1); width = size(fg,2);
    fg = double(imresize(fg, [floor(height/downSample_ratio),floor(width/downSample_ratio)], 'bilinear'));
    
    bg1 = double(180.*ones(floor(height/downSample_ratio),floor(width/downSample_ratio),3));
    bg2 = double(255.*ones(floor(height/downSample_ratio),floor(width/downSample_ratio),3));
    
    t1 = clock();
    %% get the related matrix 
    [alpha,unknow,fgRegion] = genMaskMatrix(fg,1);    
    
    %% six methods to decrease green channel value     
    imgGd = greenDecrease(fg,unknow,2);
    img_comp = blendingImage(imgGd,bg1,alpha);  % մɫ
    img_comp = blendingImage(img_comp,bg2,alpha);
    
    %% kernel filter from principle of locality 
    img_filter = KnnKernelFilter1(img_comp,unknow,alpha,fgRegion,9,10,15);

    %% image_edge process   
    img_result = Gaussion_edge1(img_filter,unknow,5,1,3);
    img_result = imresize(img_result,[height,width], 'bilinear');
    
    %% ͼ����֡����ʾ
    process = sprintf('Process has finished [ %d / %d]',i,length(allImgs));
    disp(process);
    disp(['֡�� �� ',num2str(1/etime(clock,t1)),'֡']);
    %% show image
%     figure(2)
%     imshow(img_comp./255);
%     figure(3)
%     imshow(img_filter./255);
%     figure(4)
% %     imshow(unknow)
    figure(5)
    imshow(img_result./255);

end
disp('All jobs has finished!');

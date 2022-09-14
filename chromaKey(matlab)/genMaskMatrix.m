function [alpha,unknow,fgRegion]=genMaskMatrix(fg,choice)
% @author:Tanlang
% @illustration:
    % choice == 1 , green chorma key algorithm 1
    % choice == 2 , green chorma key algorithm 2
    
if choice == 1
    % ����(fg,a,b) a,b������0
    % ����aֵ����ɫǰ���������ӣ���֮���٣�����ֵ��0��50��
    % ����bֵ������������٣��������ӣ�����ֵ��90��120��
    % ���߸���������������
        [alpha,unknow,fgRegion] = mask_compulation1(fg,30,100);                                                                     
elseif choice == 2
        [alpha,unknow,fgRegion] = mask_compulation2(fg,1,1.1);
end

%% alpha refine
% ��˹�˲��;ֲ���ԭ��refine alpha����Ч
% alpha = alphaRefine(alpha,fg,unknow);

%% get unknow
% se1=strel('square',3);
% unknow = imdilate(unknow,se1);

%% get fgRegion
% se2=strel('square',3);
% fgRegion = imerode(fgRegion,se2);

end
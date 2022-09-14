function alpha_result = alphaRefine(alpha,img,unknow)
    %% set variable
    kernel_size = 11;
    padding = floor(kernel_size / 2)+1;
    k = 10;
    height = size(img,1); width = size(img,2);d=size(img,3);
    
    img = imgPadding(img,padding);
    unknow = imgPadding(unknow,padding);
    alpha = imgPadding(alpha,padding);
    alpha_result = alpha;

    WeightGau = fspecial('gaussian',[5,5],1);

    %% KNN kernel filter
    for i = padding: height+padding
        for j = padding:width+padding 
            if unknow(i,j) > 0.01
%                     minimatrix = img(i-floor(kernel_size/2):i+floor(kernel_size/2),j-floor(kernel_size/2):j+floor(kernel_size/2),:);
%                     alphamatrix = alpha(i-floor(kernel_size/2):i+floor(kernel_size/2),j-floor(kernel_size/2):j+floor(kernel_size/2),:);
%                                      
%                     [a,b] = ind2sub([kernel_size,kernel_size],1:kernel_size^2);
%                     feature_vector = [reshape(minimatrix,kernel_size^2,d)';[a;b]/sqrt(2*kernel_size^2)+rand(2,kernel_size^2)*1e-6 ];   % Normalize the pixel coordinates, and add random noise  
% 
%                     ind = find(feature_vector(1,:)~=0);
%                     center_feature = repmat([reshape(img(i,j,:),1,d)';[floor(kernel_size/2)+1;floor(kernel_size/2)]/sqrt(2*kernel_size^2)],[1,kernel_size^2]);  % ���ĵ������������󣬰�����չΪ��С 5*kernel_size^2
%                     constant = max(sum(kerf(abs(feature_vector-center_feature)),1));    % ��������Ͻ糣�����Ա�֤�ڽ���ֵС��1
%                     weightVector = 1-sum(kerf(abs(feature_vector-center_feature)),1)./constant;  % �˺��������ڽ���    
% 
%                     % get positive element
%                     weightVector_n = zeros(1,kernel_size^2);    % �ߴ�Ϊ1*kernel_size^2,��ž��ο��ڵ����о���ǰ�����ع��ڸ����صĵ��ڽ�ֵ������ǰ�����ص�Ԫ��ֵ��0
%                     for n = 1:length(ind)
%                         weightVector_n(ind(n)) = weightVector(ind(n));
%                     end
% 
%                     [foreWeight,index] = sort(weightVector_n,2,'descend');     % �ڽ�ֵ�������У��õ�foreWeight���󣬺��ڽ����ص�����index�������ڽ�����λ�ã�
%                     
%                   %%
%                     weights = foreWeight(1:k); index = index(1:k);  % ȡ��ǰk���ڽ�ֵ
%                     weights = weights./sum(sum(weights));  % Make the sum of the weight matrix equal to 1  ��һ��
% 
%                     WeightMatrix = zeros(kernel_size,kernel_size);      % ���ڴ���ڽ����صĹ�һ������ڽ�ֵ
%                     WeightMatrix(index)=weights;    % ���ڽ�ֵ���� WeightMatrix����
%                     alpha_result(i,j,:) = sum(sum(alphamatrix.*WeightMatrix,1),2);

                  %% Gaussion filter
                    miniMatrix = alpha(i-floor(5/2):i+floor(5/2),j-floor(5/2):j+floor(5/2),:);
                    alpha_result(i,j,:) = sum(sum( miniMatrix.*WeightGau ));

            else
                continue;
            end
        end
    end
    alpha_result = alpha_result(padding+1:padding+height,padding+1:padding+width,:);
end
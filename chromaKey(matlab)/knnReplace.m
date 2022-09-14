function value = knnReplace(imgij,minimatrix,fgMatrix,kernel_size)
    k = kernel_size+1;
    indexWeights = zeros(kernel_size,kernel_size); 
    fgMatrix3d(:,:,1) = fgMatrix;
    fgMatrix3d(:,:,2) = fgMatrix;
    fgMatrix3d(:,:,3) = fgMatrix;

    minimatrix = (minimatrix .* fgMatrix3d);  % get fg pixel
    center_feature = repmat(imgij,[kernel_size,kernel_size,1]) .* fgMatrix3d;
    sumOfabs = sum(abs(minimatrix-center_feature),3);
    constant = max(max(sumOfabs));
    weightMatrix = fgMatrix - sumOfabs ./ constant; 
    weightVector = reshape(weightMatrix,[1,kernel_size.^2]);

    [foreWeight,index] = sort(weightVector,2,'descend');  % �ڽ�ֵ�������У��õ�foreWeight���󣬺��ڽ����ص�����index�������ڽ�����λ�ã�

    %%
    index = index(1:k);  % ȡ��ǰk���ڽ�ֵ
    indexWeights(index) = 1;
    weights = indexWeights .* weightMatrix;
    WeightMatrix = weights./sum(sum(foreWeight));  % Make the sum of the weight matrix equal to 1  ��һ��

    WeightMatrix3d(:,:,1) = WeightMatrix;
    WeightMatrix3d(:,:,2) = WeightMatrix;
    WeightMatrix3d(:,:,3) = WeightMatrix;

    value = sum(sum(minimatrix.*WeightMatrix3d,1),2);
end
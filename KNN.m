% =========================================================
% **************** create time: 2020/06/22 ****************
%
% description: K近邻算法（KNN）
%
% Input:       X:     样本矩阵
%              Y:     样本标签
%              K:     样本近邻个数
%              type:  KNN计算类型
%                     0. normal        不区分类别寻找K近邻
%                     1. homogeneous   同类近邻
%                     2. heterogeneous 异类近邻
%
% Output:      Index: 样本的K近邻索引
%                     每行表示样本最近的K个近邻索引
%
% author:      zones
% =========================================================

function Index = KNN(X, Y, K, type)

if nargin < 3
    K = 3;
    type = 'normal';
end

[~, n] = size(X);

Dist = zeros(n);
for i = 1:1:n
    for j = 1:1:n
        Dist(i,j) = norm(X(:,i)-X(:,j));
    end
    Dist(i,i) = -1;
end

Index = zeros(n, K);

switch type
    case {0,'normal'}
        [~, indx] = sort(Dist, 2, 'ascend');
        Index = indx(:,2:K+1);
    case {1,'homogeneous'}
        for i = 1:1:n
            temp = Dist(i,:);
            temp(Y~=Y(i)) = [];
            [~,indx] = sort(temp,'ascend');
            Index(i,:) = indx(2:K+1);
        end
    case {2,'heterogeneous'}
        for i = 1:1:n
            temp = Dist(i,:);
            temp(Y==Y(i)) = [];
            [~,indx] = sort(temp,'ascend');
            Index(i,:) = indx(2:K+1);
        end
end

end
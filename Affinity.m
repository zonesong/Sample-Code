% =========================================================
% **************** create time: 2020/08/20 ****************
%
% description: 构建初始邻接图
%
% Input:       X:   样本矩阵
%              m:   样本近邻个数
%
% Output:      A:   构建的邻接图
%
% paper: The Constrained Laplacian Rank Algorithm for Graph-Based Clustering
%
% author:      zones
% =========================================================
function A = Affinity(X, m)

[~,c] = size(X);
A = zeros(c);
Index = KNN(X, [], m+1, 'normal');

for i = 1:1:c
    E = sum(distance(X(:,i),X(:,Index(i,1:m)),'Euclidian'));
    A(i,Index(i,1:m)) = (distance(X(:,i),X(:,Index(i,m+1)),'Euclidian')-...
        distance(X(:,i),X(:,Index(i,1:m)),'Euclidian'))/...
        (m*distance(X(:,i),X(:,Index(i,m+1)),'Euclidian')-E);
end

end
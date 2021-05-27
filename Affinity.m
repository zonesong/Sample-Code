% =========================================================
% **************** create time: 2020/08/20 ****************
%
% description: ������ʼ�ڽ�ͼ
%
% Input:       X:   ��������
%              m:   �������ڸ���
%
% Output:      A:   �������ڽ�ͼ
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
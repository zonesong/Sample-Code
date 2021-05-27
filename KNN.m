% =========================================================
% **************** create time: 2020/06/22 ****************
%
% description: K�����㷨��KNN��
%
% Input:       X:     ��������
%              Y:     ������ǩ
%              K:     �������ڸ���
%              type:  KNN��������
%                     0. normal        ���������Ѱ��K����
%                     1. homogeneous   ͬ�����
%                     2. heterogeneous �������
%
% Output:      Index: ������K��������
%                     ÿ�б�ʾ���������K����������
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
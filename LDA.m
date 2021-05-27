% =========================================================
% **************** create time: 2020/06/22 ****************
%
% description: 线性判别分析（linear discriminant analysis）
%
% Input:       X:   样本矩阵
%              Y:   样本标签向量
%              dim: 约减后的维度
%
% Output:      W:   线性判别投影
%
% paper: 
%
% author:      zones
% =========================================================

function W = LDA(X, Y, dim)

data = [X' Y];
data = sortrows(data,size(data,2));
X = data(:,1:end-1)';
Y = data(:,end);

[m, n] = size(X);

class = length(unique(Y));

M_c = zeros(m, class);
M_c_all = zeros(m,n);
M = mean(X,2);

for i = 1:1:class
    M_c(:,i) = mean(X(:,Y==i),2);
    M_c_all(:,Y==i) = repmat(M_c(:,i),1,sum(Y==i));
end

Sw = (X-M_c_all)*(X-M_c_all)';
Sb = (M_c-M)*(M_c-M)';

[U, S, ~] = svd(Sw\Sb);

W = U(:,1:dim);

end
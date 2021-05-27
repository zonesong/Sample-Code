% =========================================================
% **************** create time: 2020/06/22 ****************
%
% description: 自适应局部邻域判别分析（adaptive local neighbor discriminant analysis）
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

function [W,a] = ALNDA(X, Y, dim, K, lambda, cut)

if nargin < 4
    K = 3;
    lambda = 10;
    cut = 0.6;
end

[m, n] = size(X);

ID_DX = KNN(X, Y, K, 'heterogeneous');
ID_SX = KNN(X, Y, K, 'homogeneous');


V_SX = zeros(m,n);
V_SY = zeros(dim,n);
V_DX = zeros(m,n);
V_DY = zeros(dim,n);

Ws = zeros(n);
Wp = zeros(n);

for i = 1:1:n
    Ws(i,ID_SX(i,:)) = 1;
    Wp(i,ID_DX(i,:)) = 1;
end

for i = 1:1:n
    V_SX(:,i) = mean(X(:,ID_SX(i,:)),2);
    V_DX(:,i) = mean(X(:,ID_DX(i,:)),2);
end


a = zeros(n,1);
Sw = zeros(m);
Sb = zeros(m);
W = rand(m,dim);

obj = 0;
diff = 1;

count = 1;
while(diff > 0 && count <= 20)
    
    Y_embd = W'*X;
    count = count+1;
    
    ID_DY = KNN(Y_embd, Y, K, 'heterogeneous');
    ID_SY = KNN(Y_embd, Y, K, 'homogeneous');
    
    for i = 1:1:n
        V_SY(:,i) = mean(Y_embd(:,ID_SY(i,:)),2);
        V_DY(:,i) = mean(Y_embd(:,ID_DY(i,:)),2);
    end
    for i = 1:1:n
        A = 2*lambda;
        B = (norm(Y_embd(:,i)-V_DY(:,i)))^2-(norm(Y_embd(:,i)-V_SY(:,i)))^2;
        Delta = B/(2*A);
        if (Delta<-1)
            a(i) = 0;
        elseif (Delta>1)
            a(i) = 1;
        elseif (Delta>=-1 && Delta<=1)
            a(i) = (Delta+1)/2;
        end
        if (a(i)<=cut && 1-a(i)<=cut)
            Sw = Sw+a(i)*(X(:,i)-V_SX(:,i))*(X(:,i)-V_SX(:,i))'+Ws(i,:)*(sum((X-V_SX(:,i)).^2))';
            Sb = Sb+(1-a(i))*(X(:,i)-V_DX(:,i))*(X(:,i)-V_DX(:,i))';
        end
    end
    
    [U, S, ~] = svd(Sw\Sb);
    W = U(:,1:dim);
    
    obj0 = obj;
    obj = trace(W'*Sb*W)/trace(W'*Sw*W);
    diff = obj-obj0;
end

end
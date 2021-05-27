function [W, S] = new_1(X, c, dim, C_link,lambda, gamma, beta)

[~, n] = size(X);

m = 8;

S = Affinity(X,m);

DS = diag(sum(S));
LS = DS-(S'+S)/2;

if ~isempty(C_link)
    YC = zeros(n,size(C_link,1));
    for i = 1:1:size(C_link,1)
        YC(C_link(i,1),i) = 1;
        YC(C_link(i,2),i) = -1;
    end
end

Delta = zeros(n);

ncount = 200;
diff = 10086;
count = 1;
obj0 = -10086;
obj = zeros(1,ncount);
while(diff>0.0001 && count<ncount)
    
    [UF, SF, ~] = svd(LS);
    [~, indx] = sort(diag(SF));
    F = UF(:,indx(1:c));
    
    if ~isempty(C_link)
        for i = 1:1:size(C_link,1)
            temp = 1:n;
            temp(C_link(i,:)) = [];
            DSuu = DS;
            DSuu(C_link(i,:),:) = [];
            DSuu(:,C_link(i,:)) = [];
            Suu = S;
            Suu(C_link(i,:),:) = [];
            Suu(:,C_link(i,:)) = [];
            Sul = S(:,C_link(i,:));
            Sul(C_link(i,:),:) = [];
            Luu = DSuu-Suu;
            Lul = 0-Sul;
            if rank(Luu)<size(Luu,1)
                Luu = Luu+eps*eye(size(Luu,1));
            end
            YC(temp,i) = -inv(Luu)*Lul*[1;-1];
        end
    end
    
    Sw = X*LS*X';
    Sb = X*X';
    
    [UW, SW, ~] = svd(Sw\Sb);
    [~, indx] = sort(diag(SW));
    W = UW(:,indx(1:dim));
    
    WX = W'*X;
    
    for i = 1:1:n
        for j = 1:1:n
            Delta(i,j) = norm(WX(:,i)-WX(:,j))^2+...
                beta*norm(YC(i,:)-YC(j,:))^2+...
                gamma*norm(F(i,:)-F(j,:))^2;
        end
    end
%     S = -0.5*Delta/lambda;
    S = zeros(n);
    for i = 1:1:n
        SD = (sum(Delta(i,1:m))+2*lambda)/m;
        IndexS = KNN(X, [], m, 'normal');
        S(i,IndexS(i,1:m)) = (SD-Delta(i,1:m))/(2*lambda);
    end
    
    objtemp = 0;
    for i = 1:1:n
        for j = 1:1:n
            objtemp = objtemp+norm(WX(:,i)-WX(:,j))^2*S(i,j)+lambda*S(i,j)^2;
        end
    end
    obj(count) = objtemp+beta*trace(YC'*LS*YC)+gamma*trace(F'*LS*F);
    diff = abs(obj(count)-obj0);
    obj0 = obj(count);
    count = count+1;
end

end
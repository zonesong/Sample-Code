close all
clear
clc

load colorandshape.mat
load iris_uni.mat

data = [X Y];
data = sortrows(data,size(data,2));
X = data(:,1:end-1);
Y = data(:,end);
if sum(Y==1)<10
    X(Y==1,:) = [];
    Y(Y==1) = [];
    Y = Y-1;
end

X = X(Y<3,1:2);
Y = Y(Y<3,:);

class_v = unique(Y);
class = length(class_v);

X = X';
% X = normalization(X);

temp = X';
temp = sum(abs(temp-mean(temp)));
X(temp==0,:) = [];

% 划分训练集和测试集
Kfold = 1;
Index = cross_validation(Y', Kfold);

acc1 = zeros(Kfold, 1);
acc2 = zeros(Kfold, 1);

for k_fold = 1:1:Kfold
    X_train = X(:,Index{k_fold,1});
    Y_train = Y(Index{k_fold,1});
    X_test = X(:,Index{k_fold,2});
    Y_test = Y(Index{k_fold,2});
    
    [m, n] = size(X_train);
    
    % label noise
    nrat = 0.45;
    ridx = randperm(n);
    
    for i = 1:1:floor(n*nrat)
        temp = class_v;
        temp(temp==Y_train(ridx(i))) = [];
        Y_train(ridx(i)) = temp(randi(length(temp)));
    end
    
    figure('color',[1 1 1],'name','Projected directions')
    for i = 1:1:class
        plot(X_train(1,Y_train==i),X_train(2,Y_train==i),shape(i))
        hold on
    end
    
    dim = 1;
    K = 3;
    lambda = 10;
    cut = 1;
    [W1,a] = ALNDA(X_train, Y_train, dim, K, lambda, cut);
    W2 = LDA(X_train, Y_train, dim);
    
    for i = 1:1:2
        temp_string = ['W=W' num2str(i)];
        eval(temp_string)
        
        center = mean(X_train,2);
        center_c1 = mean(X_train(:,Y_train==1),2);
        center_c2 = mean(X_train(:,Y_train==2),2);
%         b = W(1)/W(2)*center(1)+center(2);
        b = -W'*center;
        
        if (W'*center_c1+b>0)
            c1 = 1;
            c2 = 2;
        else
            c1 = 2;
            c2 = 1;
        end
        
        xp = linspace(min(X_train(1,:)), max(X_train(1,:)), 100);
%         yp = -W(1)/W(2)*xp+b;
        yp = -(W(1)*xp+b)/W(2);
        
        predict = W'*X_test+b;
%         predict = X_test();
        predict(predict>0) = c1;
        predict(predict<=0) = c2;
        acc = mean(predict'==Y_test);
        
        temp_string = ['acc' num2str(i) '(k_fold)=acc'];
        eval(temp_string)
        
        temp_string = ['h' num2str(i) '=plot(xp, yp, color(i));'];
        eval(temp_string)
        hold on
    end
    legend([h1,h2],'ALNDA','LDA');
    
    for i = 1:1:2
        temp_string = ['W=W' num2str(i)];
        eval(temp_string)
        
        X_emd_train = [W'*X_train; ones(1,length(W'*X_train))];
        X_emd_test = [W'*X_test; -ones(1,length(W'*X_test))];
        
        figure()
        for j = 1:1:class
            plot(X_emd_train(1,Y_train==j),X_emd_train(2,Y_train==j),shape(j))
            hold on
            plot(X_emd_test(1,Y_test==j),X_emd_test(2,Y_test==j),shape(j))
            hold on
        end
    end
end

acc1 = mean(acc1);
acc2 = mean(acc2);
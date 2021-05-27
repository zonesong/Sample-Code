clear
clc

load TMSD.mat

X = X';
[~, n] = size(X);

TMSD_figure(X',label,'Original data');

% C_link = [];
% count = 1;
% for i = 1:1:n
%     for j = 1:1:n
%         if (label(i)~=label(j))
%             C_link(count,:) = [i j];
%             count = count+1;
%         end
%     end
% end

C_link = [12 102; 94 199; 94 200];

c = 2;
dim = 1;
lambda = 0.1;
beta = 0.5;
gamma = 100;

[W, S] = new_1(X, c, dim, C_link,lambda, gamma, beta);

% figure()
% WX = W'*X;
% % WX = [ones(1,200);WX];
% WX = [WX;ones(1,200)];
% plot(WX(1,1:100),WX(2,1:100),'or');
% hold on
% plot(WX(1,101:200),WX(2,101:200),'xb');

TMSD_figure(X',label,'PCOG',2,S);
for i = 1:1:max(size(X))
    text(X(1,i)+0.02,X(2,i),num2str(i),...
        'horiz','left','color','k','fontsize',10)
end
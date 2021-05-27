clear
clc

load TMSD.mat

X = X';

TMSD_figure(X',label,'Original data');

M_link = [178 175; 8 16; 43 47; 18 20];
C_link = [12 102; 94 199; 94 200];

c = 2;
lambda = 100;
gamma = 0.5;

[S,A,count,diff,obj] = PCOG(X, c, M_link, C_link,lambda, gamma);

TMSD_figure(X',label,'Affinity',2,A);

TMSD_figure(X',label,'PCOG',2,S);
for i = 1:1:max(size(X))
    text(X(1,i)+0.02,X(2,i),num2str(i),...
        'horiz','left','color','k','fontsize',10)
end

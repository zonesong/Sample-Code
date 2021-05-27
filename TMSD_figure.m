% =========================================================
% **************** create time: 2020/08/20 ****************
%
% description: �������������ηֲ���
%
% Input:       A:     ����A���߾���A
%              B:     ����B���߾���B
%              type:  ������ʽ
%                     0. Euclidian        ����ŷʽ������ж���
%
% Output:      D:     �������֮��ľ���
%
% expect:      ������������������ʽ
%
% author:      zones
% =========================================================
function TMSD_figure(X,y,str,flag,S)
 
% str: name of figure
% X: data matrix
% y: label of data
% flag: choose mode 1.origin figure 2.connected figure
% S: similarity matrix
 
if nargin < 3
    str = 'Please enter the title of figure';
end
if nargin < 4
    flag = 1;
end
 
if flag == 1
    figure
    plot(X(:,1),X(:,2),'.k','Markersize',18)
    hold on
    plot(X(y == 1,1),X(y == 1,2),'.r','Markersize',18)
    hold on
    plot(X(y == 2,1),X(y == 2,2),'.b','Markersize',18)
    hold on
    axis equal
    title(['',num2str(str)],'Interpreter','none')
end
if flag == 2
    figure
    plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
    plot(X(y==1,1),X(y==1,2),'.r', 'MarkerSize', 18); hold on;
    plot(X(y==2,1),X(y==2,2),'.', 'MarkerSize', 18); hold on;
    for ii = 1 : 200
        for jj = 1 : ii
            weight = S(ii, jj);
            if weight > 0
                plot([X(ii, 1), X(jj, 1)], [X(ii, 2), X(jj, 2)], '-g', 'LineWidth', eps*weight), hold on;
            end
        end
    end
    axis equal;
    title(['',num2str(str)],'Interpreter','none')
end
end

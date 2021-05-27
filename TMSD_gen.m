% =========================================================
% **************** create time: 2020/08/20 ****************
%
% description: 生成两个月牙形分布簇
%
% Input:       A:     向量A或者矩阵A
%              B:     向量B或者矩阵B
%              type:  度量方式
%                     0. Euclidian        采用欧式距离进行度量
%
% Output:      X:     matrix of Two-Moon Synthetic Data (TMSD)
%
% expect:      后续完善其他度量方式
%
% author:      zones
% =========================================================
function [X,y] = TMSD_gen(noise,N1,N2,horizontal,vertical)

% X: matrix of Two-Moon Synthetic Data (TMSD)
% N1: number of sample in one class
% N2: number of sample in another class

if nargin < 1
    noise = 0.12;
end
if nargin < 2
    N1 = 100;
end
if nargin < 3
    N2 = N1;
end
if nargin <= 3
    level = 0.35;
    upright = 0.15;
else
    level = 0.35+horizontal;
    upright = 0.15+vertical;
end

t = pi:-pi/(N1-1):0;
X(1:N1,1) = cos(t)'+randn(N1,1)*noise-level;
X(1:N1,2) = sin(t)'+randn(N1,1)*noise-upright;

t = pi:pi/(N2-1):2*pi;
X(N1+1:N1+N2,1) = cos(t)'+randn(N2,1)*noise+level;
X(N1+1:N1+N2,2) = sin(t)'+randn(N2,1)*noise+upright;

y = [ones(N1,1); 2*ones(N2,1)];
end

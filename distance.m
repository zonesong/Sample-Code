% =========================================================
% **************** create time: 2020/08/20 ****************
%
% description: 计算两个向量之间的距离（采用自设定度量方式）
%
% Input:       A:     向量A或者矩阵A
%              B:     向量B或者矩阵B
%              type:  度量方式
%                     0. Euclidian        采用欧式距离进行度量
%
% Output:      D:     输出向量之间的距离
%
% expect:      后续完善其他度量方式
%
% author:      zones
% =========================================================

function D = distance(A, B, type)

switch type
    case {0,'Euclidian'}
        D = sqrt(sum((A-B).^2,1));
end

end
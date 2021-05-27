% =========================================================
% **************** create time: 2020/06/15 ****************
%
% description: K折交叉验证，用于划分训练集和测试集，默认k=5
%
% Input:       label: 样本标签向量
%              k:     交叉验证折数
%
% Output:      Index: 存储了划分好的样本标签索引
%                     元胞数组第一列为训练集索引，第二列为测试集索引
%
% expect:      加入验证集，完善多种交叉验证方式
%
% *************** modified time: 2020/07/10 ***************
%
% description: 加入带有验证集的交叉验证方法，且默认比例如下(有序)
%              training set:         60%
%              cross validation set: 20%
%              test set:             20%
%
% Input:       label: 样本标签向量
%              k:     交叉验证折数
%              type:  交叉验证方式
%                     0.non-validation 不带验证集
%                     1.validation     带验证集
%
% Output:      Index: 存储了划分好的样本标签索引
%                     0.non-validation: 索引为两列
%                       元胞数组第一列为训练集索引，第二列为测试集索引
%                     1.validation: 索引为三列
%                       元胞数组第一列为训练集索引
%                              第二列为验证集索引
%                               第三列为测试集索引
%
% expect:      加入可调节各部分数据集比例功能，增加无序分割方式
%
% author:      zones
% =========================================================

function [Index] = cross_validation(label, k, type)

if size(label,1) > size(label,2)
    label = label';
end

if nargin < 2
    k = [];
    type = 'validation';
end

if nargin < 3
    type = 'non-validation';
end

class = unique(label);

switch type
    case {0,'non-validation'}
        Index = cell(k,2);
        
        if k == 1
            Index{1,1} = 1:length(label);
            Index{1,2} = 1:length(label);
        else
            for j = 1:1:k
                for i = 1:1:length(class)
                    indx = find(label==class(i));
                    n = length(indx);
                    Index{j,2} = [Index{j,2} indx(floor(n*(j-1)/k)+1:floor(n*(j)/k))];
                    temp = indx;
                    temp(floor(n*(j-1)/k)+1:floor(n*(j)/k)) = [];
                    Index{j,1} = [Index{j,1} temp];
                end
            end
        end
    case {1,'validation'}
        Index = cell(1,3);
        
        for i = 1:1:length(class)
            indx = find(label==class(i));
            n = length(indx);
            Index{1,1} = [Index{1,1} indx(1:floor(n*0.6))];
            Index{1,2} = [Index{1,2} indx(floor(n*0.6)+1:floor(n*0.8))];
            Index{1,3} = [Index{1,3} indx(floor(n*0.8)+1:end)];
        end
end

end
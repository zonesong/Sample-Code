% =========================================================
% **************** create time: 2020/07/10 ****************
%
% description: 数据集分割，划分为训练集和测试集
%
% Input:       label: 样本标签向量
%              rat:   训练集比例 (默认训练集为80%)
%              type:  分割方式
%                     0. ordered    有序划分，取前rat为训练集
%                     1. disordered 无序划分，随机取rat为训练集
%
% Output:      Index: 存储了划分好的样本标签索引
%                     元胞数组第一列为训练集索引，第二列为测试集索引
%
% author:      zones
% =========================================================

function Index = data_division(label, rat, type)

if size(label,1) > size(label,2)
    label = label';
end

if nargin < 2
    rat = 0.8;
    type = 'ordered';
end

if nargin < 3
    type = 'ordered';
end

class = unique(label);

Index = cell(1,2);

switch type
    case {0,'ordered'}
        for i = 1:1:length(class)
            indx = find(label==class(i));
            n = length(indx);
            Index{1,1} = [Index{1,1} indx(1:floor(n*rat))];
            Index{1,2} = [Index{1,2} indx(floor(n*rat)+1:end)];
        end
    case {1,'disordered'}
        for i = 1:1:length(class)
            indx = find(label==class(i));
            n = length(indx);
            randindx = randperm(n);
            Index{1,1} = [Index{1,1} indx(randindx(1:floor(n*rat)))];
            Index{1,2} = [Index{1,2} indx(randindx(floor(n*rat)+1:end))];
        end
end

end
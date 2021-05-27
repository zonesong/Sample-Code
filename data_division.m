% =========================================================
% **************** create time: 2020/07/10 ****************
%
% description: ���ݼ��ָ����Ϊѵ�����Ͳ��Լ�
%
% Input:       label: ������ǩ����
%              rat:   ѵ�������� (Ĭ��ѵ����Ϊ80%)
%              type:  �ָʽ
%                     0. ordered    ���򻮷֣�ȡǰratΪѵ����
%                     1. disordered ���򻮷֣����ȡratΪѵ����
%
% Output:      Index: �洢�˻��ֺõ�������ǩ����
%                     Ԫ�������һ��Ϊѵ�����������ڶ���Ϊ���Լ�����
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
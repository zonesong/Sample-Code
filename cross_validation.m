% =========================================================
% **************** create time: 2020/06/15 ****************
%
% description: K�۽�����֤�����ڻ���ѵ�����Ͳ��Լ���Ĭ��k=5
%
% Input:       label: ������ǩ����
%              k:     ������֤����
%
% Output:      Index: �洢�˻��ֺõ�������ǩ����
%                     Ԫ�������һ��Ϊѵ�����������ڶ���Ϊ���Լ�����
%
% expect:      ������֤�������ƶ��ֽ�����֤��ʽ
%
% *************** modified time: 2020/07/10 ***************
%
% description: ���������֤���Ľ�����֤��������Ĭ�ϱ�������(����)
%              training set:         60%
%              cross validation set: 20%
%              test set:             20%
%
% Input:       label: ������ǩ����
%              k:     ������֤����
%              type:  ������֤��ʽ
%                     0.non-validation ������֤��
%                     1.validation     ����֤��
%
% Output:      Index: �洢�˻��ֺõ�������ǩ����
%                     0.non-validation: ����Ϊ����
%                       Ԫ�������һ��Ϊѵ�����������ڶ���Ϊ���Լ�����
%                     1.validation: ����Ϊ����
%                       Ԫ�������һ��Ϊѵ��������
%                              �ڶ���Ϊ��֤������
%                               ������Ϊ���Լ�����
%
% expect:      ����ɵ��ڸ��������ݼ��������ܣ���������ָʽ
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
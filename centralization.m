% =========================================================
% **************** create time: 2020/06/15 ****************
%
% description: �����ݽ������Ļ�����
%
% Input:       A: ��������Ĭ����������Ϊ��������
%
% Output:      A: ���Ļ�֮�����������
%
% expect:      �������������ֱ�ʾ���б�ʾ���б�ʾ
%              �������ƶ����ֱ�ʾ�ķֱ棨���������ݶ�ͳһ����������ʾ��
%
% author:      zones
% =========================================================

function A = centralization(A)

A = A-mean(A,2);

end
clear;
clc;
% intial parameters
n_iter = 41; %��������n_iter��ʱ��
sz = [n_iter, 1]; % size of array. n_iter�У�1��
%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q = 1e-4; % wait for seeking
R = 0.05; % wait 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
z = xlsread('a.xls','sheet1','C2:C42'); % z���¶ȼƵĲ������������ʵֵ�Ļ����ϼ����˷���Ϊ0.25�ĸ�˹������
% ��������г�ʼ��
xhat=zeros(sz); % ���¶ȵĺ�����ơ�����kʱ�̣�����¶ȼƵ�ǰ����ֵ��k-1ʱ��������ƣ��õ������չ���ֵ
P=zeros(sz); % ������Ƶķ���
xhatminus=zeros(sz); % �¶ȵ�������ơ�����k-1ʱ�̣���kʱ���¶������Ĺ���
Pminus=zeros(sz); % ������Ƶķ���
K=zeros(sz); % ���������棬��Ӧ���¶ȼƲ�����������ģ�ͣ�����ǰʱ������һʱ���¶���ͬ��һģ�ͣ��Ŀ��ų̶�
% intial guesses
xhat(1) = z(1); %�¶ȳ�ʼ����ֵΪ23.5��
P(1) =1; %����Ϊ1
for k = 2:n_iter
% ʱ����£�Ԥ�⣩
xhatminus(k) = xhat(k-1); %����һʱ�̵����Ź���ֵ����Ϊ�Ե�ǰʱ�̵��¶ȵ�Ԥ��
Pminus(k) = P(k-1)+Q; %Ԥ��ķ���Ϊ��һʱ���¶����Ź���ֵ�ķ�������̷���֮��
% �������£�У����
K(k) = Pminus(k)/( Pminus(k)+R ); %���㿨��������
xhat(k) = xhatminus(k)+K(k)*(z(k)-xhatminus(k)); %��ϵ�ǰʱ���¶ȼƵĲ���ֵ������һʱ�̵�Ԥ�����У�����õ�У��������Ź��ơ��ù��ƾ�����С������
P(k) = (1-K(k))*Pminus(k); %�������չ���ֵ�ķ���
end
FontSize=12;
LineWidth=2;
figure();
plot(z,'k+'); %�����¶ȼƵĲ���ֵ
hold on;
plot(xhat,'b-','LineWidth',LineWidth) %�������Ź���ֵ
legend('Q=1e-4;R=0.05�������');
xl=xlabel('ʱ��(x0.15s)');
yl=ylabel('����y(m)');
set(xl,'fontsize',FontSize);
set(yl,'fontsize',FontSize);
hold off;
set(gca,'FontSize',FontSize);
figure();
valid_iter = [2:n_iter]; % Pminus not valid at step 1
plot(valid_iter,P([valid_iter]),'LineWidth',LineWidth); %�������Ź���ֵ�ķ���
legend('Q=1e-4;R=0.05������Ʒ���');
xl=xlabel('ʱ��(x0.15s)');
yl=ylabel('m^2');
set(xl,'fontsize',FontSize);
set(yl,'fontsize',FontSize);
set(gca,'FontSize',FontSize);
xlswrite('d3.xls', xhat);
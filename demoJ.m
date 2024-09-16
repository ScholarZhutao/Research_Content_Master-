clc;close all;clear all;
%---------
miu0=4*pi*1e-7;
[data50]=xlsread("D:\BaiduSyncdisk\paper\1\试验文档\实验数据\未退火铁心\未退火3.43mm\B-H数据\未退火_3.43mm_50Hz.xlsx");
H_test50=data50(:,1);     B_test50=data50(:,2);   M0=B_test50(1)/miu0-H_test50(1);
%%%%%%%%
param=[
1.128251e+03	,2.929244e+01	,2.290241e-02	,1.918739e-03,	1.660577e+06;    % 未退火     1
3.716607e+02	,2.308846e+01,	7.074372e-05	,4.891553e-04,	1.431168e+06;    %320℃退火   2
5.217713e+02	,2.552947e+01,	1.237220e-04	,7.748844e-04,	1.487776e+06;    %345℃退火   3
3.794046e+02	,1.102153e+02,	1.095524e-01	,3.809336e-04,	1.395607e+06;    %370℃退火   4
9.768637e+03	,2.720042e+03,	4.964639e-01	,1.325575e-02,	1.957497e+06;    %395℃退火   5
];







a=param(:,1); k=param(:,2); c=param(:,3); alpha=param(:,4); Ms=param(:,5);

%%%%%

P=1;

[H,B] = dMdBJ(a(P,1),k(P,1),c(P,1),alpha(P,1),Ms(P,1),50,B_test50,H_test50);
figure(1)
hold on 
plot(H,B,"b-");
plot(H_test50,B_test50,"r-");
hold off
fprintf(" Simulated loss: %f, Measured Loss: %f, Relative error is:%f %%",polyarea(H,B),polyarea(H_test50,B_test50),(polyarea(H,B)-polyarea(H_test50,B_test50)/polyarea(H_test50,B_test50)*100));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
title("Unnealing")
xlabel("H(A/m)","FontAngle","italic");ylabel("B(T)","FontAngle","italic");
% legend([plt,p317lt,p292lt,p267lt,p243lt,p23lt],"3.43mm","3.17mm","2.92mm","2.67mm","2.43mm","2.3mm","location","NorthWest")
set(gca,'FontName','Times');
set(gca,'FontSize',10);
set(gca,'FontWeight','bold');
set(gca,'FontName','Times');
%  网格
grid on;
set(gca, 'GridLineStyle', '--');  % 设置为虚线
set(gca, 'GridAlpha', 1);  % 设置透明度，注意参数的范围是[0,1]
%图例
legend('boxoff');
% set(lg1,'FontSize',10,'FontName','Times','FontWeight','bold');
% set(lg1,'Location','northwest');
%设置输出的图的大小
set(gcf,'PaperUnits','centimeters')
set(gcf,'PaperSize',[28,11.4])
set(gcf,'PaperPositionMode','manual')
set(gcf,'PaperPosition',[0,0,28,11.4]);
set(gcf,'Renderer','painters');
%--------------------


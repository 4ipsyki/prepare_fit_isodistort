
plot_title=strrep(plot_title,'_','\_');

max_int=max([Iexp(:);Icalc(:)]);

%%%%%%% start plot structure factor %%%%%%%%
% modify this part according to how the data is structured. Below are some
% examples. Note that the data are plotted in the original parent Q0
% notation.

deltahkl=0.6; % half interval around Bragg position to select peaks

% % 0kl
% id1=Q0(:,1)>=0-deltahkl; id2=Q0(:,1)<=0+deltahkl; idq=logical(id1.*id2);
% figure(10), clf, dime(15,15)
% scatter(Q0(idq,2),Q0(idq,3),round(Iexp(idq))+1,'o','markerfacecolor','r',...
%     'markeredgecolor','none','markerfacealpha',0.3);
% hold on
% scatter(Q0(idq,2),Q0(idq,3),round(Icalc(idq))+1,'o','markerfacecolor','b',...
%     'markeredgecolor','none','markerfacealpha',0.3);
% hold off
% xlabel('K_{parent} in (0KL) [rlu]'),ylabel('L_{parent} in (0KL) [rlu]')
% legend('Iexp','Icalc'), title(plot_title,'interpreter','latex','fontsize',20)
% set(gca,'linewidth',1,'fontsize',15,'box','on')
% if saveflag; savepng(plot_fullpath,[plot_name,'_','comparison_0kl'],500); end

% h0l
id1=Q0(:,2)>=0-deltahkl; id2=Q0(:,2)<=0+deltahkl; idq=logical(id1.*id2);
figure(11), clf, dime(15,15)
scatter(Q0(idq,1),Q0(idq,3),round(Iexp(idq))+1,'o','markerfacecolor','r',...
    'markeredgecolor','none','markerfacealpha',0.3);
hold on
scatter(Q0(idq,1),Q0(idq,3),round(Icalc(idq))+1,'o','markerfacecolor','b',...
    'markeredgecolor','none','markerfacealpha',0.3);
hold off
xlabel('H_{parent} in (H0L) [rlu]'),ylabel('L_{parent} in (H0L) [rlu]')
legend('Iexp','Icalc'), title(plot_title,'interpreter','latex','fontsize',20)
set(gca,'linewidth',1,'fontsize',15,'box','on')
if saveflag; savepng(plot_fullpath,[plot_name,'_','comparison_h0l'],500); end

% hk0
id1=Q0(:,3)>=0-deltahkl; id2=Q0(:,3)<=0+deltahkl; idq=logical(id1.*id2);
figure(12), clf, dime(15,15)
scatter(Q0(idq,1),Q0(idq,2),round(Iexp(idq))+1,'o','markerfacecolor','r',...
    'markeredgecolor','none','markerfacealpha',0.3);
hold on
scatter(Q0(idq,1),Q0(idq,2),round(Icalc(idq))+1,'o','markerfacecolor','b',...
    'markeredgecolor','none','markerfacealpha',0.3);
hold off
xlabel('H_{parent} in (HK0) [rlu]'),ylabel('K_{parent} in (HK0) [rlu]')
legend('Iexp','Icalc'), title(plot_title,'interpreter','latex','fontsize',20)
set(gca,'linewidth',1,'fontsize',15,'box','on')
if saveflag; savepng(plot_fullpath,[plot_name,'_','comparison_hk0'],500); end

% % hhl
% id1=abs(Q0(:,1))>=abs(Q0(:,2))-deltahkl; id2=abs(Q0(:,1))<=abs(Q0(:,2))+deltahkl; idq=logical(id1.*id2);
% figure(13), clf, dime(15,15)
% scatter((Q0(idq,1)+Q0(idq,2))/2,Q0(idq,3),round(Iexp(idq))+1,'o','markerfacecolor','r',...
%     'markeredgecolor','none','markerfacealpha',0.3);
% % scatter(Q0(idq,1),Q0(idq,3),round(Iexp(idq))+1,'o','markerfacecolor','r',...
% %     'markeredgecolor','none','markerfacealpha',0.3);
% % scatter(Q0(idq,2),Q0(idq,3),round(Iexp(idq))+1,'o','markerfacecolor','r',...
% %     'markeredgecolor','none','markerfacealpha',0.3);
% hold on
% scatter((Q0(idq,1)+Q0(idq,2))/2,Q0(idq,3),round(Icalc(idq))+1,'o','markerfacecolor','b',...
%     'markeredgecolor','none','markerfacealpha',0.3);
% % scatter(Q0(idq,1),Q0(idq,3),round(Icalc(idq))+1,'o','markerfacecolor','b',...
% %     'markeredgecolor','none','markerfacealpha',0.3);
% % scatter(Q0(idq,2),Q0(idq,3),round(Icalc(idq))+1,'o','markerfacecolor','b',...
% %     'markeredgecolor','none','markerfacealpha',0.3);
% hold off
% xlabel('(H_{parent}+K_{parent})/2 with H\approx{}K [rlu]'),ylabel('L_{parent} [rlu]')
% % xlabel('H_{parent} with H\approx{}K [rlu]'),ylabel('L_{parent} [rlu]')
% % xlabel('K_{parent} with H\approx{}K [rlu]'),ylabel('L_{parent} [rlu]')
% legend('Iexp','Icalc'), title(plot_title,'interpreter','latex','fontsize',20)
% set(gca,'linewidth',1,'fontsize',15,'box','on')
% if saveflag; savepng(plot_fullpath,[plot_name,'_','comparison_hhl'],500); end

% (only few peaks) 1D Q vs. I plot
shift=round(max_int*0.15);
qq=sqrt(Q0(:,1).^2+Q0(:,2).^2+Q0(:,3).^2);
[as,bs]=unique(qq);
figure(20), clf, dime(30,15)
hold on
bar(as,Icalc(bs),0.1,'Facecolor',[0 0.5 0.5],'EdgeColor','k')
plot(as,Iexp(bs),'p','Color',[0.9 0.05 0.1],'markersize',10)
plot(as,(Iexp(bs)-Icalc(bs))-shift,'*','color',[0.2 0.5 0.1],'linewidth',1)
hold off
xlabel('Q_{parent} [rlu]'), ylabel('Intensity [au]')
legend('Icalc','Iexp','Iexp-Icalc')
title(plot_title,'interpreter','latex','fontsize',20)
set(gca,'linewidth',1,'fontsize',15,'box','on')
if saveflag; savepng(plot_fullpath,[plot_name,'_','comparison_QvsI_subset'],500); end

% (complete peaks) 1D Q vs. I plot
% shift=round(max([Icalc(:);Iexp(:)])*0.15);
% qq=sqrt(Q0(:,1).^2+Q0(:,2).^2+Q0(:,3).^2);
% figure(21), clf, dime(30,15)
% hold on
% plot(qq,Icalc,'o','Color',[0.15 0.15 0.9],'markerfacecolor','none','markersize',12)
% plot(qq,Iexp,'p','Color',[0.9 0.05 0.1],'markerfacecolor',[0.9 0.05 0.1],'markersize',10)
% plot(qq,(Iexp-Icalc)-shift,'-','color',[0.2 0.5 0.1],'linewidth',1)
% hold off
% xlabel('Q_{parent} [rlu]'), ylabel('Intensity [au]')
% legend('Icalc','Iexp','Iexp-Icalc')
% title(plot_title,'interpreter','latex','fontsize',20)
% set(gca,'linewidth',1,'fontsize',15,'box','on')
% if saveflag; savepng(plot_fullpath,[plot_name,'_','comparison_QvsI_complete'],500); end

% Iexp vs. Icalc plot
figure(22), clf, dime(15,15)
hold on
plot(Iexp,Icalc,'.','Color',[0.9 0.03 0.4],'markersize',10)
plot([0 max_int],[0 max_int],'--k','linewidth',2)
hold off
xlabel('Experimental Intensity [au]'), ylabel('Calculated Intensity [au]')
xlim([0 max_int]), ylim([0 max_int])
title(plot_title,'interpreter','latex','fontsize',20)
axis square
set(gca,'linewidth',1,'fontsize',15,'box','on')
if saveflag; savepng(plot_fullpath,[plot_name,'_','comparison_IvsI'],500); end

%%%%%%% end plot structure factor %%%%%%%%


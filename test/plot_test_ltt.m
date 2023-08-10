function plot_test_ltt(Q0,Iexp,Icalc,pars,aa,bb,cc,plot_title,saveflag)

% saveflag = 0; ===> figures are not saved automatically
% saveflag = 1; ===> figures are saved automatically (if saving line is uncommented)
if nargin == 7
    plot_title = 'test_ltt';
    saveflag = 0;
elseif nargin == 8
    saveflag = 0;
end

%plot_name = plot_title; % master file name for figures
plot_name = 'test_ltt'; % master file name for figures
plot_fullpath = '~/isodistort2matlab/test/plots/';

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
% id1=Q0(:,3)>=0-deltahkl; id2=Q0(:,3)<=0+deltahkl; idq=logical(id1.*id2);
% figure(12), clf, dime(15,15)
% scatter(Q0(idq,1),Q0(idq,2),round(Iexp(idq))+1,'o','markerfacecolor','r',...
%     'markeredgecolor','none','markerfacealpha',0.3);
% hold on
% scatter(Q0(idq,1),Q0(idq,2),round(Icalc(idq))+1,'o','markerfacecolor','b',...
%     'markeredgecolor','none','markerfacealpha',0.3);
% hold off
% xlabel('H_{parent} in (HK0) [rlu]'),ylabel('K_{parent} in (HK0) [rlu]')
% legend('Iexp','Icalc'), title(plot_title,'interpreter','latex','fontsize',20)
% set(gca,'linewidth',1,'fontsize',15,'box','on')
% if saveflag; savepng(plot_fullpath,[plot_name,'_','comparison_hk0'],500); end

% hhl
id1=abs(Q0(:,1))>=abs(Q0(:,2))-deltahkl; id2=abs(Q0(:,1))<=abs(Q0(:,2))+deltahkl; idq=logical(id1.*id2);
figure(13), clf, dime(15,15)
scatter((Q0(idq,1)+Q0(idq,2))/2,Q0(idq,3),round(Iexp(idq))+1,'o','markerfacecolor','r',...
    'markeredgecolor','none','markerfacealpha',0.3);
% scatter(Q0(idq,1),Q0(idq,3),round(Iexp(idq))+1,'o','markerfacecolor','r',...
%     'markeredgecolor','none','markerfacealpha',0.3);
% scatter(Q0(idq,2),Q0(idq,3),round(Iexp(idq))+1,'o','markerfacecolor','r',...
%     'markeredgecolor','none','markerfacealpha',0.3);
hold on
scatter((Q0(idq,1)+Q0(idq,2))/2,Q0(idq,3),round(Icalc(idq))+1,'o','markerfacecolor','b',...
    'markeredgecolor','none','markerfacealpha',0.3);
% scatter(Q0(idq,1),Q0(idq,3),round(Icalc(idq))+1,'o','markerfacecolor','b',...
%     'markeredgecolor','none','markerfacealpha',0.3);
% scatter(Q0(idq,2),Q0(idq,3),round(Icalc(idq))+1,'o','markerfacecolor','b',...
%     'markeredgecolor','none','markerfacealpha',0.3);
hold off
xlabel('(H_{parent}+K_{parent})/2 with H\approx{}K [rlu]'),ylabel('L_{parent} [rlu]')
% xlabel('H_{parent} with H\approx{}K [rlu]'),ylabel('L_{parent} [rlu]')
% xlabel('K_{parent} with H\approx{}K [rlu]'),ylabel('L_{parent} [rlu]')
xlim([1.75 2.25])
legend('Iexp','Icalc'), title(plot_title,'interpreter','latex','fontsize',20)
set(gca,'linewidth',1,'fontsize',15,'box','on')
if saveflag; savepng(plot_fullpath,[plot_name,'_','comparison_hhl'],500); end

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


%% supercell plot
% atoms ionic size
asz = [195  145   48   48   48  253];

% atoms color in RGB/255
cl = [0.09754      0.2785     0.54688;
    0.95751     0.96489     0.15761;
    0.97059     0.95717     0.48538;
    0.80028     0.14189     0.42176;
    0.91574     0.79221     0.95949;
    0.65574    0.035712     0.84913];

% La
pos0{1} = atomic_positions_La_test_ltt(zeros(1,14));
% Cu
pos0{2} = atomic_positions_Cu_test_ltt(zeros(1,5));
% O1
pos0{3} = atomic_positions_O1_test_ltt(zeros(1,8));
% O2
pos0{4} = atomic_positions_O2_test_ltt(zeros(1,3));
% O3
pos0{5} = atomic_positions_O3_test_ltt(zeros(1,14));
% Ba
% pos0{6} = atomic_positions_Ba_test_ltt(zeros(1,14));

% La
pos{1} = atomic_positions_La_test_ltt(pars(4:17));
% Cu
pos{2} = atomic_positions_Cu_test_ltt(pars(18:22));
% O1
pos{3} = atomic_positions_O1_test_ltt(pars(23:30));
% O2
pos{4} = atomic_positions_O2_test_ltt(pars(31:33));
% O3
pos{5} = atomic_positions_O3_test_ltt(pars(34:47));
% Ba
% pos{6} = atomic_positions_Ba_test_ltt(pars(48:61));

leg = {'La/Ba' ;'Cu' ;'O1' ;'O2' ;'O3' ;'a_{super}';'b_{super}';'c_{super}'};
%%%%%%% start supercell distortions plot %%%%%%%%
% magnify=2e3; % scaling factor for displacements
magnify=2e1; % scaling factor for displacements
scale=1; % scaling factor for atomic size

ll=length(pos);
sl=zeros(1,ll);
for idx=1:ll
   sl(idx)=size(pos{idx},1); 
end

figure(30)
clf
dime(20,20) % dimension of the window in ~cm
% plot atom positions
hold on
for idx=1:ll
lg(idx)=scatter3(pos{idx}(:,1)*aa,pos{idx}(:,2)*bb,pos{idx}(:,3)*cc,...
         repmat(asz(idx)*scale,sl(idx),1),repmat(cl(idx,:),sl(idx),1),...
         'filled','MarkerFaceAlpha',0.666);
end
hold off

% plot displacement vector
hold on
for idx=1:ll
quiver3(pos{idx}(:,1)*aa,pos{idx}(:,2)*bb,pos{idx}(:,3)*cc, ...
       (pos{idx}(:,1)-pos0{idx}(:,1))*aa*magnify, ...
       (pos{idx}(:,2)-pos0{idx}(:,2))*bb*magnify, ...
       (pos{idx}(:,3)-pos0{idx}(:,3))*cc*magnify, ...
       0,'k','LineWidth',2,'ShowArrowHead','on');
end
hold off
view([-47 23])
axis equal
axis off

% plot unit cell box
np=100;
lw=1;
points=0:1/np:1;
z=zeros(np+1,1);
ccc=cc;
hold on
lg(idx+1)=plot3(points*aa,z,z,'-','LineWidth',lw*3,'color',[0.9 0.05 0.03]);
lg(idx+2)=plot3(z,points*bb,z,'-','LineWidth',lw*3,'color',[0.02 0.7 0.01]);
lg(idx+3)=plot3(z,z,points*ccc,'-','LineWidth',lw*3,'color',[0.06 0.05 0.9]);

plot3(points*aa,z+bb,z,'-k','LineWidth',lw);
plot3(points*aa,z,z+ccc,'-k','LineWidth',lw);
plot3(points*aa,z+bb,z+ccc,'-k','LineWidth',lw);
plot3(z+aa,points*bb,z,'-k','LineWidth',lw);
plot3(z,points*bb,z+ccc,'-k','LineWidth',lw);
plot3(z+aa,points*bb,z+ccc,'-k','LineWidth',lw);
plot3(z+aa,z,points*ccc,'-k','LineWidth',lw);
plot3(z,z+bb,points*ccc,'-k','LineWidth',lw);
plot3(z+aa,z+bb,points*ccc,'-k','LineWidth',lw);
hold off

legend(lg,leg), legend box off
title(plot_title,'interpreter','latex','fontsize',20)
if saveflag; savepng(plot_fullpath,[plot_name,'_','distortions_supercell'],500); end
%%%%%%% end supercell distortions plot %%%%%%%


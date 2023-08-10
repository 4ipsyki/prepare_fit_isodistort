
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


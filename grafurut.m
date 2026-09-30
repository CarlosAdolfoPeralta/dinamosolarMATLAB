function grafurut(ur,utit,tipo)
% Compara componentes del flujo meridional o del campo poloidal.
global rtope

if nargin<3
	tipo='velocidad';
end

if strcmpi(tipo,'magnetico')
	componentes={'$B_r$','$B_\theta$'};
	titulo='Componentes del campo magnético poloidal';
else
	componentes={'$u_r$','$u_\theta$'};
	titulo='Componentes de la perturbación a la velocidad meridional';
end

figure('Color','w','Units','inches','Position',[1 1 14 7])
layout=tiledlayout(1,2,'TileSpacing','loose','Padding','loose');
[x,y]=creaxyb;
campos={ur,utit};
for k=1:2
	ax=nexttile(layout,k);
	pcolor(ax,x/rtope,y/rtope,campos{k})
	shading(ax,'interp')
	axis(ax,'equal')
	xlim(ax,[0 1])
	ylim(ax,[-1 1])
	xlabel(ax,'$x/r_{\rm tope}$','Interpreter','latex')
	ylabel(ax,'$y/r_{\rm tope}$','Interpreter','latex')
	h=title(ax,componentes{k},'Interpreter','latex');
	h.Units='normalized';
	position=h.Position;
	position(2)=1.16;
	h.Position=position;
	cb=colorbar(ax,'eastoutside');
	cb.Ruler.Exponent=0;
	cb.Ruler.TickLabelFormat='%.2e';
end
sgtitle(titulo)

end
function grafico(var1,var2,var3, var4, var5,var6,name)


figure('Position',[100 100 1000 1200])
mar=nargin-1;

[x, y]=creaxyb;
t=1;
x=x/max(max(x));
y=y/max(max(y));
subplot(mar/2,2,t)
pcolor(x,y,var1(:,:))
shading 'interp';
colorbar('location','eastoutside');
str=name(t);
title(str,'Interpreter','latex');
% hold on;
% [npuntosx npuntosy]= size(x);
% npun=npuntosx*npuntosy;
% x2=reshape(x,npun,1);
% y2=reshape(y,npun,1);
% scatter(x2,y2);

if(t < mar)
     t=2;
    subplot(mar/2,2,t)
    pcolor(x,y,var2(:,:))
    shading 'interp';
    colorbar('location','eastoutside');
    str=name(t);
    title(str,'Interpreter','latex');
   
    if(t < mar)
         t=3;
        subplot(mar/2,2,t)
        pcolor(x,y,var3(:,:))
        shading 'interp';
        colorbar('location','eastoutside');
       str=name(t);
        title(str,'Interpreter','latex');
        if(t < mar)
             t=4;
            subplot(mar/2,2,t)
            pcolor(x,y,var4(:,:))
            shading 'interp';
            colorbar('location','eastoutside');
            str=name(t);
            title(str,'Interpreter','latex');
            if(t < mar)
                t=5;
                subplot(mar/2,2,t)
                pcolor(x,y,var5(:,:))
                shading 'interp';
                colorbar('location','eastoutside');
                 str=name(t);
               title(str,'Interpreter','latex');
                if(t < mar)
                t=6;
                subplot(mar/2,2,t)
                pcolor(x,y,var6(:,:))
                shading 'interp';
                colorbar('location','eastoutside');
                str=name(t);
                title(str,'Interpreter','latex');
                end
            end
        end
    end
end

   




end
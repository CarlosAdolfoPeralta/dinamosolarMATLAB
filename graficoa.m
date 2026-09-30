function graficoa(var1,var2,var3, var4, var5,var6,name)


%figure
figure('Position',[100 100 1000 1200])

nar=nargin-1;
[x, y]=creaxyb;
t=1;
x=x/max(max(x));
y=y/max(max(y));
subplot(nar/2,2,t)
contour(x,y,var1(:,:))
colorbar('location','eastoutside');
str=name(t);
title (str);
% hold on;
% [npuntosx npuntosy]= size(x);
% npun=npuntosx*npuntosy;
% x2=reshape(x,npun,1);
% y2=reshape(y,npun,1);
% scatter(x2,y2);

if(t < nar)
     t=2;
    subplot(nar/2,2,t)
    pcolor(x,y,var2(:,:))
    shading 'interp';
    colorbar('location','eastoutside');
    str=name(t);
    title (str);
   
    if(t < nar)
         t=3;
        subplot(nar/2,2,t)
        pcolor(x,y,var3(:,:))
        shading 'interp';
        colorbar('location','eastoutside');
       str=name(t);
        title (str);
        if(t < nar)
             t=4;
            subplot(nar/2,2,t)
            pcolor(x,y,var4(:,:))
            shading 'interp';
            colorbar('location','eastoutside');
            str=name(t);
            title (str);
            if(t < nar)
                t=5;
                subplot(nar/2,2,t)
                pcolor(x,y,var5(:,:))
                shading 'interp';
                colorbar('location','eastoutside');
                 str=name(t);
                title (str);
                if(t < nar)
                t=6;
                subplot(nar/2,2,t)
                pcolor(x,y,var6(:,:))
                shading 'interp';
                colorbar('location','eastoutside');
                str=name(t);
                title (str);
                end
            end
        end
    end
end

   




end
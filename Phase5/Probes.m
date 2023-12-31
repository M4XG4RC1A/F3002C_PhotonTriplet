size = 400;
dl = 0.0025;

% Linear vectors
lph = linspace(phlph-dl,phlph+dl,size);
wph = (2*pi*3*10^8)./lph;
mlph = phlph;
mwph = (2*pi*3*10^8)./mlph;
[WPHX,WPHY] = meshgrid(wph,wph);

L = 0.01e6;

L = 0.01e6;

size = 100;

dl = 0.1;

sigma = 0.1e8;
dw = 24e12;
l0 = phlp;
w0 = 2*pi*3*10^8/l0;

PNL = 0;
dkrsi = wgSuperior.kwFun(WPHX+WPHY+mwph)-wgFundamental.kwFun(WPHX)-wgFundamental.kwFun(WPHY)-wgFundamental.kwFun(mwph)+PNL;
fpm = sinc(L.*dkrsi./2).*exp(1i*L.*dkrsi./2);
fpm2 = (sin(L.*dkrsi.*pi)./(L.*dkrsi.*pi)).*exp(1i*L.*dkrsi./2);

%JSI = ((2^(1/4))/(pi^(1/4)*sqrt(sigma))*exp(-((WPHX+WPHY+mwph-w0).^2)/(sigma.^2))).*...
%    (sinc(L.*(wgSuperior.kwFun(WPHX+WPHY+mwph)-wgFundamental.kwFun(WPHX)-wgFundamental.kwFun(WPHY)-wgFundamental.kwFun(mwph)+PNL)./2).*...
%    exp(1i*L.*(wgSuperior.kwFun(WPHX+WPHY+mwph)-wgFundamental.kwFun(WPHX)-wgFundamental.kwFun(WPHY)-wgFundamental.kwFun(mwph)+PNL)./2));


%pcolor(lph,lph,sin(dkrsi.*pi)./(dkrsi.*pi)), shading interp
%pcolor(lph,lph,abs(exp(1i.*dkrsi/2)).^2), shading interp
%pcolor(lph,lph,abs((sin(dkrsi.*pi)./(dkrsi.*pi)).*exp(1i.*dkrsi/2)).^2), shading interp
pcolor(lph,lph,abs(fpm).^2), shading interp
colormap(jet);
colorbar

%%
close all

size = 200;

dl = 0.0005;
dl = 0.05;
dl = 0.006;

% Linear vectors
lph = linspace(phlph-dl,phlph+dl,size);
wph = (2*pi*3*10^8)./lph;
mlph = phlph;
mwph = (2*pi*3*10^8)./mlph;
[WPHX,WPHY] = meshgrid(wph,wph);

sigma = 0.01e12;
lp0 = phlp;
wp0 = 2*pi*3*10^8/lp0;

L = 0.01e6;
L = 0.2e6;

%sigma = sigma/10;
%L = L*20;

ca = 2^(1/4)/(pi^(1/4)*sigma);
wpw0 = (WPHX+WPHY+mwph-wp0)*10^6;
awp = ca*exp(-(wpw0).^2/sigma^2);

dkrsi = wgSuperior.kwFun(WPHX+WPHY+mwph)-wgFundamental.kwFun(WPHX)-wgFundamental.kwFun(WPHY)-wgFundamental.kwFun(mwph)+PNL;
sinPh = sinc(L*dkrsi/2);
expPh = exp(1i*L*dkrsi/2);
fpm = sinPh.*expPh;

JSI = awp.*fpm;

figure
pcolor(lph,lph,abs(awp).^2), shading interp
title("a(wp)")
colormap(jet);
figure
pcolor(lph,lph,abs(fpm).^2), shading interp
title("phi(wp)")
colormap(jet);
figure
pcolor(lph,lph,abs(JSI).^2), shading interp
title("JSI")
colormap(jet);
%{
colormap(jet);
set(gcf,'Color',[1,1,1]);
set(gca,'TickDir','out','TickLength',[0.015 0.015]);
set(gca,'FontSize',18,'FontName','arial');
box on
axis square
%}

%%

I2 = 0;

for n = 1:length(wph)-1
    dwi = wph(n)-wph(n+1);

    ca = 2^(1/4)/(pi^(1/4)*sigma);
    wpw0 = (WPHX+WPHY+wph(n)-wp0)*10^6;
    awp = ca*exp(-(wpw0).^2/sigma^2);
    
    dkrsi = wgSuperior.kwFun(WPHX+WPHY+wph(n))-wgFundamental.kwFun(WPHX)-wgFundamental.kwFun(WPHY)-wgFundamental.kwFun(wph(n))+PNL;
    sinPh = sinc(L*dkrsi/2);
    expPh = exp(1i*L*dkrsi/2);
    
    fpm = sinPh.*expPh;

    I2 = I2 + dwi.*fpm;
end

figure
pcolor(lph,lph,abs(I2).^2), shading interp
title("a(wp)")
colormap(jet);

%%
close all

size = 400;

phwph = (2*pi*3*10^8)/phlph;
dw = 4.8e6;%(2*pi*3*10^8)*/phwph-1/(phwph+0.006));

% Linear vectors
wph = linspace(phwph-dw,phwph+dw,size);
mwph = phwph;
[WPHX,WPHY] = meshgrid(wph,wph);

sigma = 0.01e12;
lp0 = phlp;
wp0 = 2*pi*3*10^8/lp0;

L = 0.2e6;

L = L;
sigma = sigma*10;

ca = 2^(1/4)/(pi^(1/4)*sigma);
wpw0 = (WPHX+WPHY+mwph-wp0)*10^6;
awp = ca*exp(-(wpw0).^2/sigma^2);

dkrsi = wgSuperior.kwFun(WPHX+WPHY+mwph)-wgFundamental.kwFun(WPHX)-wgFundamental.kwFun(WPHY)-wgFundamental.kwFun(mwph)+PNL;
sinPh = sinc(L*dkrsi/2);
expPh = exp(1i*L*dkrsi/2);
fpm = sinPh.*expPh;

JSI = awp.*fpm;

figure
pcolor((2*pi*3*10^8)./wph,(2*pi*3*10^8)./wph,abs(awp).^2), shading interp
title("a(wp)")
colormap(jet);
figure
pcolor((2*pi*3*10^8)./wph,(2*pi*3*10^8)./wph,abs(fpm).^2), shading interp
title("phi(wp)")
colormap(jet);
figure
pcolor((2*pi*3*10^8)./wph,(2*pi*3*10^8)./wph,abs(JSI).^2), shading interp
title("JSI")
colormap(jet);
%{
colormap(jet);
set(gcf,'Color',[1,1,1]);
set(gca,'TickDir','out','TickLength',[0.015 0.015]);
set(gca,'FontSize',18,'FontName','arial');
box on
axis square
%}

%%

I2 = 0;
dwi = wph(2)-wph(1);

for n = 1:length(wph)-1
    ca = 2^(1/4)/(pi^(1/4)*sigma);
    wpw0 = (WPHX+WPHY+wph(n)-wp0)*10^6;
    awp = ca*exp(-(wpw0).^2/sigma^2);
    
    dkrsi = wgSuperior.kwFun(WPHX+WPHY+wph(n))-wgFundamental.kwFun(WPHX)-wgFundamental.kwFun(WPHY)-wgFundamental.kwFun(wph(n))+PNL;
    sinPh = sinc(L*dkrsi/2);
    expPh = exp(1i*L*dkrsi/2);
    
    fpm = sinPh.*expPh;

    I2 = I2 + dwi.*fpm;
end

figure
pcolor((2*pi*3*10^8)./wph,(2*pi*3*10^8)./wph,abs(I2).^2), shading interp
title("I_2")
colormap(gray);
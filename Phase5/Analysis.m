%% Data
%Sizes
sXs = [727.778,883.333,922.222,883.333,1000,1000,922.222];
sYs = [1000,850,1000,900,850,750,800];

%Sizes
Guides = [1:7];

%Paths
SuperiorPath = "./../Fase4/Sweeps/Matlab/";
FundamentalPath = "./../Fase3/Sweeps/Matlab/";

%Modes
Superior = "Waveguide%i_%i_1580_Mode%i";
Fundamental = "Waveguide%i_%i_1580";

%% Create waveguides fundamental mode

%Import data
wgFundamental = [];

for wg = Guides
    file = sprintf(Fundamental,sXs(wg)*1000,sYs(wg)*1000);
    load(FundamentalPath+file);
    
    wgFundamental = [wgFundamental waveguide(lambda,neff)];
end

%% Create waveguides superior mode

%Import data
wgSuperior = [];

for wg = Guides
    modeSuperior = 3;
    
    file = sprintf(Superior,sXs(wg)*1000,sYs(wg)*1000,modeSuperior);
    load(SuperiorPath+file);

    wgSuperior = [wgSuperior waveguide(lambda,neff)];
end

wg = 3;
modeSuperior = 4;
    
file = sprintf(Superior,sXs(wg)*1000,sYs(wg)*1000,modeSuperior);
load(SuperiorPath+file);

wgSuperior3 = waveguide(lambda,neff);

%% Phasematching

wgNum = 1;

pSize = 10;

% Conditions
    % wp = wi+ws+wr
    % ks(wp) = kf(wi)+kf(ws)+kf(wr)
    % Pump 1550-1580

%Ejemplo 2wp = ws+wi
lp = linspace(1.55,1.58,pSize);
wp = 2*pi*3*10^8./lp;
ls = linspace(0.51,1.58,1000);
ws = 2*pi*3*10^8./ls;
li = linspace(0.51,1.58,1000);
wi = 2*pi*3*10^8./li;

disp(2*pi*3*10^8./(max(wp)/3))
disp(2*pi*3*10^8./(min(wp)/3))
disp(max(ws))
disp(min(ws))

[w_S,w_I] = meshgrid(ws,wi);

i = 1;%1:pSize;
w_R = wp(i)-w_S-w_I;
DK = wgSuperior(wgNum).kwFun(wp(i)) - wgSuperior(wgNum).kwFun(w_S) ...
    - wgSuperior(wgNum).kwFun(w_S) - wgSuperior(wgNum).kwFun(w_R);
DK(w_R<0) = NaN;

[l_P,l_S] = meshgrid(lp,ls);
l_I = 1./(2./l_P-1./l_S)

kp
ks
ki

DK = kp+kp-ks-ki-1e-6;

figure
hold on
contour(lp,ls,DK,[0 0],'b','LineWidth',2);

%% Group velocity matching conditions

%we search that one tau equal zero(multiplica por L)
t_s = kprima(l_P)-kprima(l_S);
t_l = kprima(l_P)-kprima(l_S);

figure
hold on
contour(lp,ls,DK,[0 0],'b','LineWidth',2);
contour(lp,ls,t_i,t_s,[0 0],'k','LineWidth',2);
set(gcf,'Color',[1 1 1]);
set(gca,'TickDir','out','TickLength',[0.015 0.015]);
set(gca,'FontSize',18,'FontName','arial');
box on
axis square

%% Calculate JSA

%Source parametyers
L = 0.02e6; %micras
sigma = 3e12; %Ancho de banda de bombeo THz
l0 = 0.8; %Central wavelength


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

%% GetData Fundamental

for wg = Guides
    file = sprintf(Fundamental,sXs(wg)*1000,sYs(wg)*1000);
    load(FundamentalPath+file);
    
    figure
    hold on
    title("Fundamental Waveguide "+string(wg));
    plot(lambda,neff);
end

%% GetData Superior

for wg = Guides
    modeSuperior = 3;
    
    file = sprintf(Superior,sXs(wg)*1000,sYs(wg)*1000,modeSuperior);
    load(SuperiorPath+file);

    figure
    hold on
    title("Superior Waveguide "+string(wg)+" Mode 3");
    plot(lambda,neff);
end

wg = 3;
modeSuperior = 3;
    
file = sprintf(Superior,sXs(wg)*1000,sYs(wg)*1000,modeSuperior);
load(SuperiorPath+file);

figure
hold on
title("Superior Waveguide "+string(wg)+" Mode 4");
plot(lambda,neff);

%% Probes

%Import data
wg = 1;
file = sprintf(Fundamental,sXs(wg)*1000,sYs(wg)*1000);
load(FundamentalPath+file);
neffVals = neff;
lambdaVals = lambda;

%Create neff(l)
[neffInd,S] = polyfit(lambdaVals,neffVals,30)

figure
hold on
plot(lambdaVals,neffVals,'o')
plot(lambdaVals,polyval(neffInd,lambdaVals))

%% Fundamental Conversion

gradePol = 30;

%Import data
wg = 1;
file = sprintf(Fundamental,sXs(wg)*1000,sYs(wg)*1000);
load(FundamentalPath+file);
nefflVals = neff;
lambdaVals = lambda;



%Create neff(l)
[nefflInd,S] = polyfit(lambdaVals,nefflVals,gradePol);
if nefflInd(end)>0
    func = sprintf("+%.30f",nefflInd(end));
elseif neffInd(end)<0
    func = sprintf("%.30f",nefflInd(end));
else
    func="";
end

for i = 1:gradePol
    if nefflInd(end-i)>0
        if i~=gradePol
            func = sprintf("+%.30f*l.^%i",nefflInd(end-i),i)+func;
        else
            func = sprintf("%.30f*l.^%i",nefflInd(end-i),i)+func;
        end
    elseif nefflInd(end-i)<0
        func = sprintf("%.30f*l.^%i",nefflInd(end-i),i)+func;
    end
end
disp("neff(\lambda)");
disp(func);
nefflFunc = str2func("@(l)"+func);
nefflStr = "neff(\lambda)";

figure
hold on
title("neff(\lambda)")
plot(lambdaVals,nefflVals,'o')
%plot(lambdaVals,polyval(nefflInd,lambdaVals))
plot(lambdaVals,nefflFunc(lambdaVals))



%Create k(l)
klFunc = @(l)2*pi*nefflFunc(l)./l;
klStr = sprintf("2*pi*(%s)./l",nefflStr);

disp("k(\lambda)");
disp(klFunc);

figure
hold on
title("k(\lambda)")
plot(lambdaVals,klFunc(lambdaVals))



%Create dk/dl
[nefflInd,S] = polyfit(lambdaVals,nefflVals,gradePol);
if nefflInd(end)*-1>0
    func = sprintf("+%.30f*l.^%i",nefflInd(end)*-1,-2);
elseif neffInd(end)*-1<0
    func = sprintf("%.30f*l.^%i",nefflInd(end)*-1,-2);
else
    func="";
end

for i = 2:gradePol
    if nefflInd(end-i)>0
        if i~=gradePol
            func = sprintf("+%.30f*l.^%i",nefflInd(end-i)*(i-1),i-2)+func;
        else
            func = sprintf("%.30f*l.^%i",nefflInd(end-i)*(i-1),i-2)+func;
        end
    elseif nefflInd(end-i)<0
        func = sprintf("%.30f*l.^%i",nefflInd(end-i)*(i-1),i-2)+func;
    end
end
func = "2*pi*("+func+")";
disp("dk/d\lambda");
disp(func);
dkdlFunc = str2func("@(l)"+func);
dkdlStr = func;

figure
hold on
title("dk/d\lambda")
%plot(lambdaVals,nefflVals,'o')
%plot(lambdaVals,polyval(nefflInd,lambdaVals))
plot(lambdaVals,dkdlFunc(lambdaVals))



%Transform dk/dw
c = 3*10^8; %m/s
dkdwStr = sprintf("-l.^2/(2*pi*3*10^8).*(%s)",dkdlStr);
dkdwFunc = str2func("@(l)"+dkdwStr);

disp("dk/d\omega");
disp(dkdwStr);

figure
hold on
title("dk/d\omega")
%plot(lambdaVals,nefflVals,'o')
%plot(lambdaVals,polyval(nefflInd,lambdaVals))
plot(lambdaVals,dkdwFunc(lambdaVals))



%Create Vg
vgStr = sprintf("1./(%s)",dkdwStr);
vgFun = str2func("@(l)"+vgStr);

disp("V_g");
disp(vgFun);

figure
hold on
title("V_g")
%plot(lambdaVals,nefflVals,'o')
%plot(lambdaVals,polyval(nefflInd,lambdaVals))
plot(lambdaVals,vgFun(lambdaVals))

%Create d2k/dw2


%Create D


%Compare D and dispersion


%Calculate 0 Dispersion


%Phase Matching


%% Probes 2
gradePol = 30;

%Import data
wg = 1;
file = sprintf(Fundamental,sXs(wg)*1000,sYs(wg)*1000);
load(FundamentalPath+file);
nefflVals = neff;
lambdaVals = lambda;



%Create neff(w)
omegas = 2*pi*3*10^8./(lambdaVals);
[nefflInd,S] = polyfit(omegas,nefflVals,gradePol);
if nefflInd(end)>0
    func = sprintf("+%.30e",nefflInd(end));
elseif neffInd(end)<0
    func = sprintf("%.30e",nefflInd(end));
else
    func="";
end

for i = 1:gradePol
    if nefflInd(end-i)>0
        if i~=gradePol
            func = sprintf("+%.30e*w.^%i",nefflInd(end-i),i)+func;
        else
            func = sprintf("%.30e*w.^%i",nefflInd(end-i),i)+func;
        end
    elseif nefflInd(end-i)<0
        func = sprintf("%.30e*w.^%i",nefflInd(end-i),i)+func;
    end
end
disp("neff(\omega)");
disp(func);
neffwS = func
nefflFunc = str2func("@(w)"+func);

figure
hold on
title("neff(\omega)")
omegas = 2*pi*3*10^8./(lambdaVals);
plot(omegas,nefflVals,'o')
%plot(lambdaVals,polyval(nefflInd,lambdaVals))
plot(omegas,nefflFunc(omegas))


%% Using object

%Import data
wg = 1;
file = sprintf(Fundamental,sXs(wg)*1000,sYs(wg)*1000);
load(FundamentalPath+file);
nefflVals = neff;
lambdaVals = lambda;

wg1 = waveguide(lambdaVals,neffVals);

wg1.plotl("neff",lambdaVals)
wg1.plotl("k",lambdaVals)
wg1.plotl("dkdl",lambdaVals)
wg1.plotl("dkdw",lambdaVals)
wg1.plotl("vg",lambdaVals)

omegaVals = 2*pi*3*10^8./lambdaVals;

wg1.plotw("neff",omegaVals)
wg1.plotw("k",omegaVals)
wg1.plotw("dkdw",omegaVals)
wg1.plotw("vg",omegaVals)
wg1.plotw("d2kdw2",omegaVals)

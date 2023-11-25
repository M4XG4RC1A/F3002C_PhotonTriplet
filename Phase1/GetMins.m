
%% getmodes
clc;

%650-1000, 100-325
Xs = round(linspace(650,1000,11)*1000);
Ys = round(linspace(100,325,6)*1000);

lenX = length(Xs);
lenY = length(Ys);

%Get 
minAreaEffective = [100,0,0];
minArea = [100,0,0];
minVert = [100, 0, 0];
minHor = [100, 0, 0];
minVertArea = [100, 0, 0];
minHorArea = [100, 0, 0];
for y = Ys
        for x=Xs
            load("./nModes/Waveguide"+string(x)+"_"+string(y)+"_1596.mat");
            if nmodes == 1
                if minAreaEffective(1)>Aeff(1)*1e12
                    minAreaEffective(1) = Aeff(1)*1e12;
                    minAreaEffective(2) = x/1000;
                    minAreaEffective(3) = y/1000;
                end
                if minArea(1)>x*y/(1000000*1000000)
                    minArea(1) = x*y/(1000000*1000000);
                    minArea(2) = x/1000;
                    minArea(3) = y/1000;
                end
                if x>y
                    if minHor(1)>Aeff(1)*1e12
                        minHor(1) = Aeff(1)*1e12;
                        minHor(2) = x/1000;
                        minHor(3) = y/1000;
                    end
                    if minHorArea(1)>x*y/(1000000*1000000)
                        minHorArea(1) = x*y/(1000000*1000000);
                        minHorArea(2) = x/1000;
                        minHorArea(3) = y/1000;
                    end
                elseif y>x
                    if minVert(1)>Aeff(1)*1e12
                        minVert(1) = Aeff(1)*1e12;
                        minVert(2) = x/1000;
                        minVert(3) = y/1000;
                    end
                    if minVertArea(1)>x*y/(1000000*1000000)
                        minVertArea(1) = x*y/(1000000*1000000);
                        minVertArea(2) = x/1000;
                        minVertArea(3) = y/1000;
                    end
                end
            end
        end
end


%475-650, 325-550
Xs = round(linspace(475,650,6)*1000);
Ys = round(linspace(325,550,6)*1000);

lenX = length(Xs);
lenY = length(Ys);
for y = Ys
        for x=Xs
            load("./nModes/Waveguide"+string(x)+"_"+string(y)+"_1596.mat");
            if nmodes == 1
                if minAreaEffective(1)>Aeff(1)*1e12
                    minAreaEffective(1) = Aeff(1)*1e12;
                    minAreaEffective(2) = x/1000;
                    minAreaEffective(3) = y/1000;
                end
                if minArea(1)>x*y/(1000000*1000000)
                    minArea(1) = x*y/(1000000*1000000);
                    minArea(2) = x/1000;
                    minArea(3) = y/1000;
                end
                if x>y
                    if minHor(1)>Aeff(1)*1e12
                        minHor(1) = Aeff(1)*1e12;
                        minHor(2) = x/1000;
                        minHor(3) = y/1000;
                    end
                    if minHorArea(1)>x*y/(1000000*1000000)
                        minHorArea(1) = x*y/(1000000*1000000);
                        minHorArea(2) = x/1000;
                        minHorArea(3) = y/1000;
                    end
                elseif y>x
                    if minVert(1)>Aeff(1)*1e12
                        minVert(1) = Aeff(1)*1e12;
                        minVert(2) = x/1000;
                        minVert(3) = y/1000;
                    end
                    if minVertArea(1)>x*y/(1000000*1000000)
                        minVertArea(1) = x*y/(1000000*1000000);
                        minVertArea(2) = x/1000;
                        minVertArea(3) = y/1000;
                    end
                end
            end
        end
end


%300-475, 550-1000
Xs = round(linspace(300,475,6)*1000);
Ys = round(linspace(550,1000,11)*1000);

lenX = length(Xs);
lenY = length(Ys);

for y = Ys
        for x=Xs
            load("./nModes/Waveguide"+string(x)+"_"+string(y)+"_1596.mat");
            if nmodes == 1
                if minAreaEffective(1)>Aeff(1)*1e12
                    minAreaEffective(1) = Aeff(1)*1e12;
                    minAreaEffective(2) = x/1000;
                    minAreaEffective(3) = y/1000;
                end
                if minArea(1)>x*y/(1000000*1000000)
                    minArea(1) = x*y/(1000000*1000000);
                    minArea(2) = x/1000;
                    minArea(3) = y/1000;
                end
                if x>y
                    if minHor(1)>Aeff(1)*1e12
                        minHor(1) = Aeff(1)*1e12;
                        minHor(2) = x/1000;
                        minHor(3) = y/1000;
                    end
                    if minHorArea(1)>x*y/(1000000*1000000)
                        minHorArea(1) = x*y/(1000000*1000000);
                        minHorArea(2) = x/1000;
                        minHorArea(3) = y/1000;
                    end
                elseif y>x
                    if minVert(1)>Aeff(1)*1e12
                        minVert(1) = Aeff(1)*1e12;
                        minVert(2) = x/1000;
                        minVert(3) = y/1000;
                    end
                    if minVertArea(1)>x*y/(1000000*1000000)
                        minVertArea(1) = x*y/(1000000*1000000);
                        minVertArea(2) = x/1000;
                        minVertArea(3) = y/1000;
                    end
                end
            end
        end
end

%Min for area
disp("Min areas");
disp("Min Effective Area: "+num2str(minAreaEffective(1)));
disp("     X: "+num2str(minAreaEffective(2)));
disp("     Y: "+num2str(minAreaEffective(3)));
disp("Min Area: "+num2str(minArea(1)));
disp("     X: "+num2str(minArea(2)));
disp("     Y: "+num2str(minArea(3)));
disp("------------------------");

%Min for Vertical
disp("Min Vertical");
disp("Min Effective Area: "+num2str(minVert(1)));
disp("     X: "+num2str(minVert(2)));
disp("     Y: "+num2str(minVert(3)));
disp("Min Area: "+num2str(minVertArea(1)));
disp("     X: "+num2str(minVertArea(2)));
disp("     Y: "+num2str(minVertArea(3)));
disp("------------------------");

%Min for horizontal
disp("Min Horizontal");
disp("Min Effective Area: "+num2str(minHor(1)));
disp("     X: "+num2str(minHor(2)));
disp("     Y: "+num2str(minHor(3)));
disp("Min Area: "+num2str(minHorArea(1)));
disp("     X: "+num2str(minHorArea(2)));
disp("     Y: "+num2str(minHorArea(3)));
disp("------------------------");


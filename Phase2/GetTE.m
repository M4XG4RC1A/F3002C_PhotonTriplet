sXs = [1000,930,475,405];
sYs = [325,235,955,730];

for i = 1:4
    x = sXs(i)*1000;
    y = sYs(i)*1000;
    load("./nModes/Waveguide"+string(x)+"_"+string(y)+"_1596.mat");
    disp(i)
    disp(overlapTE.fraction)
end
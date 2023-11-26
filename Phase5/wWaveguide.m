classdef wWaveguide < handle
    properties
        gradePol = 30
        lambdaData
        omegaData
        neffData
        %% Base w
        neffwFun
        neffwStr
        kwFun
        kwStr
        dkwdwFun
        dkwdwStr
        vgwFun
        vgwStr
        d2kwdw2Fun
        d2kwdw2Str
        DwFun
        DwStr
    end
    methods
        function obj = wWaveguide(lambda,neff)
            %Load Data values
            obj.lambdaData = lambda;
            obj.neffData = neff;
            obj.omegaData = 2.*pi.*3.*10.^8./lambda; %6e14
            
            %% Base w
            %Create neff(w)
            [neffwInd,S] = polyfit(obj.omegaData,obj.neffData,obj.gradePol);
            
            if neffwInd(end)>0
                func = sprintf("+%.30f",neffwInd(end));
            elseif neffwInd(end)<0
                func = sprintf("%.30f",neffwInd(end));
            else
                func="";
            end
            for i = 1:obj.gradePol
                if neffwInd(end-i)>0
                    if i~=obj.gradePol
                        func = sprintf("+%.30e*w.^%i",neffwInd(end-i),i)+func;
                    else
                        func = sprintf("%.30e*w.^%i",neffwInd(end-i),i)+func;
                    end
                elseif neffwInd(end-i)<0
                    func = sprintf("%.30e*w.^%i",neffwInd(end-i),i)+func;
                end
            end
            func
            %{
            obj.neffwFun = str2func("@(w)"+func);
            obj.neffwStr = func;

            %Create k(w)
            obj.kwStr = sprintf("w.*(%s)./(3*10^8)",obj.neffwStr);
            obj.kwFun = @(w)w.*(obj.neffwFun(w))./(3*10^8);

            %Create dk/dw
            [neffdwInd,S] = polyfit(obj.omegaData,obj.neffData,obj.gradePol);
            if neffdwInd(end)>0
                func = sprintf("+%.30f",neffdwInd(end));
            elseif neffdwInd(end)<0
                func = sprintf("%.30f",neffdwInd(end));
            else
                func="";
            end
            for i = 1:obj.gradePol
                if neffdwInd(end-i)>0
                    if i~=obj.gradePol
                        func = sprintf("+%.30e*w.^%i*(%i)",neffdwInd(end-i),i,i+1)+func;
                    else
                        func = sprintf("%.30e*w.^%i*(%i)",neffdwInd(end-i),i,i+1)+func;
                    end
                elseif neffdwInd(end-i)<0
                    func = sprintf("%.30e*w.^%i*(%i)",neffdwInd(end-i),i,i+1)+func;
                end
            end
            obj.dkwdwStr = "("+func+")./(3*10^8)";
            obj.dkwdwFun = str2func("@(w)"+obj.dkwdwStr);

            %Create Vg
            obj.vgwStr = "(3*10^8)./("+func+")";
            obj.vgwFun = str2func("@(w)"+obj.vgwStr);

            %Create d2k/dw2
            if neffdwInd(end-1)>0
                func = sprintf("+%.30f*(%i)",neffdwInd(end-1),2);
            elseif neffdwInd(end-1)<0
                func = sprintf("%.30f*(%i)",neffdwInd(end-1),2);
            else
                func="";
            end
            for i = 2:obj.gradePol
                if neffdwInd(end-i)>0
                    if i~=obj.gradePol
                        func = sprintf("+%.30e*w.^%i*(%i)",neffdwInd(end-i),i-1,i*(i+1))+func;
                    else
                        func = sprintf("%.30e*w.^%i*(%i)",neffdwInd(end-i),i-1,i*(i+1))+func;
                    end
                elseif neffdwInd(end-i)<0
                    func = sprintf("%.30e*w.^%i*(%i)",neffdwInd(end-i),i-1,i*(i+1))+func;
                end
            end
            obj.d2kwdw2Str = "("+func+")./(3*10^8)";
            obj.d2kwdw2Fun = str2func("@(w)"+obj.d2kwdw2Str);

            %Create Dispersion
            obj.DwStr = "-(w.^2/(2*pi*3*10^8)).*("+obj.d2kwdw2Str+")";
            obj.DwFun = str2func("@(w)"+obj.DwStr);
            %}
        end

        function showData(obj)
            %Base w Functions
            disp("");
            disp("  Base w");
            %neff(w)
            disp("neff(w)");
            disp(obj.neffwStr);
            %k(w)
            disp("k(w)");
            disp(obj.kwStr);
            %dk(w)/dw
            disp("dk(w)/dw");
            disp(obj.dkwdwStr);
            %vg(w)
            disp("Vg(w)");
            disp(obj.vgwStr);
            %d2k(w)/dw2
            disp("d2k(w)/dw2");
            disp(obj.d2kwdw2Str);
        end

        function plotw(obj,typePlot,data)
            xData = data;
            switch typePlot
                case "neff"
                    yData = obj.neffwFun(xData);
                    name = "n_{eff}(\omega)";
                case "k"
                    yData = obj.kwFun(xData);
                    name = "k(\omega)";
                case "dkdw"
                    yData = obj.dkwdwFun(xData);
                    name = "dk(\omega)/d\omega";
                case "vg"
                    yData = obj.vgwFun(xData);
                    name = "V_g(\omega)";
                case "d2kdw2"
                    yData = obj.d2kwdw2Fun(xData);
                    name = "d^2k(\omega)/d\omega^2";
                otherwise
                    yData = xData.*0;
                    name = "No data";
            end
            figure
            hold on
            title(name)
            plot(xData,yData)
        end
    end
end
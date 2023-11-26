classdef waveguide < handle
    properties
        gradePol = 30
        lambdaData
        omegaData
        neffData
        %% Base l
        nefflFun
        nefflStr
        klFun
        klStr
        dkldlFun
        dkldlStr
        dkldwFun
        dkldwStr
        vglFun
        vglStr
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
        function obj = waveguide(lambda,neff)
            %Load Data values
            obj.lambdaData = lambda;
            obj.neffData = neff;
            obj.omegaData = 2.*pi.*3.*10.^8./lambda;
            

            %% Base l
            %Create neff(l)
            [nefflInd,S] = polyfit(obj.lambdaData,obj.neffData,obj.gradePol);
            if nefflInd(end)>0
                func = sprintf("+%.30f",nefflInd(end));
            elseif nefflInd(end)<0
                func = sprintf("%.30f",nefflInd(end));
            else
                func="";
            end
            
            for i = 1:obj.gradePol
                if nefflInd(end-i)>0
                    if i~=obj.gradePol
                        func = sprintf("+%.30f*l.^%i",nefflInd(end-i),i)+func;
                    else
                        func = sprintf("%.30f*l.^%i",nefflInd(end-i),i)+func;
                    end
                elseif nefflInd(end-i)<0
                    func = sprintf("%.30f*l.^%i",nefflInd(end-i),i)+func;
                end
            end
            obj.nefflFun = str2func("@(l)"+func);
            obj.nefflStr = func;

            %Create k(l)
            obj.klFun = @(l)2*pi*obj.nefflFun(l)./l;
            obj.klStr = sprintf("2*pi*(%s)./l",obj.nefflStr);

            %Create dk/dl
            if nefflInd(end)*-1>0
                func = sprintf("+%.30f*l.^%i",nefflInd(end)*-1,-2);
            elseif nefflInd(end)*-1<0
                func = sprintf("%.30f*l.^%i",nefflInd(end)*-1,-2);
            else
                func="";
            end
            
            for i = 2:obj.gradePol
                if nefflInd(end-i)>0
                    if i~=obj.gradePol
                        func = sprintf("+%.30f*l.^%i",nefflInd(end-i)*(i-1),i-2)+func;
                    else
                        func = sprintf("%.30f*l.^%i",nefflInd(end-i)*(i-1),i-2)+func;
                    end
                elseif nefflInd(end-i)<0
                    func = sprintf("%.30f*l.^%i",nefflInd(end-i)*(i-1),i-2)+func;
                end
            end
            func = "2*pi*("+func+")";
            obj.dkldlFun = str2func("@(l)"+func);
            obj.dkldlStr = func;
            
            %Transform dk/dw
            obj.dkldwStr = sprintf("-l.^2/(2*pi*3*10^8).*(%s)",obj.dkldlStr);
            obj.dkldwFun = str2func("@(l)"+obj.dkldwStr);

            %Create Vg
            obj.vglStr = sprintf("1./(%s)",obj.dkldwStr);
            obj.vglFun = str2func("@(l)"+obj.vglStr);
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
        end

        function showData(obj)
            %Base l Functions
            disp("  Base l");
            %neff(l)
            disp("neff(l)");
            disp(obj.nefflStr);
            %k(l)
            disp("k(l)");
            disp(obj.klStr);
            %dk(l)/dl
            disp("dk(l)/dl");
            disp(obj.dkldlStr);
            %dk(l)/dw
            disp("dk(l)/dw");
            disp(obj.dkldwStr);
            %vg(l)
            disp("Vg(l)");
            disp(obj.vglStr);

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

        function plotl(obj,typePlot,data)
            xData = data;
            switch typePlot
                case "neff"
                    yData = obj.nefflFun(xData);
                    name = "n_{eff}(\lambda)";
                case "k"
                    yData = obj.klFun(xData);
                    name = "k(\lambda)";
                case "dkdl"
                    yData = obj.dkldlFun(xData);
                    name = "dk(\lambda)/d\lambda";
                case "dkdw"
                    yData = obj.dkldwFun(xData);
                    name = "dk(\lambda)/d\omega";
                case "vg"
                    yData = obj.vglFun(xData);
                    name = "V_g(\lambda)";
                otherwise
                    yData = xData.*0;
                    name = "No data";
            end
            figure
            hold on
            title(name)
            plot(xData,yData)
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
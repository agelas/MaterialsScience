%Mathias Insley
%%
%calculateEntropy is parent function that returns the entropy of iron at
%a user inputed temperature.
function [entropy] = calculateEntropy(tFinal)
    
    entropyVals = 298:tFinal;
    
    for i=1:length(entropyVals)
        cp_t = calculateCPIron(entropyVals(i));
        entropyVals(i) = cp_t/tFinal;
    end
    
    
%%
%Taken and slightly modifed from homework 2. CaclculateCPIron now just
%returns the specific heat capacity of iron at user specified temperature.
    function cp = calculateCPIron(temperature)
        %Don't know if this is even necessary
        if (temperature == 298)
            cp = 25.09;
        end
        A = [];
        B = [];
        C = [];
        D = [];
        E = [];
        cP = [];
        temp = temperature;
        allotrope = [];
        heatTransform = 0;

        tempRange = 298:temperature; 
        cpVals = 1:max(size(tempRange));

        for j = 1:max(size(cpVals))
            curTemp = tempRange(j);
            if (curTemp < 1042.15)
                allotrope = 'ferroAlpha';
            elseif (curTemp >= 1042.15) && (curTemp < 1183.15)
                allotrope = 'paraAlpha';
                heatTransform = 300;
            elseif (curTemp >= 1183.15) && (curTemp < 1673.15)
                allotrope = 'gamma';
                heatTransform = 400;
            elseif (curTemp >= 1673.15) && (curTemp < 1809.15)
                allotrope = 'delta';
                heatTransform = 500;
            else
                allotrope = 'liquid';
                heatTransform = 3464;
            end
            setVirial(allotrope, curTemp); %checking virial coefficients
            t = tempRange(j)/1000; %updating t
            cpVals(1,j) = A + B*t + C*t^2 + D*t^3 + E*t^-2; %Shomate Equation
        end

        cp = cpVals(end);
        

    %%
        %setVirial sets the virial coefficients based on the phase and 
        %temperature passed in from parent function. Doubly nested
        %function.
        function setVirial(phase, temp)
            if (strcmp('ferroAlpha',phase) || (strcmp('paraAlpha', phase))...
                    || (strcmp('delta', phase)))
                if (temp >= 298) && (temp < 700) 
                    A = 18.42868;
                    B = 24.64301;
                    C = -8.913720;
                    D = 9.664706;
                    E = -0.012643;
                    %fprintf("set1");
                elseif (temp >= 700) && (temp < 1042)
                    A = -57767.65;
                    B = 137919.7;
                    C = -122773.2;
                    D = 38682.42;
                    E = 3993.08;
                elseif (temp >= 1042) && (temp < 1100)
                    A = -325.8859;
                    B = 28.92876;
                    C = 0;
                    D = 0;
                    E = 411.9629;
                elseif (temp >= 1100) && ( temp < 1809)
                    A = -776.7387;
                    B = 919.4005;
                    C = -383.7184;
                    D = 57.08148;
                    E = 242.1369;  
                end
            elseif(strcmp('gamma',phase))
                A = 23.97449;
                B = 8.367750;
                C = 0.000277;
                D = -0.000086;
                E = -0.000005;
            elseif(strcmp('liquid',phase))
                A = 46.02400;
                B = 0;
                C = 0;
                D = 0;
                E = 0;
            end 
        end
    end

end
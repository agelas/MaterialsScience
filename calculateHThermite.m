%Mathias Insley
%%
%calculateH is parent function which takes temperature as input, plots 
%specific heat capacity as a function of temperature, returns H. Inputs are
%the temperature and whether you want to plot a graph of the specific heat
%capacities. 
function [hematiteH, aluminumH, alOH] = calculateHThermite(temperature, plotGraph)
    if (temperature == 298)
        hematiteH = 0;
        aluminumH = 0;
        alOH = 0;
    end
    A = [];
    B = [];
    C = [];
    D = [];
    E = [];
    
    temp = temperature;
    
    %Allotropes at 298K. We can disregard hematite because it only has one
    %allotrope for this scenario.
    allotropeAl2O3 = 'alpha';
    allotropeAl = 'solid';
    
    if (temp > 933)
        heatFusionAl = 10560; %For transition from solid Al to liquid Al
    else
        heatFusionAl = 0;
    end
    
    tempRange = 298:temperature; 
    range = max(size(tempRange));
    cpValsAl2O3 = 1:range;
    cpValsFe2O3 = 1:range;
    cpValsAl = 1:range;
    
    for i = 1:range
        curTemp = tempRange(i);
        
        if (curTemp > 2327) && (curTemp < 4000)
            %fprintf("debug");
            allotropeAl2O3 = 'liquid';
        end
        
        if (curTemp > 933)
            allotropeAl = 'liquid';
        end
        %allotrope;
        t = tempRange(i)/1000; %updating t  
        
        setVirialFe2O3(curTemp);
        cpValsFe2O3(1,i) = A + B*t + C*t^2 + D*t^3 + E*t^-2;
        
        setVirialAl(allotropeAl)
        cpValsAl(1,i) = A + B*t + C*t^2 + D*t^3 + E*t^-2;
        
        setVirialAl2O3(allotropeAl2O3, curTemp); %Setting Al2O3 coefficients
        cpValsAl2O3(1,i) = A + B*t + C*t^2 + D*t^3 + E*t^-2;
    end
    
    if(plotGraph)
        subplot(2,2,1)
        plot(tempRange, cpValsFe2O3);
        title('Fe2O3');
        xlabel('Temperature (K)');
        ylabel('Specific Heat Capacity (J/mol*k)');

        subplot(2,2,2)
        plot(tempRange, cpValsAl2O3);
        title('Al2O3');
        xlabel('Temperature (K)');
        ylabel('Specific Heat Capacity (J/mol*K)');

        subplot(2,2,3)
        plot(tempRange, cpValsAl);
        title('Al');
        xlabel('Temperature (K)');
        ylabel('Specific Heat Capacity (J/mol*K');
    end
    
    
    if(temperature ~= 298)
         hematiteH = trapz(tempRange, cpValsFe2O3);
         if (temperature > 933)
            aluminumH = trapz(tempRange, cpValsAl) + heatFusionAl;
         else
             aluminumH = trapz(tempRange, cpValsAl);
         end
         alOH = trapz(tempRange, cpValsAl2O3);
    end
    
%%
    %setVirial is a nested function that sets the virial coefficients based 
    %on the phase and temperature passed in from parent function.
    function setVirialAl2O3(phase, temp)
        if (strcmp('alpha',phase))
            if (temp >= 298) && (temp < 2327) 
                %fprintf("set Al2O3 alpha\n");
                A = 102.4290;
                B = 38.74980;
                C = -15.91090;
                D = 2.628181;
                E = -3.007551;
            end 
        else %else it is liquid 
            %fprintf("set Al2O3 liquid\n");
            A = 192.4640;
            B = 0;
            C = 0;
            D = 0;
            E = 0;
        end
    end
%%
    %setVirialFe2O3 is a nested function that sets virial coefficients for 
    %Fe2O3 based on the temperature passed in from parent function. Only 
    %one phase, so coefficients are only dependent on temperature.
    function setVirialFe2O3(temp)
        if (temp < 950)
            %fprintf("set Fe2O3 <950\n");
            A = 93.43834;
            B = 108.3577;
            C = -50.86447;
            D = 25.58683;
            E = -1.611330;
        elseif (temp >= 950) && (temp < 1050)
            %fprintf("set Fe2O3 950-1050\n");
            A = 150.6240;
            B = 0;
            C = 0;
            D = 0;
            E = 0;
        elseif (temp >= 1050) && (temp < 2500)
            %fprintf("set Fe2O3 1050-2500\n")
            A = 110.9632; 
            B = 32.04714;
            C = -9.192333;
            D = 0.901506;
            E = 5.433677;
        else
            fprintf("Temp not in valid range: %f", temp);
        end
    end
%%
    %setVirialAl is a nested function that sets the virial coefficients for
    %Al based on the phase.
    function setVirialAl(phase)
        if(strcmp('liquid',phase))
            %("set Al liquid\n");
            A = 31.75104;
            B = 0;
            C = 0;
            D = 0;
            E = 0;
        else
            %If not liquid, it's solid in which case there's only one set
            %of virial coefficients for solids
            %fprintf("set Al solid\n");
            A = 28.08920; 
            B = -5.414849;
            C = 8.560423;
            D = 3.427370;
            E = -0.277375;
        end
    end
end
        
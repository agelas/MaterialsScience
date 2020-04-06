%Mathias Insley

function calculateGibbsEnergyIron() 

    tempRange = [1100:1809];
    cpVals = zeros(1, length(tempRange));
    deltH = zeros(1, length(tempRange));
    deltS = zeros(1, length(tempRange));
    deltG = zeros(1, length(tempRange));
    Gibbs = zeros(1, length(tempRange));
    
    A = -776.7387;
    B = 919.4005;
    C = -383.7184;
    D = 57.08148;
    E = 242.1369;
    
    confDeltH = plotHeatFormationDiff(1809,0); %Reusing code from previous homework, are we sure about the -H298 tho
    
    for i = 1:length(tempRange)
        t = tempRange(i)/1000; %updating t
        cpVals(i) = A + B*t + C*t^2 + D*t^3 + E*t^-2; %Shomate Equation
        
        deltH(i) = confDeltH(802 + i) + 25.09;
        deltS(i) = deltH(i)/tempRange(i); %The entropy at each temp
        deltG(i) = deltH(i) - tempRange(i) * deltS(i);
        Gibbs(i) = trapz(deltG(1:i));
    end
    
    figure(1)
    plot(tempRange, confDeltH(803:end));
    title('Confirmed Enthalpy Change');
    xlabel('Temperature');
    ylabel('Enthalpy')
    
    figure(2)
    subplot(2,1,1)
    plot(tempRange, deltS);
    title('Entropy vs Temperature')
    xlabel('Temperature (K)');
    ylabel('Entropy');
    
    subplot(2,1,2)
    plot(tempRange, Gibbs);
    title('Gibbs Free Energy vs Temp');
    xlabel('Temperature (K)');
    ylabel('Gibbs Free Energy');

end

%Mathias Insley
%Calls calculateHIron to get the heat of formation at a specific
%temperature. Uses that return value to find diffeence between that and
%Heat of formation of 298K. Plots difference. 
function hTemp = plotHeatFormationDiff(temperature, toPlot)
    tempRange = 298:temperature;
    hTemp = zeros(1,max(size(tempRange)));
    
    for i=1:max(size(tempRange))
        hTemp(i) = calculateHIron(tempRange(i),0) - 25.09;
    end
    
    if(toPlot == 1)
        plot(tempRange, hTemp);
        xlabel('Temperature (K)')
        ylabel('HT - H298 (J/mol)')
        title('HT - H298 (J/mol) vs Temperature (K) for Iron');
    end
    
    fprintf("Heat at %d is %f\n", temperature, hTemp(end));
end

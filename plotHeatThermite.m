%Mathias Insley

%Calls calculateHTermite to get the heats of formation for hematite,
%aluminum, and aluminum oxide. Also calls calculateHIron from questions 2
%to get heat of formation of iron.
function plotHeatThermite(temperature)
    tempRange = 298:temperature;
    range = max(size(tempRange));
    heatReaction = zeros(1, range);
    heatThermiteReaction = -850690;
    
    for i=1:range
        
        [hematiteH, aluminumH, alOH] = calculateHThermite(tempRange(i),0);
        ironH = calculateHIron(tempRange(i),0);
        heatReaction(i) = ((2*ironH + alOH) - (hematiteH + 2*aluminumH)...
            + heatThermiteReaction)/1000;
        %heatReaction(i) = heatThermiteReaction/1000 - (2*ironH + alOH)/1000 + ...
        %    (hematiteH + 2*aluminumH)/1000;
    end
    
    fprintf("Heat of Reaction: %f\n", heatReaction(end));
    plot(tempRange, heatReaction);
    xlabel('Temperature (K)')
    ylabel('Heat Reaction (kJ/mol)')
    %ylim([-18571.2 18571.3]);
    
end
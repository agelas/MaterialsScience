data = xlsread('ShearECAE.xlsx');

x = data(:,5);
y = data(:,6);

shearMatrix = [x y];

x=x';
y=y';

Mi = min(y);
Ma = max(y);
diff = abs(Ma-Mi);

pValue = [];
locsNum = [];

for i=1:diff
    posI = abs(i);
    [peaks, locs] = findpeaks(y, 'MinPeakProminence',posI);
    pValue = [pValue i];
    locsNum = [locsNum numel(locs)];
end

plot(pValue, locsNum);
xlabel('Prominence Setting');
ylabel('Number of Peaks');

[peaks, locs] = findpeaks(y,'MinPeakProminence',1500);
[tpeaks, tlocs] = findpeaks(-y, 'MinPeakProminence', 500); 

%low = islocalmin(y);
%plot(x,y,x(low),y(low),'r*');
%hold on
plot(x,y,x(locs), peaks, 'o');
hold on
plot(x(tlocs), y(tlocs), 'r*');

%View on doing master's at Hopkins?
%How did you end up at Stanford?
%Any labs that take students over summer? Heilschorn
%Job market? Companies? Internships?
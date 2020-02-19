%shearAnalysis.m
%package MSE_folder

%% Reading in data from excel
data = xlsread('ShearECAE.xlsx'); %The document you read in needs to be in 
                                  %the same folder the script is in.

x = data(:,5); %Change numbers in these two lines, (1 2)=ZX2, (3 4)=ZX9,
y = data(:,6); %(5 6)=ZX10, (7 8)=ZX11. set 100 This currently reads ZX10 data.

shearMatrix = [x y];
difference = []; %matrix holding differences from peak to trough, not
                 %working 100% correctly though
%% Finding the right prominence

%% Initial filtering of peaks
[peaks, locs] = findpeaks(y,'MinPeakProminence',100); %Finds peaks, you
%can adjust the variable occupied cuurently by '1500' as much as you need-
%the smaller it is the less selective it will be.  
[troughs, tlocs] = findpeaks(-y,'MinPeakProminence',500); %Finds troughs,
%same as above, you can adjust the '500' as much or as little as you need.
%I'd recommend just running the script a few times and changing the numbers
%until you get something you're satisfied with.

%% Filtering out array mismatches
%Ignore this part, this is for later when I get some other parts working.
while (max(size(peaks)) < max(size(troughs))) %recursive size handling
    troughs(max(size(troughs))) = [];
    tlocs(max(size(tlocs))) = [];
end
while (max(size(peaks)) > max(size(troughs)))
    peaks(max(size(peaks))) = [];
    locs(max(size(locs))) = [];
end

%% Plotting 
plot(x,y,x(locs), peaks, 'o');
hold on
plot(x(tlocs), y(tlocs), 'r*');
title("ZX10");
xlabel("Displacement (in)")
ylabel("Load (Lbf)")

difference = difference(difference ~= 0); %The data coming out of this is 
%wrong right now, for now you'll manually have to do the computation for
%amplitude and width, the script only tells you where they are for now.


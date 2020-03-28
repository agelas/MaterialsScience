%%
%This section is responsible for getting rid of byte-order marks that seem
%to be a present in the .txt file produced by the tensile tester. MATLAB
%can only read UTF-8 encoded .txt files. but the tensile tester creates
%UTF-16 encoded .txt files.

fid = fopen('Mg1Zn0.2Ca_test2.txt','r','n','UTF-8');
bytes = fread(fid)';

if (bytes(1) == 255)
    bytes(1:2) = [];
    any(bytes(2:2:end) ~= 0);
    asciibytes = bytes(1:2:end);    
    fclose(fid);
    fid = fopen('Mg1Zn0.2Ca_test2.txt', 'w+');
    fwrite(fid,asciibytes);
    fclose(fid);
else
    fclose(fid); %Nothing to do if BOM not present
end

T = readtable('Mg1Zn0.2Ca_test2.txt'); %Read in data

%%
%This section breaks the video up into individual frames, and creates a 
%video object with accessible properties.

v = VideoReader('Mg1Zn0.2Ca_Ingot2_TestVid.avi');

numFramesIndex = 0;
frameNum = 0;
while hasFrame(v)
    F = readFrame(v);
    numFramesIndex = numFramesIndex + 1;
    imArray{numFramesIndex,1} = F;
end

%%
%This section matches the frames to the times in the video
failTime = 81 * 5; %get time interval into fifths of a second
frameFail = 6 * failTime;

index = find(T{:,:} == 81); %find table index of failure time
Frames = cell(size(T,1),1);

for i = index:-1:1 
    frameMatrix = [frameFail-5 frameFail-4 frameFail-3 frameFail-2 frameFail-1 frameFail];
    Frames{i,1} = int2str(frameMatrix);
    if frameFail > 0
        frameFail = frameFail - 6;
    else
        break;
    end
end

frameTable = cell2table(Frames, 'VariableNames', {'Frames'});

fullTable = [T frameTable]




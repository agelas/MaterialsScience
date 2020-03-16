%%
%This section is responsible for getting rid of byte-order marks that seem
%to be a present in the .txt file produced by the tensile tester. MATLAB
%can only read UTF-8 encoded .txt files. but the tensile tester creates
%UTF-16 encoded .txt files.
fid = fopen('Mg1Zn0.2Ca_tensiletest2.txt','r','n','UTF-8');
bytes = fread(fid)';
bytes(1:15)

if (bytes(1) == 255)
    bytes(1:2) = [];
    any(bytes(2:2:end) ~= 0);
    asciibytes = bytes(1:2:end);    
    fclose(fid);
    fid = fopen('Mg1Zn0.2Ca_tensiletest2.txt', 'w+');
    fwrite(fid,asciibytes);
    fclose(fid);
else
    fclose(fid); %Nothing to do if BOM not present
end

T = readtable('Mg1Zn0.2Ca_tensiletest2.txt')

%%

v = VideoReader('Mg1Zn0.2Ca_Ingot2_TestVid.avi');

numFramesIndex = 0;
frameNum = 0;
while hasFrame(v)
    F = readFrame(v);
    numFramesIndex = numFramesIndex + 1;
    imArray{numFramesIndex,1} = F;
end



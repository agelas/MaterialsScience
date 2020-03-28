%%Load in file 
clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file = '12_5x_1.jpg'; %file to be loaded. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileImport = imread(file);
binary = im2bw(fileImport, 0.5);

%%
figure(1);
clean = bwmorph(binary,'majority',70); 
clean = bwmorph(clean, 'spur', 70);
structF = strel('diamond',5);
clean = imclose(clean, structF);
clean = clean(0.5:730, 0.5:1024); 
originalFile = fileImport(0.5:730, 0.5:1024);
subplot(2,2,1); imshow(originalFile);
subplot(2,2,2); imshow(clean);

sumWhite = sum(clean(:) > 0);
[rows, columns] = size(clean);
areaNonRecrystallized = sumWhite / (rows*columns); %white regions are not-recrystallized
percentAreaRecrystallized = 100 - (areaNonRecrystallized*100);
fprintf("Percent Non-Recrystallized Area: %f\n", (areaNonRecrystallized*100));
fprintf("Percent Recrystallized Area: %f\n", percentAreaRecrystallized);

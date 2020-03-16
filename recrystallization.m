clear all
clc

file='ECAE_MgZnCa_C_5x_6.jpg'; %file to be loaded
fileImport=imread(file);
binary= im2bw(fileImport,0.5);

%%
figure(1);
clean=bwmorph(binary,'majority',70); 
clean=bwmorph(clean, 'spur', 70);
structF=strel('diamond',5);
clean=imclose(clean, structF);
clean = clean(0.5:730, 0.5:1024);
invertedImage=imcomplement(clean);
subplot(2,2,1); imshow(clean);
subplot(2,2,2); imshow(invertedImage);

sumWhite = sum(clean(:) > 0);
[rows, columns] = size(clean);
areaRecrystallized = sumWhite / (rows*columns);
percentAreaRecrystallized = 100 - areaRecrystallized*100;
fprintf("Percent Recrystallized Area: %f\n", percentAreaRecrystallized);
areaBlack = 1 - areaRecrystallized;

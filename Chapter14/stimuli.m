%% Simply show all the stimuli.
%% Script added by SJE
load FaceA.mat
load FaceB.mat
load FW.mat
load Assoc.mat


figure
subplot(2,2,1)
imagesc(FaceA)
subplot(2,2,2)
imagesc(FaceB)
subplot(2,2,3)
imagesc(FW)
subplot(2,2,4)
imagesc(Assoc)
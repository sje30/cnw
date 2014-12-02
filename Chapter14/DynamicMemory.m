%Recall Dynamic limit cycle patterns stored with Hebbian delay synapses
clear all;
DT = 10; %time constant in ms
DTdel = 8;
Pat = 1;
Pat = input('Pattern to recall: (1) NewFace, (2) Dynamic1, (3) Dynamic 2, (4) Dynamic 3: ');
if Pat == 1; load('ExtraFace.mat'); Stim = ExtraFace; end;
if Pat == 2; load('DynImage1.mat'); Stim = DynImage1; end;
if Pat == 3; load('DynImage2.mat'); Stim = DynImage2; end;
if Pat == 4; load('DynImage3.mat'); Stim = DynImage3; end;

%**********
Wdelay = 0.008; %Alter these to solve problems
g = 0.076;
%**********

Input = zeros(16, 16);
CM = [.5 .5 .5; 1 1 1];
SD = clock;  % Three lines to set new random # seed
SD = round((SD(4) + SD(5) + SD(6))*10^3);
rand('seed', SD);
if Pat <= 3; Input(1:9, 1:9) = Stim(1:9, 1:9); end;
if Pat == 4; Input(7:15, 7:15) = Stim(7:15, 7:15); end;
Noise = input('Amount of Random Noise to add (0 - 100): ');
for KK = 1:Noise; %add noise to stimulus
	A = floor(14*rand) + 1;
	B = floor(14*rand) + 1;
	Input(A, B) = 1;
end;
figure(1), image(20*Input + 1); colormap(CM); axis square; pause(0.1);
Neurons = zeros(16, 16);
D1 = zeros(16, 16);
D2 = zeros(16, 16);
D3 = zeros(16, 16);
D4 = zeros(16, 16);
D5 = zeros(16, 16);
Delay = zeros(16, 16);
load('FastSynapses.mat');  %Retrieve modified Synapses file from disk
Synapses = FastSynapses;
load('DelSynapses.mat');
PSP = zeros(size(Input)); %postsynaptic potential
figure(1), image(Input + 1); colormap(CM); axis square;
G = 0; %Inhibitory feedback cell
Last = 120;
if Pat > 1; Last = 800; end; %Longer run for dynamic patterns
Pat1 = zeros(1, Last/2);
Pat2 = zeros(1, Last/2);
Pat3 = zeros(1, Last/2);
Average = zeros(1, Last/2);
CMap = [.5 .5 .5; .6 .6 .6; .7 .7 .7; .8 .8 .8; .9 .9 .9; 1 1 1];
%Stimulus only on for 20 ms
for T = 1:2:Last; %Euler's approximation to solve 256 DE's
	PSP(:) = (10*Input(:)*(T <= 20) + 0.016*(Neurons(:)'*Synapses)' - 0.1*G);
	PSP(:) = PSP(:) + Wdelay*(Delay(:)'*DelSynapses)'; %Delay Synapses
	PSP = PSP.*(PSP > 0);  %No response for negative inputs
	GPSP = g*sum(sum(Neurons));
	G = G + 2/DT*(-G + GPSP);
	D1(:) = D1(:) + (2/DTdel)*(-D1(:) + Neurons(:));
	D2(:) = D2(:) + (2/DTdel)*(-D2(:) + D1(:));
	D3(:) = D3(:) + (2/DTdel)*(-D3(:) + D2(:));
	Delay(:) = Delay(:) + (2/DTdel)*(-Delay(:) + D3(:));
	Neurons(:) = Neurons(:) + 2/DT*(-Neurons(:) + 100*(PSP(:).^2)./(100 + PSP(:).^2));
	Pat1((T+1)/2) = Neurons(1, 3);
	Pat2((T+1)/2) = Neurons(5, 1);
	Pat3((T+1)/2) = Neurons(16, 16);
	Average((T+1)/2) = sum(sum(Neurons))/256;
	if rem(T - 1, 8) == 0;
		figure(2), image(Neurons); colormap(CMap); axis square; pause(0.1);
	end;
end;
Tme = 1:2:Last;
whitebg('w');
if Pat > 1;
	FG = figure(3); plot(Tme, Pat1, 'r-', Tme, Pat2, 'b-', Tme, Pat3, 'g-'); pause(0.1);
	xlabel('Time in ms'); ylabel('Spike Rate');
	figure(4); plot(Tme, Average, 'r-'); 	xlabel('Time in ms'); ylabel('Mean Spike Rate');
	axis([0, 800, max(Average - 8), max(Average)]);
end;


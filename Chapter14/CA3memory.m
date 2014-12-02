%Associative Hippocampal Memory Network
clear all;
Pat = input('Pattern to recall: (1) FaceA, (2) FaceB, (3) FW, (4) Assoc : ');
if Pat == 1; load('FaceA.mat'); Stim = FaceA; end;
if Pat == 2; load('FaceB.mat'); Stim = FaceB; end;
if Pat == 3; load('FW.mat'); Stim = FW; end;
if Pat == 4; load('Assoc.mat'); Stim = Assoc; end;
Input = zeros(16, 16);
CM = [.5 .5 .5; 1 1 1];
SD = clock;  % Three lines to set new random # seed
SD = round((SD(4) + SD(5) + SD(6))*10^3);
rand('seed', SD);
if rand < 0.5; Input(1:9, 1:9) = Stim(1:9, 1:9); %randomly choose pattern fraction
else Input(1:9, 8:16) = Stim(1:9, 8:16); end;
for KK = 1:20; %add noise to stimulus
	A = floor(14*rand) + 1;
	B = floor(14*rand) + 1;
	Input(A, B) = 1;
end;
figure(1), image(Input + 1); colormap(CM); axis square; pause(0.1);
Neurons = zeros(16, 16);
load('Synapses.mat');  %Retrieve modified Synapses file from disk
PSP = zeros(size(Input)); %postsynaptic potential
DT = 10; %time constant in ms
figure(1), image(Input + 1); colormap(CM); axis square;
G = 0; %Inhibitory feedback cell
%Stimulus only on for 20 ms
for T = 1:2:120; %Euler's approximation to solve 256 DE's
	G = G + 2/DT*(-G + 0.076*sum(sum(Neurons)));
	PSP(:) = (10*Input(:)*(T <= 20) + 0.016*(Neurons(:)'*Synapses)' - 0.1*G);
	PSP = PSP.*(PSP > 0);  %No response for negative inputs
	Neurons(:) = Neurons(:) + 2/DT*(-Neurons(:) + 100*(PSP(:).^2)./(100 + PSP(:).^2));
	if rem(T - 1, 4) == 0;
		figure(2), image(Neurons); colormap(CM); axis square; pause(0.1);
	end;
end;
Spike_Rate = max(max(Neurons))
G_inhibition = 0.1*G

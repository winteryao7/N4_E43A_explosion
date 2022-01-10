% find the raw trace

function [] = simple_spec(evid,net,sta,chan)

sacf = evid+"/"+net+"."+sta+"."+chan+".SAC";

[traw,dataraw,hdrraw] = fget_sac(sacf);

selidx = traw >= hdrraw.times.t1 -30 & traw <= hdrraw.times.t1 + 90;

time2use = traw(selidx);

data2use = dataraw(selidx);

% compute the spectrogram

nfft = 128;
window = nfft;
noverlap = nfft*0.75;
[B,F,~] = spectrogram(data2use,window,noverlap,nfft,round(1/hdrraw.times.delta));
Bmax = max(max(B));

% now generate a figure
figure()
subplot(2,1,1);
plot(time2use,data2use,'Linewidth',1.5);
xlim([-30 90]);
ylabel('Amplitude(counts)','Fontsize',17);
hold on;
subplot(2,1,2);
imagesc(time2use,F,log10(abs(B./Bmax))*10);
colormap(flipud(hot));
caxis([-40 5]);
axis xy;
xlim([-30 90]);
xlabel('Time(s)','FontSize',17);
ylabel('Freq(Hz)','FontSize',17);

end
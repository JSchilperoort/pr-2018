[y,fs] = audioread('corrupted_voice.wav');
x = fft(y);
X = fftshift(fft(y));

nf=length(y); %number of point in DTFT
Y = fft(y, nf);
f = fs/2*linspace(0,1,nf/2+1);
plot(f,abs(Y(1:nf/2+1)));

%plot(abs(real(X)));
%plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));


[b,a] = butter(6, [450 3600]/(fs));
dataOut = filter(b,a,y);
audiowrite('filtered_voice.wav',dataOut,fs);
sound(dataOut, fs);

figure
[y2,fs2] = audioread('filtered_voice.wav');
nf2 = length(y2);
Y2 = fft(y2, nf2);
f2 = fs2/2*linspace(0,1,nf2/2+1);
plot(f2,abs(Y2(1:nf2/2+1)));

%freqz(dataOut)

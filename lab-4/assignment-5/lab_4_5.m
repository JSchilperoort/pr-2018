[y,fs] = audioread('corrupted_voice.wav');
x = fft(y);

plot(abs(real(fft(y))));

[b,a] = butter(6, [1000 3500]/(fs));
dataOut = filter(b,a,y);
audiowrite('filtered_voice.wav',dataOut,fs);
sound(dataOut, fs);
%freqz(dataOut)

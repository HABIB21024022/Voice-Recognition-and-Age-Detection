% Record a voice signal
record = audiorecorder;
disp('Start speaking.')
recordblocking(record, 5); % Record for 5 seconds
disp('End of Recording.');
 
% Get the recorded voice data
voice_data = getaudiodata(record);
 
% Determine the frequency using FFT
Fs = record.SampleRate; % Sampling frequency
N = length(voice_data); % Length of the signal
Y = fft(voice_data); % Performing FFT
f = linspace(0,Fs/2,N); % Define Frequency range
power = abs(Y).^2/N; % Define Power of the FFT
 
% Find the dominant frequency
[maxPower, idx] = max(power);
dominantFreq = f(idx);
disp(['Dominant frequency of the voice signal: ' num2str(dominantFreq) ' Hz']);
 
% Gender recognition
if dominantFreq < 135 % Threshold male voice frequency
    disp('Predicted Gender: Male')
else
    disp('Predicted Gender: Female/Child')
 
end
 
% Age recognition
if dominantFreq < 135 % Threshold Adult voice frequency
    disp('Predicted Age: Adult')
else
    disp('Predicted Age: Child')
end
 
 
% Plotting of FFT result
figure;
plot(f, power);
title('Single-Sided Magnitude Spectrum of Voice Signal');
xlabel('Frequency (Hz)');
ylabel('Power');
 
% Plotting of recorded voice signal
figure;
plot((1:N)/record.SampleRate, voice_data);
xlabel('Time (s)');
ylabel('Amplitude');
title('Recorded Voice Signal');


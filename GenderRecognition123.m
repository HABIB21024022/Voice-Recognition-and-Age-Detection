% Record voice
recObj = audiorecorder;
disp('Start speaking.');
recordblocking(recObj, 5); % Record for 5 seconds
disp('End of recording.');

% Play back the recording
play(recObj);

% Get the recorded voice data
voice_data = getaudiodata(recObj);

% Plot the recorded voice signal
figure;
plot((1:length(voice_data)) / recObj.SampleRate, voice_data);
xlabel('Time (s)');
ylabel('Amplitude');
title('Recorded Voice Signal');

% Compute the power spectral density (PSD) of the recorded voice
[psd, freq] = pwelch(voice_data, hamming(256), 128, 256, recObj.SampleRate);

% Plot the power spectral density (PSD)
figure;
plot(freq, 10*log10(psd));
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Power Spectral Density of Recorded Voice');

% Compute mean power in low and high frequency bands
low_freq_band = mean(psd(freq < 1000));
high_freq_band = mean(psd(freq >= 1000));

% Classify gender based on frequency content
threshold = 0.5; % Adjust this threshold as needed
if high_freq_band < threshold * low_freq_band
    disp('Predicted Gender: Male');
else
    disp('Predicted Gender: Female');
end

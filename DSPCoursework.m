figure(1)
plot(origSig);
title("The Original Signal of a Patient With PVC")
xlabel("Time (seconds)")
ylabel("Signal Amplitude (mV)")

figure(2)
plot(noisySig);
title("The Noisy Signal of a Patient With PVC")
xlabel("Time (seconds)")
ylabel("Signal Amplitude (mV)")

% produces a nice, correctly scaled plot of the DFT of a sequence.
% INPUTS:
% inputSequence - the sequence whose DFT is plotted
% fs - the sample rate
% freqType - a string describing the required frequency units. 
%             One of:   'hertz', 
%                       'normalisedF' (=cycles per sample),
%                       'normalisedW' (=radians per sample).
%
% OUTPUT: 
% h - a handle to the figure

fs = 360;
freqType = 'hertz';

FT = fftshift(fft(fftshift(noisySig)));
% the 'fftshift' ensures that the DC frequency is in the centre of the
% plot, so the normalised frequency units will go from -0.5 to 0.5, rather
% than from 0 to 1.

N = length(noisySig);
% N is the number of samples in the input.

index = ceil(-N/2):floor(N/2)-1;

switch freqType
   case 'hertz'
      f = fs*index/N;
      xString = 'Freq. (Hertz)';
   case 'normalisedF'
      f = index/N;
      xString = 'Freq. (cycles per sample)';
   case 'normalisedW'
      f = 2*pi*index/N;
      xString = 'Freq. (radians per sample)';
   otherwise
      % assume normalised freq. if the string is not recognised.
      f = index/N;
      xString = 'Freq. (cycles per sample)';
end

figure(3)
h = plot(f,abs(FT)/N,'linewidth',1);
box on
grid on
ylabel('DFT amplitude (a.u.)');
xlabel(xString);
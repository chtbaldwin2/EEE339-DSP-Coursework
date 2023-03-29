samples = 0:3599;
Fs = 360;
Fc = 60;
endScript = false;
Order = 2;
xAxis = 10;

while endScript == false

    clc;

    t = samples/Fs;
    Fn = (2*Fc/Fs);
    freqType = 'hertz';
       
    FT = fftshift(fft(fftshift(noisySig)));
      
    N = length(noisySig);     
    index = ceil(-N/2):floor(N/2)-1;
        
    switch freqType
        case 'hertz'   
            f = Fs*index/N;       
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
    
    [b,a] = butter(Order, Fn);
    z = filter(b, a, noisySig);
    z2 = filtfilt(b, a, noisySig);
    
    c = fir1(Order, Fn, 'low');
    y = filter(c, 1, noisySig);
    y2 = filtfilt(c, 1, noisySig);
    
    disp("1: origSig");
    disp("2: noisySig");
    disp("3: FFT of noisySig");
    disp("4: IIR Filtered noisySig");
    disp("5: FIR Filtered noisySig");
    disp("6: Frequency Response of the Filters");
    disp("7: Compare origSig and IIR Filtered Signal");
    disp("8: Compare origSig and FIR Filtered Signal");
    disp("9: Change Variables");
    disp("0: End Script");
    
    viewGraph = input('Enter Number: ');
    
    switch viewGraph
        case 1
    
            clf;
            figure(1)
            plot(t, origSig);
            title("The Original Signal of a Patient With PVC")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);
    
        case 2
    
            clf;
            figure(1)
            plot(t, noisySig);
            title("The Noisy Signal of a Patient With PVC")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);
    
        case 3
    
            clf;
            figure(1)
            h = plot(f,abs(FT)/N,'linewidth',1);
            box on
            grid on
            ylabel('DFT amplitude (a.u.)');
            xlabel(xString);
            text(-70, 1, "Mains Hum");
            text(49, 1, "Mains Hum");
    
        case 4

            clf;
            figure(1)
            subplot(2,1,1)
            plot(t, z);
            title("The IIR Filtered Signal of a Patient With PVC (filter())")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);

            subplot(2,1,2)
            plot(t, z2);
            title("The IIR Filtered Signal of a Patient With PVC (filtfilt())")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);

        case 5
    
            clf;
            figure(1)
            subplot(2,1,1)
            plot(t, y);
            title("The FIR Filtered Signal of a Patient With PVC (filter())")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);

            subplot(2,1,2)
            plot(t, y2);
            title("The FIR Filtered Signal of a Patient With PVC (filtfilt())")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);
    
        case 6
    
            fvtool(butter(2, Fn));
            fvtool(fir1(2, Fn));
    
        case 7
    
            clf;
            figure(1)
    
            subplot(3,1,1)
            plot(t, origSig, "red");
            hold on
            plot(t, z2, "blue");
            hold off
            title("The Original and IIR Filtered Signals of a Patient With PVC")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);
    
            subplot(3,1,2)
            plot(t, origSig, "red");
            title("The Original Signal of a Patient With PVC")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);
    
            subplot(3,1,3)
            plot(t, z2, "blue");
            title("The IIR Filtered Signal of a Patient With PVC")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);
    
        case 8
    
            clf;
            figure(1)
    
            subplot(3,1,1)
            plot(t, origSig, "red");
            hold on
            plot(t, y2, "blue");
            hold off
            title("The Original and FIR Filtered Signals of a Patient With PVC")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);
    
            subplot(3,1,2)
            plot(t, origSig, "red");
            title("The Original Signal of a Patient With PVC")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);
    
            subplot(3,1,3)
            plot(t, y2, "blue");
            title("The FIR Filtered Signal of a Patient With PVC")
            xlabel("Time (seconds)")
            ylabel("Signal Amplitude (mV)")
            xlim([0 xAxis]);
            ylim([-550 350]);
    
        case 9
    
            clc;

            disp("1. Enter new Cutoff Frequency Fc");
            disp("2. Enter new Order");
            disp("3. X-Axis Limits");
            disp("4. Back");
            varSelect = input("Enter Number: ");

            switch varSelect

                case 1

                    clc;
                    fprintf('Current Cutoff Frequency is %dHz\n', Fc);
                    Fc = input('Enter a new Cutoff Frequency: ');

                case 2

                    clc;
                    fprintf('Current Order is %d\n', Order);
                    Order = input('Enter a new Order: ');

                case 3
        
                    clc;
                    fprintf('Current X-Axis Limit is t = %ds\n', xAxis);
                    xAxis = input('Enter a new Limit: ');
                    
                case 4

                    clc;

            end

        case 0
            
            endScript = true;
            close(1);

    end

    clc;

end
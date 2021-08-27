%%
v = VideoReader("A.mp4");
frames = 0;
averages = [];
while hasFrame(v)
    videoFrame = readFrame(v);
    red = videoFrame(:,:,1);
    average = mean(red);
    average = mean(average);
    averages(end+1) = average;
end
x = [];
for i = 1:length(averages)
    x(end+1) = i;
end
figure(1);
plot(x,averages);        
xlabel('x(frame)')
ylabel('redvalue(x)')
title('Red Color brightness')

%%
fourier = fft(averages);
rate = v.frameRate;
bmps = [];
magnitudes = [];
minuteFrames = rate * 60;
for i = 1:length(averages)
    bmp = (i-1) * minuteFrames / (length(averages)-1);
    if (bmp >= 50 && bmp <= 220)
        bmps(end+1) = bmp;
        magnitudes(end+1) = abs(fourier(i));
    end
end
figure(2);
plot(bmps, magnitudes);        
xlabel('BMP')
ylabel('Magnitude')
title('Beat Per Minute')

%%
[maximum,index] = max(magnitudes);
figure(3);
plot(bmps, magnitudes);        
xlabel('BMP')
ylabel('Magnitude')
title('Beat Per Minute (part3)')
value = int16(bmps(index));
value = num2str(value);
text(bmps(index),magnitudes(index),['  Your BMP is: ', value]);

%%
magnitudes = [];
minuteFrames = rate * 60;
halfLength = length(averages)/2;
for i = 1:(halfLength)
    bmp = (i-1) * minuteFrames / length(averages);
    if (bmp >= 50 && bmp <= 220)
        magnitudes(i) = fourier(i);
        magnitudes(halfLength - i) = fourier(halfLength - i);
    end
end
figure(4);
ppg = real(ifft(magnitudes));
plot((ppg));        
title('PPG')


load canoe256;
figure(1)
image(Canoe)
axis equal;

figure(2)
colormap(gray(256));
image(Canoe)
axis equal;

figure(3)
showgrey(Canoe)

for i=2:2:256
    figure(4)
    showgrey(Canoe,i)
    pause(1)
end   

%%
phone = phonecalc256;
for i=2:2:256
    figure(4)
    showgrey(phone,i)
    title(sprintf('grey-levels: %i', i))
    pause(1)
end   

%%
vad = whatisthis256;

figure(1)
showgrey(vad)
zmax = max(max(vad));    % obs solve error
zmin = min(vad(:));       
figure(2)
showgrey(vad,64,zmin,zmax)
%%
nallo = nallo256;

figure(1)
colormap(gray(256))
image(nallo)

figure(2)
colormap(cool)
image(nallo)

figure(3)
colormap(hot)
image(nallo)
%%
ninepic = indexpic9
rawsubsample(ninepic)
%%
phone = phonecalc256
raw2 = rawsubsample(rawsubsample(phone))

bin2 = binsubsample(binsubsample(phone))
%%
clear all;
close all;
load canoe256;
figure(1)
image(Canoe)

neg1 = - Canoe;
figure(2)
showgrey(neg1);

neg2 = 255 - Canoe;
figure(3)
showgrey(neg2);

nallo = nallo256;
figure(4)
showgrey(nallo.^(1/3));

figure(5)
showgrey(cos(nallo/10));

figure(6)
hist(neg1(:))
figure(7)
hist(neg2(:))

%%
clear all;
close all;
alpha = 0.01;
nf = nallo256float;

figure(1)
showgrey(nf)

T = log(alpha + nf);
figure(2)
showgrey(T)







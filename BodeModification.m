clear
syms s

prompt = 'Enter the Open Loop TF: ';
G_OL = input(prompt);

NumPoly = 1;
DenPoly = 1;
%%%%%%%%%%%%Finding The Open Loop Poles and Zeros and Plotting them%%%%%%%%

%H_s = some_function_of_s
%considered unity gain negative feedback here

%G_CL = (K*G_OL)/(1+K*G_OL);

[No,Do]=numden(G_OL);

PDo = solve(Do);
if No ~= 1
    ZDo = solve(No);
end
Poles = [];%zeros(1,length(PDo));
Zeros = [];%zeros(1,length(ZDo));
for i=1:length(PDo)
    Poles(i)=str2num(char(PDo(i)));
end
plot([0,0],[-10 10],'y',[-10,10],[0,0],'y');
axis([-10 10 -10 10]);
hold on
plot(real(Poles),imag(Poles),'rx','LineWidth',2,'MarkerSize',8);
grid on
grid minor


if No ~= 1
    for i=1:length(ZDo)
        Zeros(i)=str2num(char(ZDo(i)));
    end
    plot(real(Zeros),imag(Zeros),'go','LineWidth',2,'MarkerSize',8);
    NumFac = [];
    for i=1:length(Zeros)
        NumFac(i,:)=[1,-Zeros(i)];
    end
    for i=1:length(Zeros)
        NumPoly = conv(NumPoly,NumFac(i,:));
    end
end   

DenFac = [];
for i=1:length(Poles)
    DenFac(i,:)=[1,-Poles(i)];
end

for i=1:length(Poles)
    DenPoly = conv(DenPoly,DenFac(i,:));
end

% plotting the root locus

TF = tf(NumPoly,DenPoly);
figure(2);
bode(TF,'r')
grid on
grid minor
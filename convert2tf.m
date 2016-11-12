function [TF,NumPoly,DenPoly] = convert2tf(inputTF)

NumPoly = 1;
DenPoly = 1;
if isnumeric(inputTF)~=0
    TF = tf(NumPoly,DenPoly);
else
    [No,Do]=numden(inputTF);
PDo = solve(Do);
if isnumeric(No)~=0
    ZNo = solve(No);
end
Poles = [];%zeros(1,length(PDo));
Zeros = [];%zeros(1,length(ZDo));
for i=1:length(PDo)
    Poles(i)=str2num(char(PDo(i)));
end

DenFac = [];
for i=1:length(Poles)
    DenFac(i,:)=[1,-Poles(i)];
end

for i=1:length(Poles)
    DenPoly = conv(DenPoly,DenFac(i,:));
end

if isnumeric(No)~=0
    for i=1:length(ZNo)
        Zeros(i)=str2num(char(ZNo(i)));
    end
    %plot(real(Zeros),imag(Zeros),'go','LineWidth',2,'MarkerSize',8);
    NumFac = [];
    for i=1:length(Zeros)
        NumFac(i,:)=[1,-Zeros(i)];
    end
    for i=1:length(Zeros)
        NumPoly = conv(NumPoly,NumFac(i,:));
    end
end

TF = tf(NumPoly, DenPoly);
end

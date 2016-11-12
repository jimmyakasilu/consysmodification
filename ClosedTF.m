function [G_CL,G_CL_Num,G_CL_Den] = ClosedTF(G_OL,H_fb,K_gain)
%%%%%%%%%%%%%%%%%%Setting Default Argument%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 3 || isempty(K_gain)
    syms K
    K_gain = K;
end
%%%%%%%%%%%%%%%In case inputs are tf%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[GOLNum,GOLDen] = tfdata(G_OL);
%[HNum,HDen] = tfdata(H_fb);
%GOLDen = cell2mat(GOLDen);
%GOLNum = cell2mat(GOLNum);
%HNum = cell2mat(HNum);
%HDen = cell2mat(HDen);
%%%%%%%%%%%%%%%Comment out the next two lines if Imputs are tf%%%%%%%%%%%%%
[G_OL,GOLNum,GOLDen] = convert2tf(G_OL)
[H_fb,HNum,HDen] = convert2tf(H_fb)
DenTemp = conv(GOLDen,HDen);
NumTemp = conv(GOLNum, HNum);
lD = length(DenTemp);
lN = length(NumTemp);
GH_NumPoly = [zeros(1,lD-lN),NumTemp];
if K_gain~=K
    disp('Fuck')
    G_CL_Den = conv(GOLDen,HDen) + K_gain*GH_NumPoly;
    G_CL_Num = K_gain*conv(GOLNum,HDen);
    G_CL = tf(G_CL_Num,G_CL_Den);
else
    G_CL_Den = conv(GOLDen,HDen) + K_gain*GH_NumPoly; 
    G_CL_Num = K_gain*conv(GOLNum,HDen);
    G_CL = 0;
end
end
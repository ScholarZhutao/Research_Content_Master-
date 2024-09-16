function [H,B] = dMdB(a,k,c,alpha,Ms,B,M0)
H=zeros(size(B));
M=zeros(size(B));
miu0=4*pi*1e-7;

M(1)=M0;
H(1)=B(1)/miu0-M(1);
for i=2:length(B)
    dB=B(i)-B(i-1);
    He=B(i-1)/miu0+(alpha-1)*M(i-1);
    Malpha=Mah_iso(a,Ms,He);   
    dM1 = (Malpha-M(i-1));               
    delta=sign(dB);
if sign(dB)>0
   dM1(dM1<0)=0;
end

if sign(dB)<0
   dM1(dM1>0)=0;
end                                
dM2=c*delta*k.*dMah_iso(a,Ms,He);  
dM3=miu0.*((1-alpha).*(dM1+dM2)+k*delta);
dMdB=(dM1+dM2)./dM3;
M(i)=dB*dMdB+M(i-1);
H(i)=B(i-1)/miu0-M(i-1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = Mah_iso(a,Ms,He)   
result=Ms.*(coth(He./a)-(a./He));    %无磁滞磁化强度Man
end  

function result = dMah_iso(a,Ms,He) 
result=(Mah_iso(a,Ms,He+1e-6)-Mah_iso(a,Ms,He-1e-6))./2e-6;   %  用导数的增量式来求导，而不是导数公式！！！！
end  
end
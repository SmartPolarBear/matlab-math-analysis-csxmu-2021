% Copyright © KeZheng Xiong 22920202204622
% Open-sourced under GPLv3

clear;

H=[0.4 0 0;0 0.4 0;0 0 0.4];
f=[62;58;54];

A=[-1 0 0;-1 -1 0];
b=[-40;-100];

Aeg=[1 1 1];
beg=[180];

ub=[100;100;100];
lb=[0;0;0];

[res,fval,exitflag,output,lambda] = quadprog(H,f,A,b,Aeg,beg,lb,ub);


x=sym('x',[1,3]);
f=0.2*(x(1)^2+x(2)^2+x(3)^2)+62*x(1)+58*x(2)+54*x(3)-560;
fv=subs(f,x,res');

res
double(fv)



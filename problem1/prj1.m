% Copyright © KeZheng Xiong 22920202204622
% Open-sourced under GPLv3

clear;
syms x y;
f=0.2*x^2+0.1*y^2+sin(x+y);

posible=[[-3;-4] [0;-1] [-2;-2]];

for p=posible
    [e,n,h,l]=gradient_descent(f,p,0.001);
    
    double(e)
    double(0.2*e(1)^2+0.1*e(2)^2+sin(e(1)+e(2)))
    
    
    fc = fcontour(f,[-2*pi 2*pi -2*pi 2*pi],'LevelStep',0.3);

    fc.LineWidth = 1;
    fc.LineStyle = "-";
    fc.Fill='off';
    fc.LevelList = [fc.LevelList l];

    colorbar;
    hold on;
    grid off;
    plot(h(:, 1),h(:, 2), '-r.');
    hold on; 
end

xlabel('x');
ylabel('y');


%[x,fmin]=fminsearch(@fun2_3,[-3,-4])
%[x,fmin]=fminsearch(@fun2_3,[0,-1])
%[x,fmin]=fminsearch(@fun2_3,[1,2])
%function f=fun2_3(x)
%f=0.2*x(1)^2+0.1*x(2)^2+sin(x(1)+x(2));
%end


function [endp,num,hist,list]=gradient_descent(f,x0,eps)
    syms x y m;
    d=-[diff(f,x);diff(f,y)];
    
    nd=subs(d,x,x0(1));
    nd=subs(nd,y,x0(2));
    nrm=double(norm(nd));
    
    list=[];
    
    k=0;
    while(nrm>=eps)
        nx0=x0+m*nd;
        nf=subs(f,x,nx0(1));
        nf=subs(nf,y,nx0(2));
        h=diff(nf,m);
        nm=solve(h);
        
        x0=x0+nm*nd;
        k=k+1;
        
        hist(k,:)=[double(x0(1));double(x0(2))];
        vf=subs(f,x,x0(1));
        vf=subs(vf,y,x0(2));
        list = [list double(eval(vf))];
        
        nd=subs(d,x,x0(1));
        nd=subs(nd,y,x0(2)); 
        nrm=double(norm(nd));
    end
    
    num=k;
    endp=x0;
end
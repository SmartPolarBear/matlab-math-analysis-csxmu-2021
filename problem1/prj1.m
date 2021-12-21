clear;
syms x y;
f=0.2*x^2+0.1*y^2+sin(x+y);

posible=[[-3;-4] [0;-1] [-2;-2]]

for p=posible
    [e,n,h,l]=gradient_descent(f,p,0.001);
    
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
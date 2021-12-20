clear;
syms x y;
f=0.2*x^2+0.1*y^2+sin(x+y);
[e,n,h]=gradient_descent(f,[-2;-6],0.001);
e
n
h

function [endp,num,history]=gradient_descent(f,x0,eps)
    syms x y m;
    d=-[diff(f,x);diff(f,y)];
    
    nd=subs(d,x,x0(1));
    nd=subs(nd,y,x0(2));
    nrm=double(norm(nd));
    
    k=0;
    while(nrm>=eps)
        nx0=x0+m*nd;
        nf=subs(f,x,nx0(1));
        nf=subs(nf,y,nx0(2));
        h=diff(nf,m);
        nm=solve(h);
        
        x0=x0+nm*nd;
        k=k+1;
        history(k,:)=x0;
        
        nd=subs(d,x,x0(1));
        nd=subs(nd,y,x0(2)); 
        nrm=double(norm(nd));
    end
    
    num=k;
    endp=x0;
end
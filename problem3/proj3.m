clear;
p=sym('p',[1,32]);

f=p(1)*log2(p(1));
sum=p(1);

for i=p(2:32)
    f=f+i*log2(i);
    sum=sum+i;
end

f=-f;

syms r

l=f+r*(sum-1);

eqns=[];
for i=p
    eqns=[eqns diff(l,i)];
end

eqns=[eqns diff(l,r)];
vars=[p r];

solution=solve(eqns,vars);

ps=subs(p,solution);
fs=subs(f,solution);

format rat;
ps
eval(fs)

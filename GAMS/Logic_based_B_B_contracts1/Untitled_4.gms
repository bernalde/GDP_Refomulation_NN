$include seed.gms
*execseed = 14;

Sets m      planing period     / m1*m6 /
     p      raw oils           / v1*v2, o1*o3 /
     pv(p)  vegetable oils     / v1*v2 /
     pnv(p) non-vegetable oils / o1*o3 /

Parameters
     maxstore  maximum storage of each type of raw oil /   1000 /
     maxusepv  maximum use of vegetable oils           /    200 /
     maxusepnv maximum use of non-vegetable oils       /    250 /
     minusep   minimum use of raw oil                  /     20 /
     maxnusep  maximum number of raw oils in a blend   /      3 /
     sp        sales price of refined and blended oil  /    150 /
     sc        storage cost of raw oils                /      5 /
     stock(p)  stock at the beginning and end          / #p 500 /
     hmin      minimum hardness of refined oil         /      3 /
     hmax      maximum hardness of refined oil         /      6 /
     h(p)      hardness of raw oils / v1 8.8, v2 6.1, o1 2, o2 4.2, o3 5.0 /
     cost(m,p)
;

cost(m,p)=UniformInt(1,25);
h(p)=UniformInt(20,90)/10;
sc=.05;
sp=15;

maxstore  =UniformInt(500,1000);
maxusepv  =UniformInt(200,300);
maxusepnv =UniformInt(250,350);
*maxusepnv= maxusepv;
minusep   =UniformInt(10,30);
sp        =UniformInt(25,35);
sc        =UniformInt(1,5)/10;
stock(p)  =UniformInt(100,500);
h(pv)     =UniformInt(60,90)/10;
h(pnv)    =UniformInt(20,60)/10;
hmin      =UniformInt(round(smin(p,h(p))),round(smin(p,h(p))*1.5));
hmax      =UniformInt(round(smax(p,h(p))*.5),round(smax(p,h(p))));



Variables
     produce(m)    production of blended and refined oil per month
     use(m,p)      usage of raw oil per month
     induse(m,p)   indicator for usage of raw oil per month
     buy(m,p)      purchase of raw oil per month
     store(m,p)    storage of raw oil at end of the month
     profit        objective variable;
Positive variables produce, buy, store, use;
Binary variable induse;

Equations
     defobj        objective
     defusepv(m)   maximum use of vegetable oils
     defusepnv(m)  maximum use of non-vegetable oils
     defproduce(m) production of refined oil
     defhmin(m)    minmum hardness requirement
     defhmax(m)    maximum hardness requirement
     stockbal(m,p) stock balance constraint
     minuse(m,p)   minimum usage of raw oil
     maxuse(m,p)   usage of raw oil is 0 if induse is 0
     maxnuse(m)    maximum number of raw oils used in a blend
     deflogic1(m)  if some vegetable raw oil is use we also need to use o1
     final_stock
;

defobj..        profit =e= -  sum(m, sp*produce(m))
                           + sum((m,p), cost(m,p)*buy(m,p))
                           + sum((m,p), sc*store(m,p));

defusepv(m)..   sum(pv, use(m,pv)) =l= maxusepv;

defusepnv(m)..  sum(pnv, use(m,pnv)) =l= maxusepnv;

defproduce(m).. produce(m) =e= sum(p, use(m,p));

defhmin(m)..    sum(p, h(p)*use(m,p)) =g= hmin*produce(m);

defhmax(m)..    sum(p, h(p)*use(m,p)) =l= hmax*produce(m);

* steady-state stock
stockbal(m,p).. store(m--1,p) + buy(m,p) =e= use(m,p) + store(m,p);


* Now come the logical constraints
minuse(m,p)..   use(m,p) =g= minusep*induse(m,p);

maxuse(m,p)..   use(m,p) =l= (maxusepv$pv(p)+maxusepnv$pnv(p))*induse(m,p);

maxnuse(m)..    sum(p, induse(m,p)) =l= maxnusep;

final_stock(p).. store('m6',p) =e= stock(p);

* sum(pv, induse(m,pv))>=1 => induse(m,'o3')=1
* turn around induse(m,'o3')=0 => sum(pv, induse(m,pw))=0
deflogic1(m)..  sum(pv, induse(m,pv)) =l= induse(m,'o3')*card(pv);

model food / all/;

store.up(m,p)    = maxstore;
use.up(m,p)=   maxusepnv;

*induse.fx(m,p)=   0;
*induse.fx(m,'o1')=   1;
*induse.fx(m,'o2')=   1;
*induse.fx(m,'o3')=   1;

option optcr=0;
solve food min profit using mip;



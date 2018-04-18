$include seed.gms
*execseed = 14;

Sets m      planing period     / 1*4 /
     p      raw oils           / v1*v2, o1*o3 /
     pv(p)  vegetable oils     / v1*v2 /
     pnv(p) non-vegetable oils / o1*o3 /

alias(m,k);

Set i  disjunctive terms  /1*14/
    var variables (m*p) /1*25/
    e max equations in disjunction /1*9/
    ki(k,i)  set that contains disjunctions and terms
    kie(k,i,e) set that contains disjunctions terms and equations
    kv(k,var) set that contains disjunctions and variables
 ;

Parameters
     maxstore  maximum storage of each type of raw oil
     maxusepv  maximum use of vegetable oils
     maxusepnv maximum use of non-vegetable oils
     minusep   minimum use of raw oil
     maxnusep  maximum number of raw oils in a blend
     sp        sales price of refined and blended oil
     sc        storage cost of raw oils
     stock(p)  stock at the beginning and end
     hmin      minimum hardness of refined oil
     hmax      maximum hardness of refined oil
     h(p)      hardness of raw oils
     cost_param(m,p)
;

cost_param(m,p)=UniformInt(1,25);
h(p)=UniformInt(20,90)/10;
sc=.05;
sp=15;

*maxstore  =UniformInt(500,1000);
*maxusepv  =UniformInt(200,300);
*maxusepnv =UniformInt(250,350);
*maxusepnv= maxusepv;
*minusep   =UniformInt(10,30);
*sp        =UniformInt(25,35);
*sc        =UniformInt(1,5)/10;
*stock(p)  =UniformInt(100,500);
h(pv)     =UniformInt(60,90)/10;
h(pnv)    =UniformInt(20,60)/10;
hmin      =UniformInt(round(smin(p,h(p))),round(smin(p,h(p))*1.5));
*hmax      =UniformInt(round(smax(p,h(p))*.5),round(smax(p,h(p))));
hmax      =UniformInt(hmin,round(smax(p,h(p))));
*hmin      =UniformInt(round(smin(p,h(p))),round(smin(p,h(p))*1.1));
*hmax      =UniformInt(round(smax(p,h(p))*0.9),round(smax(p,h(p))));

cost_param(m,p)=UniformInt(1,100);

maxstore  =UniformInt(500,600);
maxusepv  =UniformInt(200,300);
maxusepnv =UniformInt(200,350);
minusep   =UniformInt(5,20);
sp        =UniformInt(20,50);
*sc        =UniformInt(1,5);
*stock(p)  =UniformInt(100,500);
sc        =UniformInt(5,10);
stock(p)  =UniformInt(round(maxstore/8),round(maxstore/5));

*minimum use of same oil in next time period
scalar use_blend1;
use_blend1 = 0.95;

parameter term(k), eq_term(k,i), A(k,i,e,var), b(k,i,e), c(var), ub(var), lb(var);
scalar cnt1 /1/
       tot_k;

tot_k=card(k);

ki(k,i)=yes;

kie(k,i,e)=no;
kie(k,i,e)$(ord(e)<=6)=yes;
kie(k,i,e)$(ord(i)>=4 and ord(i)<=8 and ord(e)<=7)=yes;
kie(k,i,e)$(ord(i)>=8)=yes;

*kie(k,i,e)$(ord(e)<=7)=yes;
*kie(k,i,e)$(ord(i)>=4 and ord(i)<=8 and ord(e)<=9)=yes;
*kie(k,i,e)$(ord(i)>=8)=yes;

kv(k,var)=no;

*b(k,i,e)$(kie(k,i,e) and ord(e)=1) = maxusepv;
b(k,i,e)$(kie(k,i,e) and ord(e)=2) = -minusep;
*b(k,i,e)$(kie(k,i,e) and ord(e)=3 and ord(i)>=4) = maxusepv;
b(k,i,e)$(kie(k,i,e) and ord(e)=4 and ord(i)>=4) = -minusep;
*b(k,i,e)$(kie(k,i,e) and ord(e)=5 and ord(i)>=8) = maxusepv;
b(k,i,e)$(kie(k,i,e) and ord(e)=6 and ord(i)>=9) = -minusep;
b(k,i,e)$(kie(k,i,e) and ord(e)>=3 and ord(i)<=3) = 0;
b(k,i,e)$(kie(k,i,e) and ord(e)>=5 and ord(i)>=4 and ord(i)<=7) = 0;
b(k,i,e)$(kie(k,i,e) and ord(e)>=7 and ord(i)>=7) = 0;

parameter opt_bigm(k,i,e);
opt_bigm(k,i,e)=0;

loop(k,
   cnt1=3;
   A(k,'1',e,var)$(kie(k,'1',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'1',e,var)$(kie(k,'1',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'1',e,var)$(kie(k,'1',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1-2)) = 1;
   A(k,'1',e,var)$(kie(k,'1',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1-1)) = 1;
   A(k,'1',e,var)$(kie(k,'1',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   A(k,'1',e,var)$(kie(k,'1',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   b(k,'1',e)$(kie(k,'1',e) and ord(e)=1 ) = maxusepnv;

   opt_bigm(k,'1',e)$(kie(k,'1',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'1',e)$(kie(k,'1',e) and ord(e)=3 ) = maxusepv;
   opt_bigm(k,'1',e)$(kie(k,'1',e) and ord(e)=4 ) = maxusepv;
   opt_bigm(k,'1',e)$(kie(k,'1',e) and ord(e)=5 ) = maxusepnv;
   opt_bigm(k,'1',e)$(kie(k,'1',e) and ord(e)=6 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'1',e,var)$(kie(k,'1',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
*      A(k,'1',e,var)$(kie(k,'1',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'1',e)$(kie(k,'1',e) and ord(e)=7) = 0;
*   );

   cnt1=4;
   A(k,'2',e,var)$(kie(k,'2',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'2',e,var)$(kie(k,'2',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'2',e,var)$(kie(k,'2',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1-3)) = 1;
   A(k,'2',e,var)$(kie(k,'2',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1-2)) = 1;
   A(k,'2',e,var)$(kie(k,'2',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1-1)) = 1;
   A(k,'2',e,var)$(kie(k,'2',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   b(k,'2',e)$(kie(k,'2',e) and ord(e)=1 ) = maxusepnv;

   opt_bigm(k,'2',e)$(kie(k,'2',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'2',e)$(kie(k,'2',e) and ord(e)=3 ) = maxusepv;
   opt_bigm(k,'2',e)$(kie(k,'2',e) and ord(e)=4 ) = maxusepv;
   opt_bigm(k,'2',e)$(kie(k,'2',e) and ord(e)=5 ) = maxusepnv;
   opt_bigm(k,'2',e)$(kie(k,'2',e) and ord(e)=6 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'2',e,var)$(kie(k,'2',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
*      A(k,'2',e,var)$(kie(k,'2',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'2',e)$(kie(k,'2',e) and ord(e)=7) = 0;
*   );

   cnt1=5;
   A(k,'3',e,var)$(kie(k,'3',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'3',e,var)$(kie(k,'3',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'3',e,var)$(kie(k,'3',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1-4)) = 1;
   A(k,'3',e,var)$(kie(k,'3',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1-3)) = 1;
   A(k,'3',e,var)$(kie(k,'3',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1-2)) = 1;
   A(k,'3',e,var)$(kie(k,'3',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1-1)) = 1;
   b(k,'3',e)$(kie(k,'3',e) and ord(e)=1 ) = maxusepnv;

   opt_bigm(k,'3',e)$(kie(k,'3',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'3',e)$(kie(k,'3',e) and ord(e)=3 ) = maxusepv;
   opt_bigm(k,'3',e)$(kie(k,'3',e) and ord(e)=4 ) = maxusepv;
   opt_bigm(k,'3',e)$(kie(k,'3',e) and ord(e)=5 ) = maxusepnv;
   opt_bigm(k,'3',e)$(kie(k,'3',e) and ord(e)=6 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'3',e,var)$(kie(k,'3',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
*      A(k,'3',e,var)$(kie(k,'3',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'3',e)$(kie(k,'3',e) and ord(e)=7) = 0;
*   );

   cnt1=1;
   A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = 1;
   A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = -1;
   A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = 1;
   b(k,'4',e)$(kie(k,'4',e) and ord(e)=1 ) = maxusepv;
   b(k,'4',e)$(kie(k,'4',e) and ord(e)=3 ) = maxusepnv;

   opt_bigm(k,'4',e)$(kie(k,'4',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'4',e)$(kie(k,'4',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'4',e)$(kie(k,'4',e) and ord(e)=5 ) = maxusepv;
   opt_bigm(k,'4',e)$(kie(k,'4',e) and ord(e)=6 ) = maxusepnv;
   opt_bigm(k,'4',e)$(kie(k,'4',e) and ord(e)=7 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
*      A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = -1;
*      A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'4',e)$(kie(k,'4',e) and ord(e)=8) = 0;
*      A(k,'4',e,var)$(kie(k,'4',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1+4)) = use_blend1;
*      b(k,'4',e)$(kie(k,'4',e) and ord(e)=9) = 0;
*   );

   cnt1=2;
   A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = 1;
   A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = -1;
   A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1-1)) = 1;
   A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   b(k,'5',e)$(kie(k,'5',e) and ord(e)=1 ) = maxusepv;
   b(k,'5',e)$(kie(k,'5',e) and ord(e)=3 ) = maxusepnv;

   opt_bigm(k,'5',e)$(kie(k,'5',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'5',e)$(kie(k,'5',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'5',e)$(kie(k,'5',e) and ord(e)=5 ) = maxusepv;
   opt_bigm(k,'5',e)$(kie(k,'5',e) and ord(e)=6 ) = maxusepnv;
   opt_bigm(k,'5',e)$(kie(k,'5',e) and ord(e)=7 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
*      A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = -1;
*      A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'5',e)$(kie(k,'5',e) and ord(e)=8) = 0;
*      A(k,'5',e,var)$(kie(k,'5',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1+3)) = use_blend1;
*      b(k,'5',e)$(kie(k,'5',e) and ord(e)=9) = 0;
*   );

   cnt1=3;
   A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = -1;
   A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1-2)) = 1;
   A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1-1)) = 1;
   A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   b(k,'6',e)$(kie(k,'6',e) and ord(e)=1 ) = maxusepnv;
   b(k,'6',e)$(kie(k,'6',e) and ord(e)=3 ) = maxusepnv;

   opt_bigm(k,'6',e)$(kie(k,'6',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'6',e)$(kie(k,'6',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'6',e)$(kie(k,'6',e) and ord(e)=5 ) = maxusepv;
   opt_bigm(k,'6',e)$(kie(k,'6',e) and ord(e)=6 ) = maxusepv;
   opt_bigm(k,'6',e)$(kie(k,'6',e) and ord(e)=7 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
*      A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = -1;
*      A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'6',e)$(kie(k,'6',e) and ord(e)=8) = 0;
*      A(k,'6',e,var)$(kie(k,'6',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1+1)) = use_blend1;
*      b(k,'6',e)$(kie(k,'6',e) and ord(e)=9) = 0;
*   );

   cnt1=3;
   A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = -1;
   A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1-2)) = 1;
   A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1-1)) = 1;
   A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   b(k,'7',e)$(kie(k,'7',e) and ord(e)=1 ) = maxusepnv;
   b(k,'7',e)$(kie(k,'7',e) and ord(e)=3 ) = maxusepnv;

   opt_bigm(k,'7',e)$(kie(k,'7',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'7',e)$(kie(k,'7',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'7',e)$(kie(k,'7',e) and ord(e)=5 ) = maxusepv;
   opt_bigm(k,'7',e)$(kie(k,'7',e) and ord(e)=6 ) = maxusepv;
   opt_bigm(k,'7',e)$(kie(k,'7',e) and ord(e)=7 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
*      A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = -1;
*      A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'7',e)$(kie(k,'7',e) and ord(e)=8) = 0;
*      A(k,'7',e,var)$(kie(k,'7',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1+2)) = use_blend1;
*      b(k,'7',e)$(kie(k,'7',e) and ord(e)=9) = 0;
*   );

   cnt1=4;
   A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = -1;
   A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1-3)) = 1;
   A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1-2)) = 1;
   A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1-1)) = 1;
   b(k,'8',e)$(kie(k,'8',e) and ord(e)=1 ) = maxusepnv;
   b(k,'8',e)$(kie(k,'8',e) and ord(e)=3 ) = maxusepnv;

   opt_bigm(k,'8',e)$(kie(k,'8',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'8',e)$(kie(k,'8',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'8',e)$(kie(k,'8',e) and ord(e)=5 ) = maxusepv;
   opt_bigm(k,'8',e)$(kie(k,'8',e) and ord(e)=6 ) = maxusepv;
   opt_bigm(k,'8',e)$(kie(k,'8',e) and ord(e)=7 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
*      A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = -1;
*      A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'8',e)$(kie(k,'8',e) and ord(e)=8) = 0;
*      A(k,'8',e,var)$(kie(k,'8',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1+1)) = use_blend1;
*      b(k,'8',e)$(kie(k,'8',e) and ord(e)=9) = 0;
*   );

   cnt1=1;
   A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = -1;
   A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = 1;
   A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = -1;
   A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = 1;
   b(k,'9',e)$(kie(k,'9',e) and ord(e)=1 ) = maxusepv;
   b(k,'9',e)$(kie(k,'9',e) and ord(e)=3 ) = maxusepv;
   b(k,'9',e)$(kie(k,'9',e) and ord(e)=5 ) = maxusepnv;

   opt_bigm(k,'9',e)$(kie(k,'9',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'9',e)$(kie(k,'9',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'9',e)$(kie(k,'9',e) and ord(e)=6 ) = minusep;
   opt_bigm(k,'9',e)$(kie(k,'9',e) and ord(e)=7 ) = maxusepnv;
   opt_bigm(k,'9',e)$(kie(k,'9',e) and ord(e)=8 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1))    = -1;
*      A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = -1;
*      A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = -1;
*
*      A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'9',e)$(kie(k,'9',e) and ord(e)=9) = 0;
*      A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-2)+cnt1+1)) = use_blend1;
*      b(k,'9',e)$(kie(k,'9',e) and ord(e)=10) = 0;
*      A(k,'9',e,var)$(kie(k,'9',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-2)+cnt1+4)) = use_blend1;
*      b(k,'9',e)$(kie(k,'9',e) and ord(e)=11) = 0;
*   );

   cnt1=1;
   A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = -1;
   A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = 1;
   A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = -1;
   A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = 1;
   b(k,'10',e)$(kie(k,'10',e) and ord(e)=1 ) = maxusepv;
   b(k,'10',e)$(kie(k,'10',e) and ord(e)=3 ) = maxusepnv;
   b(k,'10',e)$(kie(k,'10',e) and ord(e)=5 ) = maxusepnv;

   opt_bigm(k,'10',e)$(kie(k,'10',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'10',e)$(kie(k,'10',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'10',e)$(kie(k,'10',e) and ord(e)=6 ) = minusep;
   opt_bigm(k,'10',e)$(kie(k,'10',e) and ord(e)=7 ) = maxusepv;
   opt_bigm(k,'10',e)$(kie(k,'10',e) and ord(e)=8 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1))    = -1;
*      A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = -1;
*      A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = -1;
*
*      A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'10',e)$(kie(k,'10',e) and ord(e)=9) = 0;
*      A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-2)+cnt1+2)) = use_blend1;
*      b(k,'10',e)$(kie(k,'10',e) and ord(e)=10) = 0;
*      A(k,'10',e,var)$(kie(k,'10',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-2)+cnt1+4)) = use_blend1;
*      b(k,'10',e)$(kie(k,'10',e) and ord(e)=11) = 0;
*   );


   cnt1=1;
   A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = 1;
   A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = -1;
   A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = 1;
   A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = -1;
   A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   b(k,'11',e)$(kie(k,'11',e) and ord(e)=1 ) = maxusepv;
   b(k,'11',e)$(kie(k,'11',e) and ord(e)=3 ) = maxusepnv;
   b(k,'11',e)$(kie(k,'11',e) and ord(e)=5 ) = maxusepnv;

   opt_bigm(k,'11',e)$(kie(k,'11',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'11',e)$(kie(k,'11',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'11',e)$(kie(k,'11',e) and ord(e)=6 ) = minusep;
   opt_bigm(k,'11',e)$(kie(k,'11',e) and ord(e)=7 ) = maxusepv;
   opt_bigm(k,'11',e)$(kie(k,'11',e) and ord(e)=8 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1))    = -1;
*      A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = -1;
*      A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-1)+cnt1+4)) = -1;
*
*      A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'11',e)$(kie(k,'11',e) and ord(e)=9) = 0;
*      A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-2)+cnt1+3)) = use_blend1;
*      b(k,'11',e)$(kie(k,'11',e) and ord(e)=10) = 0;
*      A(k,'11',e,var)$(kie(k,'11',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-2)+cnt1+4)) = use_blend1;
*      b(k,'11',e)$(kie(k,'11',e) and ord(e)=11) = 0;
*   );

   cnt1=2;
   A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = -1;
   A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = 1;
   A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = -1;
   A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1-1)) = 1;
   A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   b(k,'12',e)$(kie(k,'12',e) and ord(e)=1 ) = maxusepv;
   b(k,'12',e)$(kie(k,'12',e) and ord(e)=3 ) = maxusepnv;
   b(k,'12',e)$(kie(k,'12',e) and ord(e)=5 ) = maxusepnv;

   opt_bigm(k,'12',e)$(kie(k,'12',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'12',e)$(kie(k,'12',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'12',e)$(kie(k,'12',e) and ord(e)=6 ) = minusep;
   opt_bigm(k,'12',e)$(kie(k,'12',e) and ord(e)=7 ) = maxusepv;
   opt_bigm(k,'12',e)$(kie(k,'12',e) and ord(e)=8 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1))    = -1;
*      A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = -1;
*      A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = -1;
*      A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'12',e)$(kie(k,'12',e) and ord(e)=9) = 0;
*      A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-2)+cnt1+1)) = use_blend1;
*      b(k,'12',e)$(kie(k,'12',e) and ord(e)=10) = 0;
*      A(k,'12',e,var)$(kie(k,'12',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-2)+cnt1+3)) = use_blend1;
*      b(k,'12',e)$(kie(k,'12',e) and ord(e)=11) = 0;
*   );
*

   cnt1=2;
   A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = -1;
   A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = 1;
   A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = -1;
   A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1-1)) = 1;
   A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   b(k,'13',e)$(kie(k,'13',e) and ord(e)=1 ) = maxusepv;
   b(k,'13',e)$(kie(k,'13',e) and ord(e)=3 ) = maxusepnv;
   b(k,'13',e)$(kie(k,'13',e) and ord(e)=5 ) = maxusepnv;

   opt_bigm(k,'13',e)$(kie(k,'13',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'13',e)$(kie(k,'13',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'13',e)$(kie(k,'13',e) and ord(e)=6 ) = minusep;
   opt_bigm(k,'13',e)$(kie(k,'13',e) and ord(e)=7 ) = maxusepv;
   opt_bigm(k,'13',e)$(kie(k,'13',e) and ord(e)=8 ) = maxusepnv;

*   if(ord(k)>1,
*      A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1))    = -1;
*      A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = -1;
*      A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-1)+cnt1+3)) = -1;
*
*      A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'13',e)$(kie(k,'13',e) and ord(e)=9) = 0;
*      A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-2)+cnt1+2)) = use_blend1;
*      b(k,'13',e)$(kie(k,'13',e) and ord(e)=10) = 0;
*      A(k,'13',e,var)$(kie(k,'13',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-2)+cnt1+3)) = use_blend1;
*      b(k,'13',e)$(kie(k,'13',e) and ord(e)=11) = 0;
*   );

   cnt1=3;
   A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=1 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = 1;
   A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=2 and ord(var)=(card(p)*(ord(k)-1)+cnt1)) = -1;
   A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=3 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = 1;
   A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=4 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = -1;
   A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=5 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = 1;
   A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = -1;
   A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=7 and ord(var)=(card(p)*(ord(k)-1)+cnt1-1)) = 1;
   A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=8 and ord(var)=(card(p)*(ord(k)-1)+cnt1-2)) = 1;
   b(k,'14',e)$(kie(k,'14',e) and ord(e)=1 ) = maxusepnv;
   b(k,'14',e)$(kie(k,'14',e) and ord(e)=3 ) = maxusepnv;
   b(k,'14',e)$(kie(k,'14',e) and ord(e)=5 ) = maxusepnv;

   opt_bigm(k,'14',e)$(kie(k,'14',e) and ord(e)=2 ) = minusep;
   opt_bigm(k,'14',e)$(kie(k,'14',e) and ord(e)=4 ) = minusep;
   opt_bigm(k,'14',e)$(kie(k,'14',e) and ord(e)=6 ) = minusep;
   opt_bigm(k,'14',e)$(kie(k,'14',e) and ord(e)=7 ) = maxusepv;
   opt_bigm(k,'14',e)$(kie(k,'14',e) and ord(e)=8 ) = maxusepv;

*   if(ord(k)>1,
*      A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-1)+cnt1))    = -1;
*      A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-1)+cnt1+1)) = -1;
*      A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=11 and ord(var)=(card(p)*(ord(k)-1)+cnt1+2)) = -1;
*
*      A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=9 and ord(var)=(card(p)*(ord(k)-2)+cnt1)) = use_blend1;
*      b(k,'14',e)$(kie(k,'14',e) and ord(e)=9) = 0;
*      A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=10 and ord(var)=(card(p)*(ord(k)-2)+cnt1+1)) = use_blend1;
*      b(k,'14',e)$(kie(k,'14',e) and ord(e)=10) = 0;
*      A(k,'14',e,var)$(kie(k,'14',e) and ord(e)=6 and ord(var)=(card(p)*(ord(k)-2)+cnt1+2)) = use_blend1;
*      b(k,'14',e)$(kie(k,'14',e) and ord(e)=11) = 0;
*   );

);


kv(k,var)$( sum((i,e)$(A(k,i,e,var)<>0),1)>=1 )=yes;

loop(k,
   ub(var)$(ord(var)=(card(p)*(ord(k)-1)+1)) = maxusepv;
   ub(var)$(ord(var)=(card(p)*(ord(k)-1)+2)) = maxusepv;
   ub(var)$(ord(var)=(card(p)*(ord(k)-1)+3)) = maxusepnv;
   ub(var)$(ord(var)=(card(p)*(ord(k)-1)+4)) = maxusepnv;
   ub(var)$(ord(var)=(card(p)*(ord(k)-1)+5)) = maxusepnv;
);

lb(var)=0;
*ub(var)=maxusepnv;

set var_map(var,m,p);
var_map(var,m,p)=no;cnt1=1;
loop((m,p),
   var_map(var,m,p)$(ord(var)=cnt1)=yes;
   cnt1=cnt1+1;
);



Variables
     produceeee(m)    production of blended and refined oil per month
     buyyyy(m,p)      purchase of raw oil per month
     storeeee(m,p)    storage of raw oil at end of the month
     costttt        objective variable
     xxxx(var);
Positive variables produceeee, buyyyy, storeeee, useeee;
Binary variable yyyy(k,i);

Equations
     defobjjjj        objective
     defusepvvvv(m)   maximum use of vegetable oils
     defusepnvvvv(m)  maximum use of non-vegetable oils
     defproduceeee(m) production of refined oil
     defhminnnn(m)    minmum hardness requirement
     defhmaxxxx(m)    maximum hardness requirement
     stockballll(m,p) stock balance constraint
     final_stockkkk
     sum_binnnn
     disj_ineqqqq

;

defobjjjj..        costttt =e= -  sum(m, sp*produceeee(m))
                           + sum((m,p), cost_param(m,p)*buyyyy(m,p))
                           + sum((m,p), sc*storeeee(m,p));

defusepvvvv(m)..   sum((pv,var)$var_map(var,m,pv), xxxx(var)) =l= maxusepv;

defusepnvvvv(m)..  sum((pnv,var)$var_map(var,m,pnv), xxxx(var)) =l= maxusepnv;

defproduceeee(m).. produceeee(m) =e= sum((var,p)$var_map(var,m,p), xxxx(var));

defhminnnn(m)..    sum((var,p)$var_map(var,m,p), h(p)*xxxx(var)) =g= hmin*produceeee(m);

defhmaxxxx(m)..    sum((var,p)$var_map(var,m,p), h(p)*xxxx(var)) =l= hmax*produceeee(m);

* steady-state stock
stockballll(m,p).. storeeee(m--1,p) + buyyyy(m,p) =e= sum(var$var_map(var,m,p), xxxx(var)) + storeeee(m,p);
final_stockkkk(p).. sum(m$(ord(m)=card(m)),storeeee(m,p)) =e= stock(p);


disj_ineqqqq(kie(ki(k,i),e)).. sum(var$(A(k,i,e,var)<>0),A(kie,var)*xxxx(var)) =l= b(kie) + opt_bigm(k,i,e)*(1-yyyy(ki));
sum_binnnn(k).. sum(ki(k,i),yyyy(ki)) =e= 1;

model probbbb / defobjjjj,defusepvvvv,defusepnvvvv,defproduceeee,defhminnnn,defhmaxxxx,stockballll,sum_binnnn,disj_ineqqqq,final_stockkkk /;

storeeee.up(m,p)    = maxstore;
xxxx.up(var) = ub(var);
xxxx.lo(var) = lb(var);

set kInfeas(k,i);kInfeas(k,i)=no;

loop(ki,
   yyyy.lo(k,i)=0;
   yyyy.fx(ki)=1;
   solve probbbb using rmip min costttt;
   if(probbbb.modelstat<>1,kInfeas(ki)=yes;);
);
yyyy.lo(k,i)=0;

ki(kInfeas)=no;
kie(kInfeas,e) =no;

b(kInfeas,e) = 0;
A(kInfeas,e,var) = 0;
*start B&B
kv(k,var)=no;
kv(k,var)$( sum((i,e)$(A(k,i,e,var)<>0),1)>=1 )=yes;

execute_unload "prob_data_%seed%" A,b,c,ub,lb;

$exit

$include seed.gms
*execseed = 14;

SETS  p  jobs    / 1*6 /
      J  stages  / 1*7 /;

ALIAS (p,pp,var),(J,M);
PARAMETER TAU(p,J) processing time of job p in stage j;
TAU(p,J)=UniformInt(1,50)*UniformInt(0,1);

Set k disjunctions (1+2+...+p-1) /1*90/
    i  disjunctive terms  /1*2/
    e max equations in disjunction /1*1/
    ki(k,i)  set that contains disjunctions and terms
    kie(k,i,e) set that contains disjunctions terms and equations
    kv(k,var) set that contains disjunctions and variables
;
parameter term(k), eq_term(k,i), A(k,i,e,var), b(k,i,e), ub(var), lb(var);
scalar cnt1 /1/
       tot_k;
tot_k=card(k);

ki(k,i)=yes;
kie(k,i,e)=yes;

loop((p,pp,J)$((ORD(p) LT ORD(pp)) AND TAU(p,J) and TAU(pp,J)),
   A(k,'1','1',var)$(ord(k)=cnt1 and ord(var)=ord(p))  = 1;
   A(k,'1','1',var)$(ord(k)=cnt1 and ord(var)=ord(pp)) = -1;
   b(k,'1','1')$(ord(k)=cnt1)  = SUM(M$(ORD(M) LT ORD(J)), TAU(pp,M)) - SUM(M$(ORD(M) LE ORD(J)), TAU(p,M));

   A(k,'2','1',var)$(ord(k)=cnt1 and ord(var)=ord(pp))  = 1;
   A(k,'2','1',var)$(ord(k)=cnt1 and ord(var)=ord(p)) = -1;
   b(k,'2','1')$(ord(k)=cnt1)  = SUM(M$(ORD(M) LT ORD(J)), TAU(p,M)) - SUM(M$(ORD(M) LE ORD(J)), TAU(pp,M));

   cnt1=cnt1+1;
);

scalar useless_k;  useless_k = cnt1;

loop(k$(ord(k)>=cnt1),
   A(k,i,'1',var) = -1;
   b(k,i,'1') = 0;
);

kv(k,var)$( sum((i,e)$(A(k,i,e,var)<>0),1)>=1 )=yes;

lb(var)=0;
ub(var)=SUM((p,J),TAU(p,J));

execute_unload "prob_data_%seed%" A,b,ub,lb;

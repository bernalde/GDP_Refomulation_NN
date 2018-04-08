
SETS  p  jobs    / 1*4 /
      J  stages  / 1*4 /;

ALIAS (p,pp,var),(J,M);
PARAMETER TAU(p,J) processing time of job p in stage j;
TAU(p,J)=UniformInt(0,10);

Set k disjunctions  /1*24/
    i  disjunctive terms  /1*2/
*    var variables (p) /1*4/
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

loop(k$(ord(k)>=cnt1),
   A(k,i,'1',var) = -1;
   b(k,i,'1') = 0;
);

kv(k,var)$( sum((i,e)$(A(k,i,e,var)<>0),1)>=1 )=yes;

lb(var)=0;
ub(var)=SUM((p,J)$(ord(p)=ord(var)),TAU(p,J));



VARIABLE            cost  ;
positive variables  x(var);
Binary variable     y(k,i);


EQUATIONS
   FEAS(var)           makespan greater than all processing times
   sum_bin
   disj_ineq
;

FEAS(var).. cost =G= x(var) + SUM(M, TAU(var,M))  ;
disj_ineq(kie(ki(k,i),e)).. sum(var$(A(k,i,e,var)<>0),A(kie,var)*x(var)) =l= b(kie) + sum(var$(A(k,i,e,var)<>0),ub(var))*(1-y(ki));
sum_bin(k).. sum(ki(k,i),y(ki)) =e= 1;


model prob / feas,sum_bin,disj_ineq /;

option optcr = 0.001
       reslim = 72000
*       mip=BDMLP
*       mip=CBC
*       mip=SCIP
*       rmip=CBC
  ;
*prob.nodlim=1000000;

x.lo(var) = lb(var);
x.up(var) = ub(var);

*y.fx(k,'1')$(ord(k)<=10)=1;
*y.fx('1','1')=1;

$include max_time_ref

scalar rel,sol,nodes,time,LBL,const,vars,bin;

solve prob using rmip min cost;
rel = prob.objval;
bin=sum(ki,1);

solve prob using mip min cost;
sol = prob.objval;
time = prob.etsolve;
nodes = prob.nodusd;
LBL  = prob.objest;
const = prob.numequ;
vars = prob.numvar;

$exit

execute_unload "res_prob " rel,sol,nodes,time,LBL,const,vars,bin;





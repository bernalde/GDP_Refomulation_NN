VARIABLE            cost  ;
positive variables  x(var);
Binary variable     y(k,i);


EQUATIONS
   obj           makespan greater than all processing times
   sum_bin
   disj_ineq
   eq_useless_k
;

obj(var).. cost =G= x(var) + SUM(M, TAU(var,M))  ;
disj_ineq(kie(ki(k,i),e)).. sum(var$(A(k,i,e,var)<>0),A(kie,var)*x(var)) =l= b(kie) + SUM((p,J),TAU(p,J))*(1-y(ki));
sum_bin(k).. sum(ki(k,i),y(ki)) =e= 1;
eq_useless_k(k)$(ord(k)>=useless_k).. y(k,'1') =e= 1;


model prob / obj,sum_bin,disj_ineq,eq_useless_k /;

option optcr = 0.001
       reslim = 72000
*       mip=BDMLP
*       mip=CBC
*       mip=SCIP
*       rmip=CBC
  ;
*prob.nodlim=1000000;

prob.optfile = 1;

x.lo(var) = lb(var);
x.up(var) = ub(var);

*y.fx(k,'1')$(ord(k)<=10)=1;
*y.fx(k,'1')=1;

$include max_time_ref

scalar rel,sol,nodes,time,cpu,LBL,const,vars,bin;

solve prob using rmip min cost;
rel = prob.objval;
bin=sum(ki,1);

solve prob using mip min cost;
sol = prob.objval;
time = prob.etsolve;
cpu = prob.resUsd;
nodes = prob.nodusd;
LBL  = prob.objest;
const = prob.numequ;
vars = prob.numvar;

execute_unload "res_prob" rel,sol,nodes,time,cpu,LBL,const,vars,bin;




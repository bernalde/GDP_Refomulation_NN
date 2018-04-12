
variables cost, x(var);
binary variable y(k,i);
equation obj, disj_ineq(k,i,e), sum_bin(k);
*disj_eq_1(k,i,ee), disj_eq_2(k,i,ee);

obj.. cost =e= sum(var,c(var)*x(var));
disj_ineq(kie(ki(k,i),e)).. sum(var$(A(k,i,e,var)<>0),A(kie,var)*x(var)) =l= b(kie) + (sum(var$kv(k,var),x.up(var))+1)*(1-y(ki));
*disj_eq_1(kiee(ki,ee)).. sum(var,AE(kiee,var)*x(var)) =l= bE(kiee) + (sum(var$AE(kiee,var),x.up(var))+1)*(1-y(ki));
*disj_eq_2(kiee(ki,ee)).. sum(var,AE(kiee,var)*x(var)) =g= bE(kiee) - (sum(var$AE(kiee,var),x.up(var))+1)*(1-y(ki));

sum_bin(k).. sum(ki(k,i),y(ki)) =e= 1;

model prob /obj,disj_ineq,sum_bin/;

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
*y.fx('1','1')=1;

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

execute_unload "BigM"





Variables
     produce(m)    production of blended and refined oil per month
     buy(m,p)      purchase of raw oil per month
     store(m,p)    storage of raw oil at end of the month
     cost        objective variable
     x(var);
Positive variables produce, buy, store, use;
Binary variable y(k,i);

Equations
     defobj        objective
     defusepv(m)   maximum use of vegetable oils
     defusepnv(m)  maximum use of non-vegetable oils
     defproduce(m) production of refined oil
     defhmin(m)    minmum hardness requirement
     defhmax(m)    maximum hardness requirement
     stockbal(m,p) stock balance constraint
     final_stock
     sum_bin
     disj_ineq

;

defobj..        cost =e= -  sum(m, sp*produce(m))
                           + sum((m,p), cost_param(m,p)*buy(m,p))
                           + sum((m,p), sc*store(m,p));

defusepv(m)..   sum((pv,var)$var_map(var,m,pv), x(var)) =l= maxusepv;

defusepnv(m)..  sum((pnv,var)$var_map(var,m,pnv), x(var)) =l= maxusepnv;

defproduce(m).. produce(m) =e= sum((var,p)$var_map(var,m,p), x(var));

defhmin(m)..    sum((var,p)$var_map(var,m,p), h(p)*x(var)) =g= hmin*produce(m);

defhmax(m)..    sum((var,p)$var_map(var,m,p), h(p)*x(var)) =l= hmax*produce(m);

* steady-state stock
stockbal(m,p).. store(m--1,p) + buy(m,p) =e= sum(var$var_map(var,m,p), x(var)) + store(m,p);
final_stock(p).. sum(m$(ord(m)=card(m)),store(m,p)) =e= stock(p);


disj_ineq(kie(ki(k,i),e)).. sum(var$(A(k,i,e,var)<>0),A(kie,var)*x(var)) =l= b(kie) + opt_bigm(k,i,e)*(1-y(ki));
sum_bin(k).. sum(ki(k,i),y(ki)) =e= 1;

model prob / defobj,defusepv,defusepnv,defproduce,defhmin,defhmax,stockbal,sum_bin,disj_ineq,final_stock /;

store.up(m,p)    = maxstore;
x.up(var) = ub(var);
x.lo(var) = lb(var);
*y.fx(k,'11')=1;

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
*y.fx(k,'14')=1;

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





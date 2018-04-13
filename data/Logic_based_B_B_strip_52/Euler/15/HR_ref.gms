
variables cost, x(var), ni(k,i,var);
binary variable y(k,i);
equation obj, disj_ineq(k,i,e), sum_bin(k), disag(k,var), bound_up(k,i,var), bound_lo(k,i,var);
*, disj_eq(k,i,ee);

obj(ge)$(ord(ge)<=boxes_param).. cost =g= sum(var,Aglob(ge,var)*x(var))+bglo(ge);
disag(k,var)$kv(k,var).. x(var) =e= sum(ki(k,i),ni(ki,var));
disj_ineq(kie(ki,e)).. sum(var$(A(kie,var)<>0),A(kie,var)*ni(ki,var)) =l= b(kie)*y(ki);
*disj_eq(kiee(ki,ee)).. sum(var$AE(kiee,var),AE(kiee,var)*ni(ki,var)) =e= bE(kiee)*y(ki);
sum_bin(k)$(sum(ki(k,i),1)>=1).. sum(ki(k,i),y(ki)) =e= 1;
bound_up(ki(k,i),var)$kv(k,var).. ni(ki,var) =l= x.up(var)*y(ki);
bound_lo(ki(k,i),var)$kv(k,var).. ni(ki,var) =g= x.lo(var)*y(ki);

model prob /obj,disag,disj_ineq,sum_bin,bound_up,bound_lo/;


option optcr = 0.001
       reslim = 7200
*       mip=BDMLP
*       mip=CBC
*       rmip=CBC
  ;
*prob.nodlim=1000000;

prob.optfile=1;

x.lo(var) = lb(var);
x.up(var) = ub(var);

ni.up(ki(k,i),var)$kv(k,var) = ub(var);

$include max_time_ref
*y.fx('1','1')=1;

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



positive variables it(t), f(t,r), ix(t,r);
Variables
     cost        objective variable
     x(var)
     ni(k,i,var);
Binary variable y(k,i);


equation obj, disj_ineq(k,i,e), sum_bin(k), disag(k,var), bound_up(k,i,var), bound_lo(k,i,var)
     eq2
     eq3
     eq4
     eq5
;


obj.. cost =e= sum(t,IC(t)*it(t)) + sum(map_var_c(var,t,r),x(var));
eq2(t).. it(t) =e= sum(r,ix(t,r));
eq3(t,r).. - f(t,r) =l= -D(t,r);
eq4(t,r).. ix(t,r) =e= ix(t-1,r)$(ord(t)>1) + sum(map_var_x(var,t,r),x(var)) - f(t,r);
eq5(t,r)$(ord(t)>=2)..  sum((k,i)$logic_left(t,r,k,i),y(k,i)) =e= sum((tt,k,i)$logic_right(t,r,k,tt,i),y(k,i));

disag(k,var)$kv(k,var).. x(var) =e= sum(ki(k,i),ni(ki,var));
disj_ineq(kie(ki,e)).. sum(var$(A(kie,var)<>0),A(kie,var)*ni(ki,var)) =l= b(kie)*y(ki);
*disj_eq(kiee(ki,ee)).. sum(var$AE(kiee,var),AE(kiee,var)*ni(ki,var)) =e= bE(kiee)*y(ki);
sum_bin(k).. sum(ki(k,i),y(ki)) =e= 1;
bound_up(ki(k,i),var)$kv(k,var).. ni(ki,var) =l= x.up(var)*y(ki);
bound_lo(ki(k,i),var)$kv(k,var).. ni(ki,var) =g= x.lo(var)*y(ki);

model prob /obj,disag,disj_ineq,sum_bin,bound_up,bound_lo, eq2, eq3, eq4, eq5, /;


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
*y.fx(k,'11')=1;

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



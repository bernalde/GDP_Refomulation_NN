variables cost, cost2, x(var), ni(k,i,var);
binary variable y(k,i);
equation obj, disj_ineq(k,i,e), sum_bin(k), disj_ineq_hr(k,i,e), disag(k,var), bound_up(k,i,var), bound_lo(k,i,var)
     disj_fix
     eq_useless_k
;
equation obj2;
alias (level,level2,k,kk),(i,ii,iii),(ki,ki2);
set node(level,k,i),cur_node(k,i),alive_ki(k,i);alive_ki(ki)=yes;node(level,k,i)=no;cur_node(k,i)=no;
alias (node,node2);
parameter lambda(k,var);lambda(k,var)=0;

obj(var).. cost =G= x(var) + SUM(M, TAU(var,M))  ;

disj_ineq(k,i,e)$(kie(k,i,e) and alive_ki(k,i)).. sum(var$(A(k,i,e,var)<>0),A(k,i,e,var)*x(var)) =l= b(k,i,e) + SUM((p,J),TAU(p,J))*(1-y(k,i));
disj_fix(k,i,e)$(kie(k,i,e) and cur_node(k,i)).. sum(var$(A(k,i,e,var)<>0),A(k,i,e,var)*x(var)) =l= b(k,i,e);

disag(k,var)$(kv(k,var) and (sum(alive_ki(k,i),1)>=1) ).. x(var) =e= sum(ki(k,i),ni(ki,var));
disj_ineq_hr(k,i,e)$(kie(k,i,e) and alive_ki(k,i)).. sum(var$(A(k,i,e,var)<>0),A(k,i,e,var)*ni(k,i,var)) =l= b(k,i,e)*y(k,i);
bound_up(ki(k,i),var)$(kv(k,var) and alive_ki(ki) ).. ni(ki,var) =l= x.up(var)*y(ki);
bound_lo(ki(k,i),var)$(kv(k,var) and alive_ki(ki) ).. ni(ki,var) =g= x.lo(var)*y(ki);

eq_useless_k(k)$(ord(k)>=useless_k).. y(k,'1') =e= 1;

obj2.. cost2 =e= cost
                + sum((k,var)$(kv(k,var) and (sum(alive_ki(k,i),1)>=1) ),lambda(k,var)*(x(var) - sum(ki(k,i),ni(k,i,var))))
;


sum_bin(k).. sum(ki(k,i),y(ki)) =e= 1;

option optcr = 0.001
       reslim = 7200
*       rmip=cbc
  ;

model bigM /obj, disj_ineq, disj_fix, sum_bin, eq_useless_k/;
model chull /obj, disag, disj_ineq_hr, bound_up, bound_lo, disj_fix, sum_bin, eq_useless_k/;
model lagdual /obj, obj2, disj_ineq_hr, bound_up, bound_lo, disj_fix, sum_bin, eq_useless_k/;

x.lo(var) = lb(var);
x.up(var) = ub(var);

*y.fx(k,'1')=1;

*$include max_time_ref


*code sets and parameters
set numm /1*100000/,nnode(numm,k,k,i);nnode(numm,k,k,i)=no;
set numm_aux1(numm), numm_aux2(numm); numm_aux1(numm)=no;numm_aux2(numm)=no;
set nnode2(numm,k,k,i);nnode2(numm,k,k,i)=no;
alias(numm,numm2);
set chec_int_k(k),k_select(k);

parameter chec_int(k,i), chec_int2(k,i), opt_y(k,i), opt_x(var), no_ki_param(k,i),lag_param(k);
*node_val(k,k,i),node_stat(k,k,i),node_int(k,k,i);
parameter node_val(numm),node_stat(numm),node_int(numm), parent_val(numm),parent_lambda(numm,k,var),lambda_node(numm,k,var);lambda_node('1','1','1')=0; parent_lambda('1','1','1')=0;

scalar tol /1e-6/
       gap /1e-3/
       int_sol
       int_sol2
       int_sol3
       check_opt
       min_i
       UBP /1e10/
       LBP
       new_UB
       aux1
       aux2      /0/
       aux3
       cnt_nodes /1/
       time_start
       time_wall
       time_solve /0/
       cnt_calculate_LB /1/
       calculate_LB  /15/
       first_inter
       first_inter_val
       aux_inter /0/
       best_inter
       best_inter_cnt /0/
       time_limit /7200/
;
*sets and paraemeters to save results
parameter max_nod(k);max_nod('1')=0;
set time_set /1*30000/
    resu /N_nodes,LB,UB/;
parameter tot_results_w_time(time_set,resu),tot_results_s_time(time_set,resu);

term(k)=sum(ki(k,i),1);
aux2=1;lag_param(k)=0;aux1=2;
*Rule 1
loop(k, if(ord(k)=aux2,lag_param(k)=1;aux2=aux2+aux1;aux1=aux1+1;););
*Rule 2
*loop(k,if(aux2=1,lag_param(k)=1;aux2=-1;);aux2=aux2+1;);
aux2=0;aux1=1;
lag_param(k)$(ord(k)=card(k))=0;
*lag_param(k)=1;
lag_param(k)=0;
*lag_param('1')=1;

time_start = jnow;

solve chull using rmip min cost;
time_solve = time_solve + chull.etsolve;

*Check integrality
chec_int(k,i)=0; int_sol=0;
loop(ki, if((y.l(ki)>=1-tol or y.l(ki)<=tol),chec_int(ki)=1););
chec_int_k(k)=no;
if(sum(ki,chec_int(ki))=sum(ki,1),int_sol=1; else chec_int_k(k)=yes; );
check_opt=int_sol;
if(int_sol=0,LBP=chull.objval;);
if(int_sol=1,UBP=chull.objval;);
node_val('1') = LBP;

lambda(k,var)$(kv(k,var) and (sum(alive_ki(k,i),1)>=1) ) = -disag.m(k,var);
solve lagdual using rmip min cost2;
y.fx(ki)=y.l(ki);
solve bigM using rmip min cost;
time_solve = time_solve + BigM.etsolve + lagdual.etsolve;
time_wall = (jnow-time_start)*3600*24;

y.up(ki)=1;y.lo(ki)=0;
chec_int2(k,i)=0; int_sol2=0;
loop(ki2, if((y.l(ki2)>=1-tol or y.l(ki2)<=tol),chec_int2(ki2)=1););
if(sum(ki2,chec_int2(ki2))=sum(ki2,1),int_sol2=1;);
if(BigM.modelstat<>1,int_sol2=0;);
if(int_sol2=1,
   if(bigM.objval<UBP,UBP=bigM.objval;opt_y(ki)=y.l(ki); opt_x(var)=x.l(var););
   if(aux_inter=0,first_inter=cnt_nodes-1;first_inter_val=UBP;aux_inter=1;);
);

*report node 0
tot_results_w_time(time_set,'UB')$(ord(time_set)=round(time_wall,0)) =  UBP ;
tot_results_w_time(time_set,'LB')$(ord(time_set)=round(time_wall,0)) =  LBP ;
tot_results_w_time(time_set,'N_nodes')$(ord(time_set)=round(time_wall,0)) =  0 ;
tot_results_s_time(time_set,'UB')$(ord(time_set)=round(time_solve,0)) =  UBP ;
tot_results_s_time(time_set,'LB')$(ord(time_set)=round(time_solve,0)) =  LBP ;
tot_results_s_time(time_set,'N_nodes')$(ord(time_set)=round(time_solve,0)) =  0 ;


loop(level2$(ord(level2)<=card(k) and check_opt=0 and time_solve<time_limit),
   aux3=ord(level2);
*decide branching disjunction
   k_select(k)=no;
   min_i = smin(chec_int_k(k),term(k));
   aux1=0;
   loop(k$(term(k)=min_i and aux1=0 and chec_int_k(k)),k_select(k) = yes; aux1=1;);
   chec_int_k(k_select) = no;

*Create nodes
   node(level2,ki(k_select(k),i))$(ord(level2)=aux3) = yes;
*node(level2,ki(k_select(k),i)) = yes;
   no_ki_param(ki)=sum(level,node(level,ki));
   alive_ki(ki)$no_ki_param(ki)=no;

   nnode2(numm,kk,k,i)$(ord(numm)<=aux2)=no;
   aux1=1;
*   aux2=1;

   if(aux3=1,
      loop(node(level2,k,i)$(ord(level2)=1),
         nnode2(numm,level2,k,i)$(ord(numm)=aux1)=yes;
         aux1=aux1+1;
      );
   parent_val(numm)$(ord(numm)<aux1) = LBP;
   );

*$ontext
   numm_aux1(numm)$(sum(nnode(numm,level,k,i),1)>=1)=yes;

   loop(numm_aux1,
      loop(node(level2,kk,ii)$(ord(level2)=aux3),
         numm_aux2(numm2)$(ord(numm2)=aux1)=yes;
         nnode2(numm_aux2,level,k,i)$nnode(numm_aux1,level,k,i)=yes;
         nnode2(numm_aux2,level2,kk,ii)=yes;
         parent_val(numm_aux2) = node_val(numm_aux1);
         parent_lambda(numm_aux2,k,var) = lambda_node(numm_aux1,k,var);
         if(aux3=1,parent_lambda(numm_aux2,k,var) = lambda(k,var););
         numm_aux2(numm2)$(ord(numm2)=aux1)=no;
         aux1=aux1+1;
      );
   );
   numm_aux1(numm)$(sum(nnode(numm,level,k,i),1)>=1)=no;
*$offtext


   aux2=aux1;
   max_nod(level2)=aux2-1;
   nnode(numm,kk,k,i)=no;nnode(nnode2)=yes;

*Solve nodes
   chec_int_k(k)=no;
   new_UB=0;

   node_val(numm)$(sum(nnode(numm,level,kk,ii),1)>=1) = parent_val(numm);

   loop(numm$(sum(nnode(numm,level,kk,ii),1)>=1 and time_solve<time_limit),

      if((parent_val(numm)<=(1-gap)*UBP) or (parent_val(numm)<=(1+gap)*UBP),
         chec_int(k,i)=0; int_sol=0; int_sol3=0;
         cur_node(k,i)=no;
         y.lo(k,i)=0;y.up(k,i)=1;
         loop(nnode(numm,level,kk,ii),cur_node(kk,ii)=yes;y.fx(kk,ii)=1);
*$ontext
**************** Option 1
         solve BigM using rmip min cost; time_solve = time_solve + BigM.etsolve;
         loop(ki2, if((y.l(ki2)>=1-tol or y.l(ki2)<=tol),chec_int(ki2)=1););
         if(sum(ki2,chec_int(ki2))=sum(ki2,1),int_sol3=1;);
         if(BigM.modelstat<>1,int_sol3=0;);

         if((lag_param(level2)=1 and BigM.modelstat=1 and int_sol3=0),
            solve chull using rmip min cost;
            lambda(k,var)$(kv(k,var) and (sum(alive_ki(k,i),1)>=1) ) = -disag.m(k,var); time_solve = time_solve + chull.etsolve;
         );
         if((lag_param(level2)=0 or int_sol3=1),
             lambda(k,var)$(kv(k,var) and (sum(alive_ki(k,i),1)>=1) ) = parent_lambda(numm,k,var);
         );
         lambda_node(numm,k,var)$(kv(k,var) and (sum(alive_ki(k,i),1)>=1) ) = lambda(k,var);

         time_wall = (jnow-time_start)*3600*24;
         cnt_nodes = cnt_nodes+1;

         if((lag_param(level2)=1 and BigM.modelstat=1 and int_sol3=0), node_val(numm)= chull.objval;node_stat(numm)= chull.modelstat;);
         if((lag_param(level2)=0 or BigM.modelstat<>1 or int_sol3=1), node_val(numm)= max(BigM.objval,parent_val(numm));node_stat(numm)= BigM.modelstat;);
         chec_int(k,i)=0; int_sol=0;
         loop(ki2, if((y.l(ki2)>=1-tol or y.l(ki2)<=tol),chec_int(ki2)=1););
         if(sum(ki2,chec_int(ki2))=sum(ki2,1),int_sol=1; else chec_int_k(k)=yes;);
         if(BigM.modelstat<>1,int_sol=0;);
         if((lag_param(level2)=1 and BigM.modelstat=1), if(chull.modelstat<>1,int_sol=0;););
         node_int(numm)=int_sol;
         new_UB=int_sol;
         if(int_sol=1,
            if((lag_param(level2)=1 and int_sol3=0), if(chull.objval<UBP,UBP=chull.objval;opt_y(ki)=y.l(ki); opt_x(var)=x.l(var);best_inter=cnt_nodes-1;););
            if((lag_param(level2)=0 or int_sol3=1), if(BigM.objval<UBP,UBP=BigM.objval;opt_y(ki)=y.l(ki); opt_x(var)=x.l(var);best_inter=cnt_nodes-1;););
            if(aux_inter=0,first_inter=cnt_nodes-1;first_inter_val=UBP;aux_inter=1;);
         );


* New part with Lagrangean dual
         if((BigM.modelstat=1 and ord(level2)<tot_k and int_sol3=0 and int_sol=0),
            solve lagdual using rmip min cost2;
            time_solve = time_solve + lagdual.etsolve;
            if(lag_param(level2)=0, node_val(numm)= max(BigM.objval,lagdual.objval,parent_val(numm)););
            y.fx(ki)=y.l(ki);
            solve bigM using rmip min cost;
            time_solve = time_solve + BigM.etsolve;
            y.up(ki)=1;y.lo(ki)=0;
            chec_int2(k,i)=0; int_sol2=0;
            loop(ki2, if((y.l(ki2)>=1-tol or y.l(ki2)<=tol),chec_int2(ki2)=1););
            if(sum(ki2,chec_int2(ki2))=sum(ki2,1),int_sol2=1;);
            if(BigM.modelstat<>1,int_sol2=0;);
            if(int_sol2=1,
               if(bigM.objval<UBP,UBP=bigM.objval;opt_y(ki)=y.l(ki); opt_x(var)=x.l(var);best_inter=cnt_nodes-1;);
               if(aux_inter=0,first_inter=cnt_nodes-1;first_inter_val=UBP;aux_inter=1;);
            );
         );

*printing solution
         if(cnt_calculate_LB=calculate_LB,
            LBP = smin(numm2$(sum(nnode(numm2,level,kk,ii),1)>=1 and ((node_stat(numm2)=1 and node_int(numm2)<>1) or ord(numm2)>ord(numm)) and node_val(numm2)<=UBP),node_val(numm2));
            cnt_calculate_LB=-1;
         );
         cnt_calculate_LB = cnt_calculate_LB+1;
         tot_results_w_time(time_set,'UB')$(ord(time_set)=round(time_wall,0)) =  UBP ;
         tot_results_w_time(time_set,'LB')$(ord(time_set)=round(time_wall,0)) =  LBP ;
         tot_results_w_time(time_set,'N_nodes')$(ord(time_set)=round(time_wall,0)) =  cnt_nodes-1 ;
         tot_results_s_time(time_set,'UB')$(ord(time_set)=round(time_solve,0)) =  UBP ;
         tot_results_s_time(time_set,'LB')$(ord(time_set)=round(time_solve,0)) =  LBP ;
         tot_results_s_time(time_set,'N_nodes')$(ord(time_set)=round(time_solve,0)) =  cnt_nodes-1 ;
      else node_val(numm) = parent_val(numm);
      );
   );

*Remove nodes
   nnode(numm,level,kk,ii)$(node_stat(numm)<>1)=no;
   nnode(numm,level,kk,ii)$(node_int(numm)=1)=no;
   nnode(numm,level,kk,ii)$((node_val(numm)>=(1-gap)*UBP) or (node_val(numm)>=(1+gap)*UBP))=no;
*   LBP = smin(numm2$(sum(nnode(numm2,level,kk,ii),1)>=1 and node_stat(numm2)=1 and node_int(numm2)<>1),node_val(numm2));

   chec_int_k(k)$(sum(alive_ki(k,i),1)=0)=no;

   if(sum(nnode(numm,level,kk,ii),1)=0,check_opt=1;);
   execute_unload "res_B_B_LAG_k0 " tot_results_w_time,tot_results_s_time,first_inter,first_inter_val,best_inter,opt_y,opt_x,max_nod;

);

execute_unload "res_B_B_LAG_k0 " tot_results_w_time,tot_results_s_time,first_inter,first_inter_val,best_inter,opt_y,opt_x,max_nod,check_opt,UBP,LBP;

LBP = min(LBP,UBP);
scalar sol,nodes,time,LBL,first,best,const,vars,bin;
sol = UBP;
nodes = cnt_nodes-1;
time  = time_solve;
LBL   = LBP;
first = first_inter;
best  = best_inter;

execute_unload "res_prob " sol,nodes,time,LBL,first,best;

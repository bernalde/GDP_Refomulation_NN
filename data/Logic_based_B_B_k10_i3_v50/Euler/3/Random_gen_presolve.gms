$include seed.gms
*execseed = 14;


set
    var variables /1*50/
    k   disjunctions /1*10/
    i   max number of terms per disjunction /1*3/
    e   max number of equations per disjunction /1*20/
*    var variables /1*15/
*    k   disjunctions /1*5/
*    i   max number of terms per disjunction /1*10/
*    e   max number of equations per disjunction /1*50/

    ee  max number of equality disjunctions     /1*10/
    ki(k,i)  set that contains disjunctions and terms
    kie(k,i,e) set that contains disjunctions terms and equations
*    kiee(k,i,ee) set that contains disjunctions terms and equations
    kv(k,var) set that contains disjunctions and variables
 ;

parameter term(k), eq_term(k,i), A(k,i,e,var), b(k,i,e), c(var), ub(var), lb(var), AE(k,i,ee,var), bE(k,i,ee), eeq_term(k,i);
scalar disp the higher the most variables are related to disjunctions /10/
       tot_k
       tot_i
       tot_e
       tot_var
;

*tot_k    = UniformInt(2,card(k));
*tot_i    = UniformInt(2,card(i));
*tot_e    = UniformInt(2,card(e));
*tot_var  = UniformInt(2,card(var));
tot_k    = card(k);
tot_i    = card(i);
tot_e    = card(e);
tot_var  = card(var);

term(k) = UniformInt(2,tot_i);
ki(k,i)=no;
loop((k,i)$(ord(i)<=term(k)), ki(k,i)=yes;);

eq_term(ki) = UniformInt(round(tot_e/5,0),tot_e);
*eq_term(ki) = UniformInt(round(tot_e/10,0),tot_e);
kie(k,i,e)=no;
loop((ki,e)$(ord(e)<=eq_term(ki)), kie(ki,e)=yes;);

*eeq_term(ki) = UniformInt(2,card(ee));
*kiee(k,i,ee)=no;
*loop((ki,ee)$(ord(ee)<=eq_term(ki)), kiee(ki,ee)=yes;);

kv(k,var)=no;

loop(kie(k,i,e),
   b(k,i,e) = UniformInt(-100,100)/100;
   loop(var,
*      A(k,i,e,var) = UniformInt(-100,100)/100*round(UniformInt(0,10-10*round(abs( (ord(var)-ord(k)*card(var)/card(k))/card(var)),1))/disp,0)*UniformInt(0,1);
*      A(k,i,e,var) = UniformInt(-100,100)/100*round(UniformInt(0,10-10*round(abs( (ord(var)-ord(k)*card(var)/card(k))/card(var)),1))/disp,0);
      A(k,i,e,var) = UniformInt(-100,100)/100*round(UniformInt(0,10-10*round(abs( (ord(var)-ord(k)*card(var)/card(k))/card(var)),1))/disp,0)*UniformInt(0,1);
*      A(k,i,e,var) = UniformInt(-100,100)/100*UniformInt(0,1);
   );
);

*loop(kiee(k,i,ee),
*   bE(k,i,ee) = UniformInt(10,100)/10;
*   loop(var,
*      A(k,i,e,var) = UniformInt(-100,100)/100*round(UniformInt(0,10-10*round(abs( (ord(var)-ord(k)*card(var)/card(k))/card(var)),1))/disp,0)*UniformInt(0,1)*UniformInt(0,1)*UniformInt(0,1);
*      AE(k,i,ee,var) = UniformInt(-100,100)/100*round(UniformInt(0,10-10*round(abs( (ord(var)-ord(k)*card(var)/card(k))/card(var)),1))/20,0)*UniformInt(0,1);
*      A(k,i,e,var) = UniformInt(-100,100)/100*UniformInt(0,1);
*   );
*);

*bE(k,i,ee)$(sum(var$AE(k,i,ee,var),1)<=1)=0;
*bE(k,i,ee) = 0;
*bE(k,i,ee) = sum(var,AE(k,i,ee,var));

*kv(k,var)$((sum((i,e)$A(k,i,e,var),1)>=1) OR (sum((i,ee)$AE(k,i,ee,var),1)>=1))=yes;
kv(k,var)$( sum((i,e)$(A(k,i,e,var)<>0),1)>=1 )=yes;

*parameter aux(k,var);
*aux(k,var) = round(UniformInt(0,10-10*round(abs( (ord(var)-ord(k)*card(var)/card(k))/card(var)),1))/15,0);
*display aux;
*aux(k,var) = round(abs( (ord(var)-ord(k))/card(k) ),1);

c(var) = UniformInt(-100,100)/100*UniformInt(0,1);
ub(var) = UniformInt(10,100);
lb(var) = UniformInt(-100,-10);

variables costtt, xxx(var);
binary variable yyy(k,i);
equation objjj, disj_ineqqq(k,i,e), sum_binnn(k);

objjj.. costtt =e= 0;
disj_ineqqq(k,i,e)$kie(k,i,e).. sum(var$A(k,i,e,var),A(k,i,e,var)*xxx(var)) =l= b(k,i,e) + (sum(var$kv(k,var),xxx.up(var))+1)*(1-yyy(k,i));
sum_binnn(k).. sum(ki(k,i),yyy(ki)) =e= 1;

model probbb /all/;
probbb.optfile = 1;
$include max_time_ref

xxx.lo(var) = lb(var);
xxx.up(var) = ub(var);

*presolve

set kInfeas(k,i);kInfeas(k,i)=no;

loop(ki,
   yyy.lo(k,i)=0;
   yyy.fx(ki)=1;
   solve probbb using rmip min costtt;
   if(probbb.modelstat<>1,kInfeas(ki)=yes;);
);
yyy.lo(k,i)=0;

eq_term(kInfeas) = no;
ki(kInfeas)=no;
kie(kInfeas,e) =no;

b(kInfeas,e) = 0;
A(kInfeas,e,var) = 0;

term(k) = sum(i,ki(k,i)*1);

*start B&B
kv(k,var)=no;
kv(k,var)$( sum((i,e)$(A(k,i,e,var)<>0),1)>=1 )=yes;

execute_unload "prob_data_%seed%" A,AE,b,bE,c,ub,lb,term,eq_term;

$exit


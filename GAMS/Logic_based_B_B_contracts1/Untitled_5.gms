$include seed.gms

set t time period /1*5/
    r raw materials /1*4/
    i calculate (t+2) /1*6/
    k calculate (r*t) /1*20/
    var variables (2*r*t) /1*40/
    e max equations in disjunction (2*5+2) /1*12/
    ti(t,i)
    tii(t,i,i)
;

alias(i,ii22),(t,tt);
scalar cntttt;
cntttt=card(i);

ti('1',i)=yes;

loop(t$(ord(t)>=2),
   ti(t,i)$(ord(i)<=cntttt)=yes;
   cntttt=cntttt-1;
);

*ti(t,i)$(ord(i)=(cntttt+1) and ord(t)=card(t))=no;

cntttt=card(t);

loop(i$(ord(i)>=3),
   tii('1',i,ii22)$(ord(ii22)<=cntttt and ord(ii22)>=1)=yes;
   cntttt=cntttt-1;
);


loop(t$(ord(t)>1),
   cntttt=card(t);
   loop(ti(t,i)$(ord(i)>=4),
      tii(t,i,ii22)$(ord(ii22)<=cntttt and ord(ii22)>=ord(t))=yes;
      cntttt=cntttt-1;
   );
);


parameter D(t,r)       demand of raw material at t
          IC(t)        inventory cost per time period t
          gamma(t,r)   base price of raw material r  at time t
          betab(t,r)   discount for bulk purchase
          minb(t,r)    minimum purchase for bulk discount
          betal(t,r,i) discount for long term
          minl(t,r,i)  minimum purchase for discount
;

D(t,r)=UniformInt(50,100);
IC(t)=UniformInt(5,20);
gamma(t,r)=UniformInt(10,30);
betab(t,r)=UniformInt(50,100)/1000;
loop(ti(t,i)$(ord(t)=1 and ord(i)>=3),
   betal(t,r,i)$(ord(i)=3)=UniformInt(10,50)/1000;
   betal(t,r,i)$(ord(i)>3)=UniformInt(betal(t,r,i-1)*1000,round(1.5*betal(t,r,i-1)*1000))/1000;
);
loop(ti(t,i)$(ord(t)>1 and ord(i)>3),
   betal(t,r,i)$(ord(i)=4)=UniformInt(10,50)/1000;
   betal(t,r,i)$(ord(i)>4)=UniformInt(betal(t,r,i-1)*1000,round(1.5*betal(t,r,i-1)*1000))/1000;
);

minb(t,r)=UniformInt(50,100);
minl(t,r,i)=UniformInt(50,100);

Set
    ki(k,i)  set that contains disjunctions and terms
    kie(k,i,e) set that contains disjunctions terms and equations
    kv(k,var) set that contains disjunctions and variables
 ;

parameter term(k), eq_term(k,i), A(k,i,e,var), b(k,i,e), c(var), ub(var), lb(var);
scalar cnt1 /1/
       tot_k;

tot_k=card(k);
kie(k,i,e)=no;

set map_ki_tr(t,r,k)
    map_var_x(var,t,r)
    map_var_c(var,t,r);

loop((t,r),
   map_ki_tr(t,r,k)$(ord(k)=cnt1)=yes;
   map_var_x(var,t,r)$(ord(var)=cnt1) = yes;
   map_var_c(var,t,r)$(ord(var)=cnt1+card(t)*card(r)) = yes;
   cnt1=cnt1+1;
);


loop((t,r),
  ki(k,i)$(map_ki_tr(t,r,k) and ti(t,i))=yes;
);

loop((t,r,k)$map_ki_tr(t,r,k),
   A(k,i,e,var)$(ord(i)=1 and ord(e)=1 and map_var_x(var,t,r)) = gamma(t,r);
   A(k,i,e,var)$(ord(i)=1 and ord(e)=1 and map_var_c(var,t,r)) = -1;
   b(k,i,e)    $(ord(i)=1 and ord(e)=1 ) = 0;
   kie(k,i,e)  $(ord(i)=1 and ord(e)=1 ) = yes;

   A(k,i,e,var)$(ord(i)=2 and ord(e)=1 and map_var_x(var,t,r)) = gamma(t,r)*(1-betab(t,r));
   A(k,i,e,var)$(ord(i)=2 and ord(e)=1 and map_var_c(var,t,r)) = -1;
   b(k,i,e)    $(ord(i)=2 and ord(e)=1 ) = 0;
   kie(k,i,e)  $(ord(i)=2 and ord(e)=1 ) = yes;

   A(k,i,e,var)$(ord(i)=2 and ord(e)=2 and map_var_x(var,t,r)) = -1;
   b(k,i,e)    $(ord(i)=2 and ord(e)=2 ) = -minb(t,r);
   kie(k,i,e)  $(ord(i)=2 and ord(e)=2 ) = yes;

   loop(i$(ord(i)>=3),
      cnt1=3;
      loop(tt$(sum(tii(t,i,ii22)$(ord(tt)=ord(ii22)),1)>=1),
         A(k,i,e,var)$(ord(e)=cnt1 and map_var_x(var,tt,r)) = gamma(t,r)*(1-betal(t,r,i));
         A(k,i,e,var)$(ord(e)=cnt1 and map_var_c(var,tt,r)) = -1;
         b(k,i,e)  $(ord(e)=cnt1) = 0;
         kie(k,i,e)$(ord(e)=cnt1) = yes;
         cnt1=cnt1+1;
      );
   );

   loop(i$(ord(i)>=3),
      cnt1=3+card(t);
      loop(tt$(sum(tii(t,i,ii22)$(ord(tt)=ord(ii22)),1)>=1),
         A(k,i,e,var)$(ord(e)=cnt1 and map_var_x(var,tt,r)) = -1;
         b(k,i,e)  $(ord(e)=cnt1) = -minl(t,r,i);
         kie(k,i,e)$(ord(e)=cnt1) = yes;
         cnt1=cnt1+1;
      );
   );
);


kv(k,var)=no;
kv(k,var)$( sum((i,e)$(A(k,i,e,var)<>0),1)>=1 )=yes;

lb(var)=0;
ub(var)=5000;



parameter opt_bigm(k,i,e), logic_left(t,r,k,i),logic_right(t,r,k,tt,i);
logic_left(t,r,k,i)$(ord(t)>=2 and map_ki_tr(t,r,k) and ord(i)=3) = 1;

loop((t,r,k,tt)$(ord(t)>=2 and map_ki_tr(tt,r,k) and ord(tt)<ord(t) ),
   if(ord(tt)=1,
      loop(i$(ord(i)>=3 and ord(i)<=card(t)-ord(t)+3),
         logic_right(t,r,k,tt,i)=1;
      );
   );
   if(ord(tt)>1,
      loop(i$(ord(i)>=4 and ord(i)<=card(t)-ord(t)+4),
         logic_right(t,r,k,tt,i)=1;
      );
   );

);



opt_bigm(k,i,e)=5000;



Variables
     cost        objective variable
     x(var);



positive variables it(t), f(t,r), ix(t,r);
binary variable y(k,i);

equations eq1, eq2, eq3, eq9, eq10, eq14, disj_ineq;

eq1.. cost =e= sum(t,IC(t)*it(t)) + sum(map_var_c(var,t,r),x(var));
eq2(t).. it(t) =e= sum(r,ix(t,r));
eq3(t,r).. - f(t,r) =l= -D(t,r);
eq14(t,r).. ix(t,r) =e= ix(t-1,r)$(ord(t)>1) + sum(map_var_x(var,t,r),x(var)) - f(t,r);
disj_ineq(kie(ki(k,i),e)).. sum(var$(A(k,i,e,var)<>0),A(kie,var)*x(var)) =l= b(kie) + opt_bigm(k,i,e)*(1-y(ki));

eq9(k).. sum(ki(k,i),y(k,i)) =e= 1;
eq10(t,r)$(ord(t)>=2)..  sum((k,i)$logic_left(t,r,k,i),y(k,i)) =e= sum((tt,k,i)$logic_right(t,r,k,tt,i),y(k,i));

model prob /all/;

option optcr = 0;
option limrow=150;

x.up(var) = ub(var);
x.lo(var) = lb(var);

solve prob min cost using mip;





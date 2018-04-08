$include seed.gms
*execseed =         1;

Set box number of boxes /1*4/
    k_orig   disjunctions /1*6/
;
parameter boxes_param;
boxes_param=card(box);
Scalar heigth packing box height;
*heigth=UniformInt(10,20);
heigth=UniformInt(5,7);

Parameter
    h(box) heigth of boxes
    l(box) length of boxes;

loop(box$(ord(box)<=boxes_param),
   h(box) = UniformInt(2,5);
   l(box) = UniformInt(1,10);
);

Alias (box,j);
Alias (box,boxx,jj);

Set i_orig disjuctive term /1*4/
    ij(box,j), ijk(box,j,i_orig);

ij(box,j) = ord(box)<ord(j); ij(box,j)$(ord(box)>boxes_param or ord(j)>boxes_param)=no; ijk(ij,i_orig) = yes;

Set ijX(box,j);
option ijX<ij;

display h,l,heigth;

set
    var variables /1*40/
    e_orig   max number of equations per disjunction /1*3/
    ge  global constraints /1*20/
    ki_orig(k_orig,i_orig)  set that contains disjunctions and terms
    kie_orig(k_orig,i_orig,e_orig) set that contains disjunctions terms and equations
    kv_orig(k_orig,var) set that contains disjunctions and variables
 ;

parameter A_orig(k_orig,i_orig,e_orig,var), b_orig(k_orig,i_orig,e_orig), c(var), ub(var), lb(var), Aglob(ge,var), bglo(ge);
scalar cnt1 /1/
       cnt2 /1/
       cnt3 /1/
       cnt4 /1/
       cnt5 /1/
;


ki_orig(k_orig,i_orig)=no;
loop(ij, ki_orig(k_orig,i_orig)$(ord(k_orig)=cnt1)=yes;cnt1=cnt1+1;);
cnt1=1;

kie_orig(k_orig,i_orig,e_orig)=no;
loop((k_orig,i_orig,e_orig)$ki_orig(k_orig,i_orig),
   if(ord(i_orig)=1 or ord(i_orig)=2, kie_orig(k_orig,i_orig,'1')=yes;);
   if(ord(i_orig)=3 or ord(i_orig)=4, kie_orig(k_orig,i_orig,e_orig)=yes;);
);

display kie_orig;

loop(ge$(ord(ge)<=boxes_param),
   Aglob(ge,var)$(ord(var)=ord(ge)) = 1;
   bglo(ge) = sum(box$(ord(box)=ord(ge)),l(box));
);


kv_orig(k_orig,var)=no;

loop(ij(box,j),
   b_orig(k_orig,'1','1')$(ord(k_orig)=cnt1) = -l(box);
   A_orig(k_orig,'1','1',var)$(ord(k_orig)=cnt1 and ord(var)=ord(box)) = 1;
   A_orig(k_orig,'1','1',var)$(ord(k_orig)=cnt1 and ord(var)=ord(j))   = -1;

   b_orig(k_orig,'2','1')$(ord(k_orig)=cnt1) = -l(j);
   A_orig(k_orig,'2','1',var)$(ord(k_orig)=cnt1 and ord(var)=ord(box)) = -1;
   A_orig(k_orig,'2','1',var)$(ord(k_orig)=cnt1 and ord(var)=ord(j))   = 1;

   b_orig(k_orig,'3','1')$(ord(k_orig)=cnt1) = -h(box);
   A_orig(k_orig,'3','1',var)$(ord(k_orig)=cnt1 and ord(var)=(ord(box)+boxes_param)) = -1;
   A_orig(k_orig,'3','1',var)$(ord(k_orig)=cnt1 and ord(var)=(ord(j)+boxes_param))   = 1;

   b_orig(k_orig,'3','2')$(ord(k_orig)=cnt1) = l(j)-1;
   A_orig(k_orig,'3','2',var)$(ord(k_orig)=cnt1 and ord(var)=ord(box)) = 1;
   A_orig(k_orig,'3','2',var)$(ord(k_orig)=cnt1 and ord(var)=ord(j))   = -1;

   b_orig(k_orig,'3','3')$(ord(k_orig)=cnt1) = l(box)-1;
   A_orig(k_orig,'3','3',var)$(ord(k_orig)=cnt1 and ord(var)=ord(box)) = -1;
   A_orig(k_orig,'3','3',var)$(ord(k_orig)=cnt1 and ord(var)=ord(j))   = 1;

   b_orig(k_orig,'4','1')$(ord(k_orig)=cnt1) = -h(j);
   A_orig(k_orig,'4','1',var)$(ord(k_orig)=cnt1 and ord(var)=(ord(box)+boxes_param)) = 1;
   A_orig(k_orig,'4','1',var)$(ord(k_orig)=cnt1 and ord(var)=(ord(j)+boxes_param))   = -1;

   b_orig(k_orig,'4','2')$(ord(k_orig)=cnt1) = l(j)-1;
   A_orig(k_orig,'4','2',var)$(ord(k_orig)=cnt1 and ord(var)=ord(box)) = 1;
   A_orig(k_orig,'4','2',var)$(ord(k_orig)=cnt1 and ord(var)=ord(j))   = -1;

   b_orig(k_orig,'4','3')$(ord(k_orig)=cnt1) = l(box)-1;
   A_orig(k_orig,'4','3',var)$(ord(k_orig)=cnt1 and ord(var)=ord(box)) = -1;
   A_orig(k_orig,'4','3',var)$(ord(k_orig)=cnt1 and ord(var)=ord(j))   = 1;

   cnt1=cnt1+1;
);

kv_orig(k_orig,var)$( sum((i_orig,e_orig)$(A_orig(k_orig,i_orig,e_orig,var)<>0),1)>=1 )=yes;

loop(box$(ord(box)<=boxes_param),
   ub(var)$(ord(var)=ord(box)) = sum(j, l(j));
   lb(var)$(ord(var)=ord(box)) = 0;
   ub(var)$(ord(var)=(ord(box)+boxes_param)) = heigth;
   lb(var)$(ord(var)=(ord(box)+boxes_param)) = h(box);
);

kie_orig(k_orig,i_orig,e_orig)$(ord(e_orig)>1)=no;

set k /1*2/
    i /1*64/
    e   max number of equations per disjunction /1*9/
    ki(k,i)  set that contains disjunctions and terms
    kie(k,i,e) set that contains disjunctions terms and equations
    kv(k,var) set that contains disjunctions and variables
    bs(k,k_orig,k_orig,k_orig)
;

parameter term(k), eq_term(k,i), A(k,i,e,var), b(k,i,e);

ki(k,i)=no;
ki(k,i)$(ord(i)<=4)=yes;
kie(k,i,e)=no;
cnt1=1;cnt2=1;cnt3=1;cnt4=1;cnt5=1;

alias (k_orig,k_orig2,k_orig3);

bs(k,k_orig,k_orig2,k_orig3)=no;
bs('1','1','2','4')=yes;
bs('2','3','5','6')=yes;

loop(bs(k,k_orig,k_orig2,k_orig3),
   cnt1=1;cnt2=1;cnt3=1;cnt4=1;cnt5=1;
   loop(i,
      loop(kie_orig(k_orig,i_orig,e_orig)$(ord(i_orig)=cnt3),
         A(k,i,e,var)$(ord(e)=cnt2) = A_orig(k_orig,i_orig,e_orig,var);
         b(k,i,e)$(ord(e)=cnt2) = b_orig(k_orig,i_orig,e_orig);
         cnt2=cnt2+1;
      );
      loop(kie_orig(k_orig2,i_orig,e_orig)$(ord(i_orig)=cnt4),
         A(k,i,e,var)$(ord(e)=cnt2) = A_orig(k_orig2,i_orig,e_orig,var);
         b(k,i,e)$(ord(e)=cnt2) = b_orig(k_orig2,i_orig,e_orig);
         cnt2=cnt2+1;
      );
      loop(kie_orig(k_orig3,i_orig,e_orig)$(ord(i_orig)=cnt5),
         A(k,i,e,var)$(ord(e)=cnt2) = A_orig(k_orig3,i_orig,e_orig,var);
         b(k,i,e)$(ord(e)=cnt2) = b_orig(k_orig3,i_orig,e_orig);
         cnt2=cnt2+1;
      );
      kie(k,i,e)$(ord(e)<=cnt2)=yes;
      cnt2=1;
      cnt5=cnt5+1;
      if(cnt5>=5,cnt5=1;cnt4=cnt4+1;);
      if(cnt4>=5,cnt4=1;cnt3=cnt3+1;);
      ki(k,i)=yes;
   );
);

kv(k,var)$( sum((i,e)$(A(k,i,e,var)<>0),1)>=1 )=yes;

execute_unload "prob_data_%seed%" A,Aglob,bglo,b,c,ub,lb;

$exit



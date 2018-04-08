$ontext
Matlab code to general plots and vertices:

clear all;close all;clc;format compact;
x=linspace(0,10);


V=[2 10;1 4; 4 6];
[A,b,Aeq,beq]=vert2lcon(V)
for i=1:3
    x2(i,:)=(-A(i,1)*x+b(i))/A(i,2);
end

V=[3 3; 6 0; 8 7];
[A,b,Aeq,beq]=vert2lcon(V)
for i=1:3
    x3(i,:)=(-A(i,1)*x+b(i))/A(i,2);
end

V=[5 9; 9 9; 10 6];
[A,b,Aeq,beq]=vert2lcon(V)
for i=1:3
    x4(i,:)=(-A(i,1)*x+b(i))/A(i,2);
end

figure(1)
plot(x,x2,'k');hold
plot(x,x3,'b');
plot(x,x4,'r');hold
axis([0 10 0 10])


V=[0 6;4 9;3 4];
[A,b,Aeq,beq]=vert2lcon(V)
for i=1:3
    x2(i,:)=(-A(i,1)*x+b(i))/A(i,2);
end

V=[4 1;6 7; 7 2];
[A,b,Aeq,beq]=vert2lcon(V)
for i=1:3
    x3(i,:)=(-A(i,1)*x+b(i))/A(i,2);
end

V=[10 10;10 7; 7 9];
[A,b,Aeq,beq]=vert2lcon(V)
for i=1:3
    x4(i,:)=(-A(i,1)*x+b(i))/A(i,2);
end

figure(2)
plot(x,x2,'k');hold
plot(x,x3,'b');
plot(x,x4,'r');hold
axis([0 10 0 10])


V=[1 6;6 6;1 3;6 1];
[A,b,Aeq,beq]=vert2lcon(V)
for i=1:4
    x2(i,:)=(-A(i,1)*x+b(i))/A(i,2);
end

V=[1 8; 5 10; 10 5];
[A,b,Aeq,beq]=vert2lcon(V)
for i=1:3
    x3(i,:)=(-A(i,1)*x+b(i))/A(i,2);
end


figure(3)
plot(x,x2,'k');hold
plot(x,x3,'b');hold
axis([0 10 0 10])

$offtext

set k disunctions /1*3/
    i temrs       /1*3/
    e equations per term /1*4/
    ki(k,i)
    kie(k,i,e)
    var /1*2/;

ki(k,i)=yes;ki('3','3')=no;
kie(ki,e)$(ord(e)<=3)=yes;
kie('3','1','4')=yes;



Parameter A(k,i,e,var), b(k,i,e);



A('1','3','1','1') =  0.8944           ;
A('1','3','2','1') = -0.9864           ;
A('1','3','3','1') =  0.5547           ;

A('1','3','1','2') =  0.4472           ;
A('1','3','2','2') =  0.1644           ;
A('1','3','3','2') = -0.8321           ;

b('1','3','1') =       6.2610       ;
b('1','3','2') =      -0.3288       ;
b('1','3','3') =      -2.7735       ;

A('1','2','1','1') =     0.9615        ;
A('1','2','2','1') =    -0.6247        ;
A('1','2','3','1') =    -0.7071        ;

A('1','2','1','2') = -0.2747           ;
A('1','2','2','2') =  0.7809           ;
A('1','2','3','2') = -0.7071           ;

b('1','2','1') =          5.7691    ;
b('1','2','2') =          0.4685    ;
b('1','2','3') =         -4.2426    ;

A('1','1','1','1') =     0.9487        ;
A('1','1','2','1') =    -0.5145        ;
A('1','1','3','1') =     0.0000        ;

A('1','1','1','2') =   0.3162          ;
A('1','1','2','2') =  -0.8575          ;
A('1','1','3','2') =   1.0000          ;

b('1','1','1') =     11.3842        ;
b('1','1','2') =    -10.2899        ;
b('1','1','3') =      9.0000        ;

A('2','1','1','1') =     0.9806        ;
A('2','1','2','1') =    -0.6000        ;
A('2','1','3','1') =    -0.5547        ;

A('2','1','1','2') =  -0.1961          ;
A('2','1','2','2') =   0.8000          ;
A('2','1','3','2') =  -0.8321          ;

b('2','1','1') =      2.1573        ;
b('2','1','2') =      4.8000        ;
b('2','1','3') =     -4.9923        ;

A('2','2','1','1') =      0.9806       ;
A('2','2','2','1') =     -0.9487       ;
A('2','2','3','1') =      0.3162       ;

A('2','2','1','2') =    0.1961         ;
A('2','2','2','2') =    0.3162         ;
A('2','2','3','2') =   -0.9487         ;

b('2','2','1') =       7.2563       ;
b('2','2','2') =      -3.4785       ;
b('2','2','3') =       0.3162       ;

A('2','3','1','1') =     1.0000        ;
A('2','3','2','1') =    -0.3162        ;
A('2','3','3','1') =    -0.5547        ;

A('2','3','1','2') =         0         ;
A('2','3','2','2') =    0.9487         ;
A('2','3','3','2') =   -0.8321         ;

b('2','3','1') =     10.0000        ;
b('2','3','2') =      6.3246        ;
b('2','3','3') =    -11.3714        ;

A('3','1','1','1') =      1.0000       ;
A('3','1','2','1') =     -0.3714       ;
A('3','1','3','1') =     -1.0000       ;
A('3','1','4','1') =     0             ;

A('3','1','1','2') =    0.0000         ;
A('3','1','2','2') =   -0.9285         ;
A('3','1','3','2') =   -0.0000         ;
A('3','1','4','2') =    1.0000         ;

b('3','1','1') =  6.0000            ;
b('3','1','2') =  -3.1568           ;
b('3','1','3') =  -1.0000           ;
b('3','1','4') =  6.0000            ;

A('3','2','1','1') =       0.7071      ;
A('3','2','2','1') =      -0.3162      ;
A('3','2','3','1') =      -0.4472      ;

A('3','2','1','2') =     0.7071        ;
A('3','2','2','2') =    -0.9487        ;
A('3','2','3','2') =     0.8944        ;

b('3','2','1') =       10.6066      ;
b('3','2','2') =       -7.9057      ;
b('3','2','3') =        6.7082      ;

parameter c(var);
*c('1')=3;
*c('2')=2;

c('1')=7;
c('2')=-2;

parameter lambda(k,var);lambda(k,var)=0

positive variable x(var),nu1(k,i),ni(k,i,var);
binary variable y(k,i);
variable cost;

equation obj, disj_ineq(k,i,e), sum_bin(k), disj_ineq_hr(k,i,e), disag(k,var), bound_up(k,i,var), bound_lo(k,i,var), obj2

;

obj.. cost =e= sum(var,c(var)*x(var));
obj2.. cost =e= sum(var,c(var)*x(var))
              + sum((k,var),lambda(k,var)*(x(var) - sum(ki(k,i),ni(k,i,var)))) ;

disj_ineq(k,i,e)$(kie(k,i,e) ).. sum(var$(A(k,i,e,var)<>0),A(k,i,e,var)*x(var)) =l= b(k,i,e) + 10*(1-y(k,i));

disag(k,var).. x(var) =e= sum(ki(k,i),ni(ki,var));
disj_ineq_hr(k,i,e)$(kie(k,i,e)  ).. sum(var$(A(k,i,e,var)<>0),A(k,i,e,var)*ni(k,i,var)) =l= b(k,i,e)*y(k,i);
bound_up(ki(k,i),var).. ni(ki,var) =l= x.up(var)*y(ki);
bound_lo(ki(k,i),var).. ni(ki,var) =g= x.lo(var)*y(ki);

sum_bin(k).. sum(ki(k,i),y(ki)) =e= 1;

x.up(var)=10;
x.lo(var)=0;

model bigM /obj, disj_ineq, sum_bin/;
model chull /obj, disag, disj_ineq_hr, bound_up, bound_lo, sum_bin/;
model lagdual /obj2, disj_ineq_hr, bound_up, bound_lo, sum_bin/;

option optcr=0;

solve chull min cost using rmip;
solve bigM min cost using rmip;

lambda(k,var) = -disag.m(k,var);
solve lagdual min cost using rmip;

y.fx(ki)=y.l(ki);
solve bigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;

set algo /BM,HR,LAG/
    level /1*3/
    node /1*18/
    resul /ub,lb,infeas/
;

scalar cnt /1/
       cnt2 /1/
       chec_int /0/;

parameter tot_res(algo,level,node,resul);


*Solve HR BB

cnt =1;
cnt2 =1;

y.fx('1','1')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','2')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','3')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

cnt =1;
cnt2 =2;

y.fx('1','1')=1;
y.fx('2','1')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','1')=1;
y.fx('2','2')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','1')=1;
y.fx('2','3')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','2')=1;
y.fx('2','1')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','2')=1;
y.fx('2','2')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','2')=1;
y.fx('2','3')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','3')=1;
y.fx('2','1')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','3')=1;
y.fx('2','2')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','3')=1;
y.fx('2','3')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;


cnt =1;
cnt2 =3;

y.fx('1','3')=1;
y.fx('2','1')=1;
y.fx('3','1')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;

y.fx('1','3')=1;
y.fx('2','1')=1;
y.fx('3','2')=1;
solve BigM using rmip min cost;
y.lo(ki)=0; y.up(ki)=1;
tot_res('HR',level,node,'lb')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;
chec_int=1;
loop(ki,if((y.l(ki)<0.999 and y.l(ki)>0.001),chec_int=0;););
if(chec_int=1,tot_res('HR',level,node,'ub')$(ord(node)=cnt and ord(level)=cnt2)=BigM.objval;);
if(BigM.modelstat<>1,tot_res('HR',level,node,'infeas')$(ord(node)=cnt and ord(level)=cnt2)=1;);
cnt=cnt+1;



N=2000;
e=[];
w=[];
kexi=[];
for t=1:N
e(t)=3*randn;
w(t)=randn;
kexi(t)=randn;
end
%e=normrnd(0,3,[1,N]);
%kexi=normrnd(0,1,[1,N]);
for t=2:N
    e(t)=-0.5*e(t-1)+kexi(t);
end
%w=normrnd(0,1,[1,N]);
y=[];
y(1)=e(1)+w(1);
for t=2:N
    y(t)=0.5*y(t-1)+e(t)+w(t)-0.5*w(t-1);
end
y1=y(1:1000);
g11=0;
g01=0;
g12=0;
g02=0;
for t=2:1000
    g11=g11+y(t)*y(t-1);
    g01=g01+y(t-1)*y(t-1);
end
a1_1=g11/g01;
for t=2:N
    g12=g12+y(t)*y(t-1);
    g02=g02+y(t-1)*y(t-1);
end
a1_2=g12/g02;


g11=0;
g01=0;
g12=0;
g02=0;
g21=0;
g22=0;
for t=3:1000
    g11=g11+y(t-1)*y(t-2);
    g01=g01+y(t-2)*y(t-2);
    g21=g21+y(t)*y(t-2);
end
a21_1=(g01*g11-g11*g21)/(g01^2-g11^2);
a22_1=(g01*g21-g11^2)/(g01^2-g11^2);
a2_1=[a21_1;a22_1];
for t=3:N
    g12=g12+y(t)*y(t-1);
    g02=g02+y(t-1)*y(t-1);
    g22=g22+y(t)*y(t-2);
end
a21_2=(g02*g12-g12*g22)/(g02^2-g12^2);
a22_2=(g02*g22-g12^2)/(g02^2-g12^2);
a2_2=[a21_2;a22_2];

AR1_1=ar(y1,1);
AR2_1=ar(y1,2);
theta_1_1=-AR1_1.A(2);
theta_2_1=[-AR2_1.A(2);-AR2_1.A(3)];
AR1_2=ar(y,1);
AR2_2=ar(y,2);
theta_1_2=-AR1_2.A(2);
theta_2_2=[-AR2_2.A(2);-AR2_2.A(3)];
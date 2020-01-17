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
AR1_1=ar(y1,1);
AR2_1=ar(y1,2);
theta_1_1=-AR1_1.A(2);
theta_2_1=[-AR2_1.A(2);-AR2_1.A(3)];
AR1_2=ar(y,1);
AR2_2=ar(y,2);
theta_1_2=-AR1_2.A(2);
theta_2_2=[-AR2_2.A(2);-AR2_2.A(3)];
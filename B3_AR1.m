% AR(1)
clear;
N=1000;
%e=normrnd(0,3,[1,N]);
%w=normrnd(0,1,[1,N]);
e=[];
w=[];
for t=1:N
e(t)=3*randn;
w(t)=randn;
end
y=[];
y(1)=e(1)+w(1);
for t=2:N
    y(t)=0.5*y(t-1)+e(t)+w(t)-0.5*w(t-1);
end
g11=0;
g01=0;
for t=2:1000
    g11=g11+y(t)*y(t-1);
    g01=g01+y(t-1)*y(t-1);
end
a1=g11/g01;
AR1=ar(y,1);

%3rd
%%%%%%%%0.006s
v=[1.6];
theta_3=0;
for i=1:N-1
beta=1+y(i)*v*y(i);
v=v-(1/beta)*v*y(i)*y(i)*v;
e=y(i+1)-y(i)*theta_3;
k=v*y(i);
theta_3=theta_3+k*e;
end

% 1st
%%%%%%%%%%%0.005s
theta_1=0;
S=0;
for i=1:N-1
    S=S+y(i)*y(i);
    e=y(i+1)-y(i)*theta_1;
    k=1/S*y(i);
    theta_1=theta_1+k*e;
end

%2nd
%%%%%%%%%%0.007s
theta_2=0;
R=0;
for i=1:N-1
    R=R+1/(i)*(y(i)*y(i)-R);
    e=y(i+1)-y(i)*theta_2;
    k=1/(i)*y(i)/R;
    theta_2=theta_2+k*e;
end
theta=-AR1.A(2);
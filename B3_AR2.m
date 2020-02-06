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
g21=0;
for t=3:1000
    g11=g11+y(t-1)*y(t-2);
    g01=g01+y(t-2)*y(t-2);
    g21=g21+y(t)*y(t-2);
end
a21=(g01*g11-g11*g21)/(g01^2-g11^2);
a22=(g01*g21-g11^2)/(g01^2-g11^2);
a2=[a21;a22];


AR2=ar(y,2);
%3rd
%%%%%%%%0.009s
v=1.6*[1,0;0,1];
theta_3=[0;0];
for i=1:N-2
fi=[y(i+1);y(i)];
beta=1+fi'*v*fi;
v=v-(1/beta)*v*fi*fi'*v;
e=y(i+2)-fi'*theta_3;
k=v*fi;
theta_3=theta_3+k*e;
end

%1st
%%%%%%%%%%%0.012s
theta_1=[0;0];
S=[0,0;0,0];
for i=1:N-2
  fi=[y(i+1);y(i)];
S=S+fi*fi';
e=y(i+2)-fi'*theta_1;
k=S\fi;
theta_1=theta_1+k*e;
end

%2nd
%%%%%%%%%%%%%%%%0.013s
R=[0,0;0,0];
theta_2=[0;0];
for i=1:N-2
fi=[y(i+1);y(i)];
  R=R+1/(i+2)*(fi*fi'-R);
    e=y(i+2)-fi'*theta_2;
    k=1/(i+2)*(R\fi);
    theta_2=theta_2+k*e;
end
theta=[-AR2.A(2);-AR2.A(3)];
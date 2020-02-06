clear;
N=2000;
i=100;
y=zeros(1,N);
theta1=zeros(1,i);
theta2=zeros(2,i);
a1=zeros(1,i);
a2=zeros(2,i);
for k=1:i
        e=[];
        w=[];
kexi=[];
for t=1:N
e(t)=3*randn;
w(t)=randn;
kexi(t)=randn;
end
for t=2:N
    e(t)=-0.5*e(t-1)+kexi(t);
end
        y(1)=e(1)+w(1);
            for t=2:N
                y(t)=0.5*y(t-1)+e(t)+w(t)-0.5*w(t-1);
            end
g12=0;
g02=0;
for t=2:N
    g12=g12+y(t)*y(t-1);
    g02=g02+y(t-1)*y(t-1);
end
A1=g12/g02;


g12=0;
g02=0;
g22=0;
for t=3:N
    g12=g12+y(t)*y(t-1);
    g02=g02+y(t-1)*y(t-1);
    g22=g22+y(t)*y(t-2);
end
a21=(g02*g12-g12*g22)/(g02^2-g12^2);
a22=(g02*g22-g12^2)/(g02^2-g12^2);

        AR1=ar(y,1);
        theta1(k)=-AR1.A(2);
        a1(k)=A1;
        AR2=ar(y,2);
        theta2(1,k)=-AR2.A(2);
        theta2(2,k)=-AR2.A(3);
        a2(1,k)=a21;
        a2(2,k)=a22;
end


%mean,variance
%theta1
mean_theta1=mean(theta1);
var_theta1=var(theta1);
mean_a1=mean(a1);
var_a1=var(a1);

%theta2
mean_theta2=mean(theta2,2);
var_theta2=zeros(2,2);
var_theta2(1,1)=var(theta2(1,:));
var_theta2(2,2)=var(theta2(2,:));
for k=1:i
    var_theta2(1,2)=var_theta2(1,2)+(theta2(1,k)-mean_theta2(1))*(theta2(2,k)-mean_theta2(2));
end
var_theta2(1,2)=var_theta2(1,2)/100;
var_theta2(2,1)=var_theta2(1,2);

mean_a2=mean(a2,2);
var_a2=zeros(2,2);
var_a2(1,1)=var(a2(1,:));
var_a2(2,2)=var(a2(2,:));
for k=1:i
    var_a2(1,2)=var_a2(1,2)+(a2(1,k)-mean_a2(1))*(a2(2,k)-mean_a2(2));
end
var_a2(1,2)=var_a2(1,2)/100;
var_a2(2,1)=var_a2(1,2);
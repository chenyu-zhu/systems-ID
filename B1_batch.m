clear;
N=2000;
i=100;
y=zeros(1,N);
theta1=zeros(1,i);
theta2=zeros(2,i);
for k=1:i
       e=[];
       w=[];
for t=1:N
e(t)=3*randn;
w(t)=randn;
end
        y(1)=e(1)+w(1);
            for t=2:N
                y(t)=0.5*y(t-1)+e(t)+w(t)-0.5*w(t-1);
            end
        AR1=ar(y,1);
        theta1(k)=-AR1.A(2);
        AR2=ar(y,2);
        theta2(1,k)=-AR2.A(2);
        theta2(2,k)=-AR2.A(3);
end


%mean,variance
%theta1
mean_theta1=mean(theta1);
var_theta1=var(theta1);

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
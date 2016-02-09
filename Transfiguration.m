function [p,q,P,Q] = Transfiguration(N,r_0,r_1)
load 'coverage_area.mat';
load 'PU_loc.mat';
theta= linspace(-pi,pi,N+1);
x=zeros(N,1);
y=zeros(N,1);
X=zeros(N,1);
Y=zeros(N,1);
m=numel(theta);
rtheta= arrayfun(@(x) theta(x) + rand*(theta(x+1)-theta(x)),1:m-1);
xi=(r_0/grid_res)*cos(rtheta) + PUx;
yi=(r_0/grid_res)*sin(rtheta) + PUy;
sslope=zeros(length(rtheta),1);
Sslope=zeros(length(rtheta),1);

Xi=(r_1/grid_res)*cos(rtheta) + PUx;
Yi=(r_1/grid_res)*sin(rtheta) + PUy;

for ii=1:length(xi)
    sslope(ii)= (PUx - xi(ii))./(yi(ii)-PUy);
    Sslope(ii) = (PUx - Xi(ii))./(Yi(ii)-PUy);
end

sslope(ii+1)= sslope(1);
Sslope(ii+1)=Sslope(1);
xi=[xi xi(1)];
yi=[yi yi(1)];
Xi= [Xi Xi(1)];
Yi= [Yi Yi(1)];

for ss=1:N
    x(ss)= (yi(ss+1) - yi(ss) + sslope(ss)*xi(ss) - sslope(ss+1)*xi(ss+1))...
        /(sslope(ss)- sslope(ss+1));
    X(ss)= (Yi(ss+1) - Yi(ss) + Sslope(ss)*Xi(ss) - Sslope(ss+1)*Xi(ss+1))...
        /(Sslope(ss)- Sslope(ss+1));
    y(ss)= yi(ss) + sslope(ss)*(x(ss)-xi(ss));
    Y(ss)= Yi(ss) + Sslope(ss)*(X(ss)-Xi(ss));
end
p=x;
q=y;
P=X;
Q=Y;
end
function n = nitrideDispersion(lambda)
a=3.0249;
b=40314;
A=.1353406^2;
B=1239.842^2;
lambda2=lambda.^2;
n=sqrt(1+a*lambda2./(lambda2-A)+b*lambda2./(lambda2-B));


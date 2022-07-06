function n = silicaDispersion( lambda )
a=0.6961663;
b=0.4079426;
c=0.8974794;
A=0.0684043^2;
B=0.1162414^2;
C=9.896161^2;
lambda2=lambda.^2;
n=sqrt(1+(a*lambda2)./(lambda2-A)+...
    (b*lambda2)./(lambda2-B)+(c*lambda2)./(lambda2-C));

end


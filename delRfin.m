clear
load('spectra.mat')
lambda=Normalized;

Color(:,1)=Blue(:,1);
Color(:,2)=Green(:,1);
Color(:,3)=Amber(:,1);
Color(:,4)=Red(:,1); 
Color(:,1) = Color(:,1)./((sum(Color(:,1),1)));
Color(:,2) = Color(:,2)./((sum(Color(:,2),1)));
Color(:,3) = Color(:,3)./((sum(Color(:,3),1)));
Color(:,4) = Color(:,4)./((sum(Color(:,4),1)));


%n2=nitrideDispersion(lambda.*0.001);
n2=silicaDispersion(lambda.*0.001);
load('silicon.mat')
n3=(interp1(silicon(:,1),silicon(:,2),lambda.*0.001));
n=1.33.*ones(1,length(lambda))'; %water
nb=1.45.*ones(1,length(lambda))'; %bio
r(:,1)=(nb-n)./(n+nb);
r(:,2)=(n2-nb)./(n2+nb);
r(:,3)=(n3-n2)./(n3+n2);

narray= 1.33:0.01:1.45;

% Reflectance vs wavelength

sio2_thickness=115;
si3n4_thickness=70;
M=2;

thickness=[0.95*sio2_thickness,sio2_thickness,1.05*sio2_thickness];
%L(:,2)=sio2_thickness.*n2;
L(:,1)=5.*nb;

figure
hold on

name = ['optimal thickness -5%' 'optimal thickness' 'optimal thickness +5%'];

for k=1:3
for h=1:length(narray)
    L(:,2)=thickness(k).*n2;
    r(:,1)=(nb-narray(h))./(narray(h)+nb);
    Gamma=(n3-n2)./(n3+n2);
    for i = M:-1:1
        delta = 2*pi*L(:,i)./lambda;                  
        z = exp(-2*1i*delta);                          
        Gamma = ((r(:,i) + Gamma.*z) ./ (1 + r(:,i).*Gamma.*z));
    end 
    R(h,:)=sum((Color(:,1).*Gamma),1)+0.7*sum((Color(:,2).*Gamma),1); 
     
    %different green percentage for different thicknessesS
    
    %plot(lambda,R(h,:));
end

R0 = (R(1).*ones(1,length(R)))';
ERR =((abs(R0).^2-abs(R).^2)./abs(R0).^2);
plot(narray,abs(ERR),'linewidth',1.5)

end



%title('Si3N4')
hold off
legend('optimal thickness -5%', 'optimal thickness', 'optimal thickness +5%');
set(gca,'FontSize',16)
ylabel('{\Delta}R/R')
xlabel('n')
box on
axis([1.33 1.45 0 0.03])

load('spectra.mat')
lambda=Normalized;
n2=silicaDispersion(lambda.*0.001);
load('silicon.mat')
n3=(interp1(silicon(:,1),silicon(:,2),lambda.*0.001));
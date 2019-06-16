function [G]=normaliseFD(F)

f=F(2:20);
f=abs(f);
G=f/f(1);
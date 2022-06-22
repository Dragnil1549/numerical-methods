clc
clear

f=@(x)  (((asin(7.*x)).^2)+1)./(sqrt(1-49.*x.^2));
a=0; 
b=0.1; 
n=10;

h=(b-a)/n;
x = a:h:b; 
y = f(x);  
plot(x,y)
disp("rect");
I = sum(h*y); 
display(I);

It = integral(f,a,b); 
display(It);
d = abs(I-It); 
display(d);

x=a+h;
integr=0;
while(x<=b)
    integr=integr+(1./2).*h.*(f(x-h)+f(x));
    x=x+h;
end
disp("trap");
display(integr);
display(integr-It);


h=(b-a)/n; 
integ = f(a);
for i=1:1:((n/2)-1) 
x=a+2*h*i;
integ=integ+2*f(x)+4*f(x+h);
end
integ=h*(integ+f(b)+4.*f(a+h))/3;
disp("simp");
display(integ);
display(abs(integ-It));
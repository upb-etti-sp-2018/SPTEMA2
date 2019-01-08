T=40;
f=1/T;
t=-2*T:0.4:2*T;
DUTY=17.5;
N=50;
SemnalInitial=square(2*pi*f*t,DUTY);
fun0=@(t)square(2*pi*f*t,DUTY);
CC=1/T*integral(fun0,0,T);
Ck=zeros(1,N);
Ak=zeros(1,N);
SemnalRefacut=0;
for (k=1:1:N)
   fun=@(t)square(2*pi*f*t,DUTY).*exp(-2*pi*f*t*1j*(k-25));
   Ck(k)=1/T*integral(fun,0,T);
   Ak(k+1)=2*abs(Ck(k));
   SemnalRefacut=SemnalRefacut+Ck(k)*exp(2*pi*f*t*1j*(k-25));
end
figure(1);
plot(t,SemnalRefacut,t,SemnalInitial);
figure(2)
Ak(26)=abs(CC);
Ak(1)=Ak(51);
stem([0:N],Ak);
%am ales DUTY CYCLE=17.5 ca fiind numarul echipei din lista de pe drive ( a
%7-a echipa) => 7*100/40=17.5 
%deoarece suma este impara am ales un semnal de tip dreptunghiular;
%in cadrul problemei generam un semnal pe care il reconstruim cu ajutorul SFC (formulele prezentate 
%in enunt) si utilizam redefinirea functiilor din matlab pentru a putea calcula integrala pentru fiecare k
%(pentru fiecare coeficient Ck(k)) am ales sa scriem k-25 in loc de k normal pentru a merge in ambele sensuri
%ale spectrului, adica pentru a nu ramane numai pe partea pozitiva.
%am ales sa lasam valori si pe axa negativa in ciuda faptului ca in exemplu
%exista numai valori pozitive raportat la Ox
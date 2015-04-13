module Constantes
implicit NONE
real, parameter :: degrad=(4.0*atan(1.0))/180
real, parameter :: pi=4.0*atan(1.0)
integer, parameter :: pts= 7000
real, parameter :: da = 1.29
real, parameter :: esfera =0.47
end module Constantes


subroutine nofriccion (x0,y0,v0,grado,xmax,ymax,tiempo)
use Constantes
implicit none
integer :: i
real, dimension (1:pts) :: x, y, t
real :: x0, y0, v0, grado
real :: xmax, ymax, tiempo
grado=grado*degrad
xmax = x0+((v0*v0*sin(2*grado))/(9.8))
ymax = y0+((v0*v0*sin(grado)*sin(grado)))/(19.6)
tiempo= (2*v0*sin(grado))/(9.8)
open (1, file= "sinfriccion.dat")
do I=1, pts, 1
if (grado==0) then
xmax=0
ymax=0
tiempo=0
else if (grado==90) then
xmax=0
end if
t(i)= float(i)*0.01
x(i)= x0+(v0*cos(grado)*t(i))
y(i)= y0+(v0*sin(grado)*t(i))-(4.9*t(i)*(t(i)))
write (1,1001) x(i), y(i)
1001 format (f11.5,f11.5)
if (y(I)<0) exit



end do
close (1)

end subroutine nofriccion


program Proyectil
use Constantes
implicit none
integer :: i
character :: objeto
real, dimension (0:pts) :: z,w,c,velz,velw,lz,lw
real :: x0,y0,v0,grado
real :: xmax,ymax,tiempo,xmaxt,ymaxt,tiempot
real :: error
real :: ad, area, radio, cd, masa




print *, "Introdusca los valores de x,y,v y angulo"
read *, x0,y0,v0,grado
call  nofriccion (x0,y0,v0,grado,xmax,ymax,tiempo)
 print *, "Introdusca la masa en kg"
read *, masa
print *, "El proyectil es un esfera, precione c"
read *, objeto
select case (objeto)
case ("c")
print *, "Introdusca el radio de la esfera"
read *, radio
area=pi*radio*radio
cd= esfera
case DEFAULT
print *, "error"
end select
z(0) = x0
w(0) = y0
velz(0) = v0*cos(grado)
velw(0) = v0*sin(grado)
ad = (0.5*da*area*cd)/masa
lz(0) = -ad*velz(0)*velz(0)
lw(0) = 9.8-(ad*velw(0)*velw(0))
c(0) = 0
open (2, file="friccion.dat")

write (2,1001) z(0), w(0)
1001 format (f11.5,f11.5)
do i=0, pts, 1
c(i+1)= c(i)+ 0.01
velz(i+1) = velz(i)+lz(i)*c(I+1)
velw(i+1) = velw(i)+lw(i)*c(i+1)
lz(i+1) = -ad*velz(i)*velz(i)
lw(i+1) = -9.8-(ad*velz(i)*velz(i))
z(i+1) = z(i)+velz(i)*c(i+1)+(0.5*lz(i)*c(i+1)*c(i+1))
w(i+1) = w(i)+velw(I)*c(i+1)+(0.5*lw(i)*c(i+1)*c(i+1))
write (2,*) z(i+1), w(i+1)
if (grado==0) then
xmaxt=0
ymaxt=0
tiempot=0
else if (grado==90) then
xmaxt=0
end if
if (w(i)<0) exit
 
end do
close (2)
xmaxt = z(i)
ymaxt = MAXVAL(w)
tiempot = c(i)*10

error= ((xmax-xmaxt)/xmaxt) * 100.0

print *, "Posicion"
print *, "=", x0 , y0
print *, "Velocidad inicial del proyectil"
print *, "=",v0, "m/s"
print *, "Angulo"
print *, "=",grado
print *, "======================================"
print *, "=======Lanzamiento sin friccion======="
print *, "Tiempo de vuelo"
print *, "=",tiempo,"s"
print *, "Maxima altura"
print *, "=",ymax,"m"
print *, "Alcance"
print *, "=",xmax,"m"
print *, "======================================"
print *, "=======Lanzamiento con friccion======="
print *, "Tiempo de vuelo"
print *, "=",tiempot,"s"
print *, "Maxima altura"
print *, "=",ymaxt,"m"
print *, "Alcance"
print *,"=", xmaxt,"m"
print *, "Error de no considerar el arrastre de la friccion del aire es de", error

end program Proyectil 

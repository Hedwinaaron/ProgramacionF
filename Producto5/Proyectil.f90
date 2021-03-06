PROGRAM proyectil_plot
IMPLICIT NONE
	
REAL, PARAMETER :: pi=4.0*atan(1.0)
REAL :: v, angle, radians, time, ymax, xmax, vx, vy
REAL, DIMENSION(1:3000) :: x, y                   !Arrays
INTEGER :: i

PRINT *, "Ingresa el angulo al que es lanzado el proyectil (grados)"
READ *, angle

radians = angle*pi/180.0

PRINT *, "Ingresa la velocidad inicial del proyectil (m/s)"
READ*, v


!Calcula las componentes (x,y) de la velocidad inicial
vx = (v)*COS(radians)
vy = (v)*SIN(radians)

!Crear un archivo .dat y escribir los resultados
OPEN(1,file='proj.dat')

y = 0
x = 0

DO i=1, 3000, 1
time = (FLOAT(i)*0.01)
x(i) = vx*time
y(i) = (vy*time) - (4.903*time*time)           !Considerando g=9.806
WRITE(1,*) x(i), y(i)
IF (y(i) < 0) EXIT
END DO
CLOSE(1)

ymax = (vy**2) / (19.612)
xmax = x(i)

IF (vx<0) THEN
xmax = 0
END IF



PRINT *, "El tiempo total de vuelo es:", time, "s"
PRINT *, "La altura maxima alcanzada es:", ymax, "m"
PRINT *, "Tiene un alcance de:", xmax, "m"


END PROGRAM proyectil_plot

# Proyecto Visual Computing 

## Propósito

Aplicar una nueva forma de interactuar con un ambiente grafico, ya sea 3d o 2d.

## Integrantes

Máximo 3.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|Juan Carlos Gama| [JuanCarlosUNAL](https://github.com/JuanCarlosUNAL)             |

## Idea

La idea es crear interaccion con la aplicación a travez del segumiento del rostro. La idea surge, de las nuevas tendencias de usar gestos corporales que son captados, por lo general con dispositivos especializados como Kniks(microsoft) o Eye(PlayStation Sony). Sin embargo la idea principal es usar la camara web ya que es un dispositivo comun en la mayoria de computadores. Para la interacción se tubieron en cuneta 2 ambientes:

* Movimiento a travez del espacio, en el cual el movimiento genera un movimiento con el cual el usuario se pueda mover en el espacio en el que se encuentra
* Manipulacion de objetos, en el cual el usuario es capaz de manipular los objetos que se encuentran en la escena a travez de movimientos de la camara 

Se usó la libreria [OpenCv](https://github.com/atduskgreg/opencv-processing) para la deteccion de rostros, el cual usaremos para la interacción. Para instalar la libreria en processesing descargamos del gestor de paquetes que processing ya trae o la descargamos directamente del  [repositorio de GitHub](https://github.com/atduskgreg/opencv-processing) 

Ademas para la manipulación del ambiente y la escena se usa [Frames](https://github.com/VisualComputing/framesjs) ya que la estructura de grafo facilita el cambio de perspectivas de la escena de una manera intuitiva.

## Trabajo futuro
Existen gran cantidad de trabajo en opencv entre el cual podemos encontrar deteccion de gran cantidad de objetos, como las manos, el esqueleto tanto del cuerpo como de las manos, los cuales podria usarse para una manipulaccion e interaccion con escenas mucho mas amplia.

## Ejecución

* Para ejecutar asegurese de tener tanto Opencv para processing como frames instalados debidamente
* Clonar este repositorio de manera loical con ```git clone```
* Existen dos versiones como se explico mas arriba. La primera en la rama ```master``` para movernos a travez de la escena. la segunda en la rama ```manipulacion``` en la cual poremos manipular algunos objetos en la scena



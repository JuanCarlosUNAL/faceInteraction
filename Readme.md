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

La idea es crear interacción con la aplicación a través del seguimiento del rostro. La idea surge, de las nuevas tendencias de usar gestos corporales que son captados, por lo general con dispositivos especializados como Kinect(microsoft) o Eye(PlayStation Sony). Sin embargo la idea principal es usar la cámara web ya que es un dispositivo común en la mayoría de computadores. Para la interacción se tuvieron en cuneta 2 ambientes:

* Movimiento a través del espacio, en el cual el movimiento genera un movimiento con el cual el usuario se pueda mover en el espacio en el que se encuentra.
* Manipulación de objetos, en el cual el usuario es capaz de manipular los objetos que se encuentran en la escena a través de movimientos de la cámara.

Se usó la librería [OpenCv](https://github.com/atduskgreg/opencv-processing)  para la detección de rostros, el cual usaremos para la interacción. Para instalar la librería en Processing descargamos del gestor de paquetes que Processing ya trae o la descargamos directamente del  [repositorio de GitHub](https://github.com/atduskgreg/opencv-processing) 

Además para la manipulación del ambiente y la escena se usa [Frames](https://github.com/VisualComputing/framesjs) ya que la estructura de grafo facilita el cambio de perspectivas de la escena de una manera intuitiva.

## Trabajo futuro
Existen gran cantidad de trabajo en opencv entre el cual podemos encontrar detección de gran cantidad de objetos, como las manos, el esqueleto tanto del cuerpo como de las manos, los cuales podría usarse para una manipulación e interacción con escenas mucho mas amplia.

## Ejecución

* Para ejecutar asegúrese de tener tanto Opencv para processing como frames instalados debidamente
* Clonar este repositorio de manera local con ```git clone```
* Existen dos versiones como se explico mas arriba. La primera en la rama ```master``` para movernos a través de la escena. la segunda en la rama ```manipulacion``` en la cual podremos manipular algunos objetos en la escena



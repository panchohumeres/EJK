# Generar Documentación con Sphinx

Cómo crear y modificar el Manual de Usuario, Manual API y Documentación de APIs de Clientes
*******************************************************************************************

## Introducción

Sphinx es una herramienta para crear documentación de forma sencilla.

A continuación se explica cómo utilizar esta herramienta para el sistema opertivo Windows, aunque puede aplicarse parte del proceso para otros sistemas operativos.

## Documentación
http://www.sphinx-doc.org/en/stable/install.html
https://github.com/sphinx-doc/sphinx


## Instalar Sphinx en Windows

1. Instalar Python
Descargar el ejecutable de https://www.python.org/downloads/ e instalar.

2. Instalar paquete pip
Descargar paquete https://bootstrap.pypa.io/get-pip.py  
Guardarlo en la carpeta C:/Python27/Scripts
Abrir consola y ejecturar: python get-pip.py

3. Instalar Sphinx
Abrir consola y ubicarse en la carpeta C:/Python27/Scripts
Ejecutar comando: pip install sphinx
Para confirmar instalación ejecutar comando: sphinx-build -h

4. Instalar tema
Ejecutar comando: pip install sphinx_rtd_theme

Nota: Puede ser necesario agregar la ruta a C:/Python27/Scripts como variable de entorno para poder ejecutar el tercer paso.
Ir a Control Panel\System and Security\System.
Luego a Advanced System Settings.
En la pestaña Advanced, abrir Enviromental Variables...
Editar la variable Path. Agregar al final: ;C:\Python27\Scripts

## Instalar Sphinx con Anaconda Python (3.7)

1. Instalar Anaconda Python
Descargar imagen de: https://www.anaconda.com/distribution/

2. Abrir Anaconda Navigator, Crear entorno y abrir Terminal:
En linux ejecutar anaconda-navigator desde el terminal. Si se crea un nuevo entorno, seleccionarlo y elegir del menú drop down "Open Terminal" para abrir terminal en nuevo entorno.

3. Instalar Sphinx en entorno:
Instrucciones detalladas en: https://berkeley-stat159-f17.github.io/stat159-f17/lectures/14-sphinx..html
* conda install sphinx
* conda install -c conda-forge nbsphinx recommonmark ghp-import
* pip install sphinx_rtd_theme


## Configurar Sphinx

### Nuevo documento

1. Configurar los documentos fuente
Abrir la consola y ubicarse en el directorio donde estarán los archivos con cd C:/dir
Ejectutar sphinx-quickstart y responder las preguntas de configuración.

2. Generar documentación en html
En la consola ejecutar sphinx-build -b html sourcedir builddir
`sourcedir` es el directorio fuente donde se encuentra el archivo conf.py
`builddir` es el directorio donde se crearán los archivos html.

### Editar documentación
En la consola ejecutar sphinx-build -b html sourcedir builddir
`sourcedir` es el directorio fuente donde se encuentra el archivo conf.py
`builddir` es el directorio donde se crearán los archivos html. `

Ej.: sphinx-build -b html C:\Users\G\Documents\GitHub\docs\source\es C:\Users\G\Documents\GitHub\docs\es


#### Índice
Para modificar el árbol/estructura ir a .../source/index.rst
http://www.sphinx-doc.org/en/stable/tutorial.html#defining-document-structure


####################################################################################

_________________________________________________________


## Tips

### Titulos
```
    # with overline, for parts
    * with overline, for chapters
    =, for sections
    -, for subsections
    ^, for subsubsections
    ", for paragraphs

    #######################
    with overline, for parts
    #######################

    ******************************
    with overline, for chapters
    ******************************

    for sections
    ==============

    for subsections
    ---------------

    for subsubsections
    ^^^^^^^^^^^^^^^^^^

    for paragraphs
    """"""""""""""
```

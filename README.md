# Securize

Tradicionalmente, la mayor parte de los esfuerzos relacionados con las pruebas software se vienen dedicando a la validación de requisitos funcionales, en otras palabras, corroborar que se han implementado las funcionalidades (aquello que se ha especificado previamente que deben cumplir nuestras aplicaciones, programas o sistemas). Sin embargo, cada vez se presta más atención (tanto desde el punto de vista académico como profesional) a la validación de requisitos no funcionales. Y, de entre estos, a la validación de características de seguridad, destinada a detectar la presencia de vulnerabilidades de software.

En este proyecto se busca la creación de una **librería de código abierto** que proporcione a la comunidad de desarrollo de **Elixir** una herramienta capaz de realizar un **análisis de código estático en busca de posibles brechas de seguridad**. Para ello, la librería analizará el código proporcionado por el usuario y mediante el uso combinado de pruebas basadas en propiedades y pruebas con inserción de mutantes será capaz de generar una lista con toda la información de las posibles vulnerabilidades que se hayan detectado.

## Instalación 

Para usar Securize: 

* Paso 1: Instalar y configurar Git ([Instalar Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)) con GitHub ([Configurar GitHub](https://docs.github.com/en/get-started/quickstart/set-up-git)).
* Paso 2: Instalar Elixir - [Instalar Elixir](https://elixir-lang.org/install.html)
* Step 3: Descargar el proyecto. Por ejemplo por línea de comandos, con alguno de los siguientes:

```shell
# HTTPS
git clone https://github.com/antoniogolpe/MixSecurize.git

# SSH 
git clone git@github.com:antoniogolpe/MixSecurize.git
```

## Ejecución 
Una vez descargado el proyecto situarse dentro de la carpeta `securize` y lanzar el comando:

```shell
mix securize <rutaProyecto>
```

`rutaProyecto` debe ser sustituido por la ruta al proyecto que se desea analizar.

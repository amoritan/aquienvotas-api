# AQuienVotas

**AQuienVotas** es una plataforma web para generar estadísticas de intención de voto y opinión a través de encuestas transparentes y representativas.

La versión del proyecto publicada en [www.aquienvotas.com](https://www.aquienvotas.com "AQuienVotas") tiene como objetivo representar la opinión de la población de cara a las elecciones ejecutivas del año 2019 en Argentina a través distintas encuestas sobre la intención de voto y la opinión de los visitantes frente temas de debate público en el país. 

Los resultados obtenidos son ponderados y expuestos al usuarios en tiempo real. Apuntamos a colaborar, con datos de calidad, en el debate público mediante el desarrollo de esta herramienta neutral, transparente y accesible.

### Acerca del equipo
Somos cuatro argentinos con interés en política, estadística y tecnología. Nuestro objetivo es construir una herramienta neutral y representativa para producir un set de datos público de calidad con valores anónimos de opinión, orientación política y segmentación.

- **[@andresmoritan](https://twitter.com/andresmoritan "Twitter de Andres Moritan")  (Desarrollo)**: Es desarrollador,  creó y mantiene la plataforma; Diseña e implementa la arquitectura y las interfaces.
- **[@ineslovisolo](https://twitter.com/ineslovisolo "Twitter de Ines Lovisolo") (Análisis)**: Es politóloga especialista en opinión pública, maneja los análisis políticos y asegura la validez estadística los resultados.
- **[@andreskloster](https://twitter.com/AndresKloster "Twitter de Andres Kloster") (Difusión)**: Es especialista en posicionamiento web, se encarga de comunicar y difundir el proyecto.
- **[@lapaulaalcala](https://twitter.com/lapaulaalcala "Twitter de Paula Alcala") (Estrategia)**: Es licenciada en ciencias de la educación, define la experiencia de la aplicación, el contenido y la estrategia del proyecto.

---- 

## Acerca de la tecnología

**AQuienVotas** es desarrollando como **software libre** bajo la licencia _GNU Affero General Public License (AGPL)_ con el objetivo de fomentar la transparencia y la colaboración dentro del proyecto.

**Aquellos/as que tengan interés en formar parte del proyecto, son bienvenidos/as a brindar su aporte al desarrollo de esta apasionante herramienta.**

Quienes residan -y voten- fuera de Argentina y tengan interés en utilizar la herramienta en su país, también son bienvenidos/as a ponerse en contacto para poder brindarles apoyo en la implementación.

> El presente código fuente y las instrucciones que se detallan a continuación corresponden a la _Application Programming Interface (API)_ del proyecto. Para conocer y/o colaborar con la _Web Application_ de **AQuienVotas** debes visitar [este repositorio](https://github.com/andresmoritan/aquienvotas "AQuienVotas (Web Application) en GitHub").

### Acerca del stack

El back-end de la plataforma se encuentra desarrollado utilizando [Ruby](https://github.com/ruby/ruby "Ruby") _(v 2.6.1)_ como lenguaje principal a través del framework [Ruby on Rails](https://github.com/rails/rails "Ruby on Rails") _(v 5.2.2)_ con la _nueva_ arquitectura de Rails::API. La base de datos seleccionada para utilizar con Active Record es [PostgreSQL](https://www.postgresql.org "PostgreSQL") _(v 9.6)_.

Adicionalmente algunas dependencias interesantes que se encuentran aplicadas en la _Application Programming Interface (API)_ son [ActiveModel::Serializers](https://github.com/rails-api/active_model_serializers "ActiveModel Serializers"), [Knock](https://github.com/nsarno/knock "Knock") y [Pundit](https://github.com/varvet/pundit "Pundit").

### Para colaborar

Hacer un fork del repositorio y clonarlo en tu equipo.

```bash
git clone https://github.com/YOUR-USER-NAME/aquienvotas-api.git
cd aquienvotas-api
```

Configurar tus variables de entorno en un archivo `.env` en el directorio raíz del proyecto.

```bash
#.env.development.local
HOST=YOUR-IP:3000
CLIENT=YOUR-IP:5757
```

Instalar las dependencias. _Requiere tener instalado previamente Ruby (v 2.6.1) y PostgreSQL (v 9.6)_

```bash
bundle install
```

Crear, brinda estructura (migrando) y completa la base de datos.

```bash
rake db:create ; rake db:migrate ; rake db:seed
```

Ejecuta el servidor de forma local.

```bash
rails s
```

A partir de aquí podrás hacer tu magia y generar un Pull Request en el repositorio principal cuando estés listo/a para hacer público tu trabajo.

---- 

AQuienVotas
Copyright (C) 2015-2019 Andres Moritan

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see \<[https://www.gnu.org/licenses/](https://www.gnu.org/licenses/)\>.

![AGPL](https://www.gnu.org/graphics/agplv3-155x51.png)

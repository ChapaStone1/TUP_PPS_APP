# Frontend - App para Android en Flutter
# CONSULTORIOS MÉDICOS UTN
# UTN - TUP | PPS 2025
# Alumno Juan Jose Chaparro

## Descripción
SDK Flutter/Dart: Compatible con Dart SDK ^3.5.3

Esta aplicación para Android desarrollada en Flutter tiene como objetivo gestionar usuarios e historias medicas en el marco de un Proyecto PPS para la Tecnicatura Universitaria en Programación (UTN FRBB). La app permite una experiencia personalizada tanto para pacientes, para médicos y usuarios administradores, integrando funciones como generación de documentos PDF, manejo de sesiones y preferencias de usuario, carga de historias clinicas, reseteo de claves, creacion de usuarios, entre otras.

## 🔧 Funcionalidades técnicas
Internacionalización: Soporte multilenguaje con flutter_localizations e intl.

Conectividad: Comunicación con APIs REST usando http. Uso de clases Future para gestionar solicitudes a la API.

Gestión de Estado: Provider para cambiar entre tema claro y oscuro.

Persistencia local: SharedPreferences para almacenar preferencias como tema oscuro, pacientes favoritos y token de sesión.

Gestión de entorno: Uso de variables de entorno seguras a través de flutter_dotenv.

Exportación de datos: Generación y visualización de archivos PDF mediante pdf y printing.

Font personalizada: "assets/fonts/CoolveticaRg.otf" extraida de la pagina https://www.dafont.com/.

Debug: Motorola Edge 40 Neo, mi teléfono personal.


### 1. Inicio.

![Login](doc/images/home/login.jpeg)
![Login modo Oscuro](doc/images/home/loginblack.jpeg)
![Registrarse](doc/images/home/registerpaciente.jpeg)
![Fechas](doc/images/home/fechanac.jpeg)

### 2. Home Admin.

![Home](doc/images/admin/home.jpeg)
![Alta de un médico](doc/images/admin/altamedico.jpeg)
![Eliminar un paciente](doc/images/admin/deletepaciente.jpeg)
![Disponbilidadd](doc/images/admin/cambiardisponibilidadmedico.jpeg)
![Solo disponibles](doc/images/admin/medicosdisponibles.jpeg)
![Resetear Password](doc/images/admin/resetpass1.jpeg)
![Resetear Password](doc/images/admin/resetpass2.jpeg)

### 3. Home Médico.

![Home](doc/images/medico/home_normal.jpeg)
![Home modo Oscuro](doc/images/medico/home.jpeg)
![Editar perfil](doc/images/medico/editar_perfil.jpeg)
![Listado de pacientes](doc/images/medico/ver_pacientes.jpeg)
![Datos de un paciente](doc/images/medico/datos_paciente.jpeg)
![Cargar una consulta](doc/images/medico/cargar_consulta.jpeg)
![Ver historia clinica de un paciente](doc/images/medico/ver_historia.jpeg)
![Soporte](doc/images/medico/soporte.jpeg)

### 3. Home Paciente.

![Home](doc/images/paciente/home.jpeg)
![Home](doc/images/paciente/editarperfil.jpeg)
![Home](doc/images/paciente/mi_historia.jpeg)
![Home](doc/images/paciente/medicosdisponibles.jpeg)

### 4. Sobre el código.

![ApiConfig](doc/images/otros/ApiConfig.png)
![Estructura](doc/images/otros/estructura.png)
![Lib](doc/images/otros/lib.png)
![MainRouter](doc/images/otros/MainRouter.png)

### 5. Widgets Reutilizables implementados:

a. CustomCardMedico.
b. CustomCardPaciente.
c. CustomCardUser.
d. DataPickerFormField.
e. FutureFetcher, Updater, Poster, Deleter, Patcher.
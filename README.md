# 📱 Frontend - App Android en Flutter  
## 🏥 CONSULTORIOS MÉDICOS UTN  
**UTN - TUP | PPS 2025**  
**Alumno:** Juan José Chaparro

---

## 📘 Descripción

**SDK Flutter/Dart:** Compatible con Dart SDK `^3.5.3`  

Esta aplicación para Android desarrollada en Flutter tiene como objetivo gestionar usuarios e historias clínicas en el marco del Proyecto PPS de la Tecnicatura Universitaria en Programación (UTN FRBB).  

La app permite una experiencia personalizada para **pacientes**, **médicos** y **usuarios administradores**, e integra funcionalidades como:  

- Generación de documentos PDF  
- Manejo de sesiones y preferencias  
- Carga de historias clínicas  
- Reseteo de contraseñas  
- Creación y gestión de usuarios  

---

## 🔧 Funcionalidades técnicas

- **🌍 Internacionalización:** Soporte multilenguaje con `flutter_localizations` e `intl`  
- **🌐 Conectividad:** Comunicación con APIs REST utilizando `http`. Uso de clases `Future` para solicitudes asincrónicas.  
- **🔄 Gestión de estado:** `provider` para cambiar entre tema claro y oscuro.  
- **💾 Persistencia local:** Uso de `shared_preferences` para almacenar preferencias como el tema oscuro, pacientes favoritos y token de sesión.  
- **🔐 Gestión de entorno:** Variables de entorno seguras mediante `flutter_dotenv`.  
- **📄 Exportación de datos:** Generación y visualización de archivos PDF con `pdf` y `printing`.  
- **🔤 Tipografía personalizada:** Uso de *CoolveticaRg.otf*, extraída de [dafont.com](https://www.dafont.com/).  
- **🧪 Dispositivo de prueba:** Motorola Edge 40 Neo (teléfono personal).

---

## 1. 🔐 Pantallas de Inicio

Pantallas de login y registro de pacientes.

<img src="doc/images/home/login.jpeg" width="300" alt="Pantalla de Login - Modo Claro" />
<img src="doc/images/home/loginblack.jpeg" width="300" alt="Pantalla de Login - Modo Oscuro" />
<img src="doc/images/home/registerpaciente.jpeg" width="300" alt="Registro de nuevo paciente" />
<img src="doc/images/home/fechanac.jpeg" width="300" alt="Selector de fecha de nacimiento" />

---

## 2. 🛠️ Home Admin

Panel principal del administrador con funciones como alta de médicos, reseteo de contraseñas y disponibilidad médica.

<img src="doc/images/admin/home.jpeg" width="300" alt="Home del administrador" />
<img src="doc/images/admin/altamedico.jpeg" width="300" alt="Formulario para alta de médico" />
<img src="doc/images/admin/deletepaciente.jpeg" width="300" alt="Eliminar paciente" />
<img src="doc/images/admin/cambiardisponibilidadmedico.jpeg" width="300" alt="Cambio de disponibilidad de médico" />
<img src="doc/images/admin/medicosdisponibles.jpeg" width="300" alt="Listado de médicos disponibles" />
<img src="doc/images/admin/resetpass1.jpeg" width="300" alt="Pantalla de reseteo de contraseña (1)" />
<img src="doc/images/admin/resetpass2.jpeg" width="300" alt="Pantalla de reseteo de contraseña (2)" />

---

## 3. 🩺 Home Médico

Acceso al listado de pacientes, historial clínico y carga de consultas.

<img src="doc/images/medico/home_normal.jpeg" width="300" alt="Home del médico - Modo Claro" />
<img src="doc/images/medico/home.jpeg" width="300" alt="Home del médico - Modo Oscuro" />
<img src="doc/images/medico/editar_perfil.jpeg" width="300" alt="Edición del perfil médico" />
<img src="doc/images/medico/ver_pacientes.jpeg" width="300" alt="Listado de pacientes" />
<img src="doc/images/medico/datos_paciente.jpeg" width="300" alt="Vista de datos del paciente" />
<img src="doc/images/medico/cargar_consulta.jpeg" width="300" alt="Formulario para cargar consulta médica" />
<img src="doc/images/medico/ver_historia.jpeg" width="300" alt="Historia clínica del paciente" />
<img src="doc/images/medico/soporte.jpeg" width="300" alt="Pantalla de soporte médico" />

---

## 4. 👨‍⚕️ Home Paciente

Panel del paciente con opciones de edición de perfil, visualización de historia clínica y listado de médicos.

<img src="doc/images/paciente/home.jpeg" width="300" alt="Home del paciente" />
<img src="doc/images/paciente/editarperfil.jpeg" width="300" alt="Edición del perfil del paciente" />
<img src="doc/images/paciente/mi_historia.jpeg" width="300" alt="Historia clínica del paciente" />
<img src="doc/images/paciente/medicosdisponibles.jpeg" width="300" alt="Listado de médicos disponibles" />

---

## 5. 🧠 Estructura del Código

Vistas sobre la configuración de API, estructura del proyecto y ruteo.

<img src="doc/images/otros/ApiConfig.png" width="300" alt="Configuración de API (ApiConfig.dart)" />
<img src="doc/images/otros/estructura.png" width="300" alt="Estructura general del proyecto" />
<img src="doc/images/otros/lib.png" width="300" alt="Contenido de la carpeta lib/" />
<img src="doc/images/otros/MainRouter.png" width="300" alt="Ruteo principal (MainRouter)" />

---

## 6. ♻️ Widgets Reutilizables

Listado de componentes personalizados reutilizados en la aplicación:

- `CustomCardMedico`  
- `CustomCardPaciente`  
- `CustomCardUser`  
- `DataPickerFormField`  
- `FutureFetcher`, `FutureUpdater`, `FuturePoster`, `FutureDeleter`, `FuturePatcher`

---

> Para más detalles sobre funcionalidades internas o pruebas en otros dispositivos, consultar al desarrollador.


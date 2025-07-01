# 📱 Frontend - App Android en Flutter  
## 🏥 CONSULTORIOS MÉDICOS UTN  
**UTN - TUP | PPS 2025**  
**Alumno:** Juan José Chaparro

---

## 📘 Descripción

**SDK Flutter/Dart:** Dart SDK `^3.5.3`  

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

Pantalla de Login - Modo Claro
<img src="doc/images/home/login.jpeg" width="300" alt="Pantalla de Login - Modo Claro" />
Pantalla de Login - Modo Oscuro
<img src="doc/images/home/loginblack.jpeg" width="300" alt="Pantalla de Login - Modo Oscuro" />
Registro de nuevo paciente
<img src="doc/images/home/registerpaciente.jpeg" width="300" alt="Registro de nuevo paciente" />
Selector de fechas de nacimiento con la clase reutilizable DataPickerFormField, que luego la configura con el formato que solicita la API(YYYY-MM-DD).
<img src="doc/images/home/fechanac.jpeg" width="300" alt="Selector de fecha de nacimiento" />

---

## 2. 🛠️ Home Admin

Panel principal del usuario administrador.
<img src="doc/images/admin/home.jpeg" width="300" alt="Home del administrador" />
Formulario para alta de médico
<img src="doc/images/admin/altamedico.jpeg" width="300" alt="Formulario para alta de médico" />
Eliminar paciente
<img src="doc/images/admin/deletepaciente.jpeg" width="300" alt="Eliminar paciente" />
Cambio de disponibilidad de médico:
Función que permite al médico indicar si está disponible para consultas. Al activarla, su perfil aparecerá en el listado de médicos disponibles visible para los usuarios pacientes, para que puedan elegir con quién atenderse.
<img src="doc/images/admin/cambiardisponibilidadmedico.jpeg" width="300" alt="Cambio de disponibilidad de médico" />
Listado solo de medicos disponibles.
<img src="doc/images/admin/medicosdisponibles.jpeg" width="300" alt="Listado de médicos disponibles" />
Listado de todos los usuarios para resetear password, el password que genera es "clave+DniUsuario".
<img src="doc/images/admin/resetpass1.jpeg" width="300" alt="Pantalla de reseteo de contraseña (1)" />
<img src="doc/images/admin/resetpass2.jpeg" width="300" alt="Pantalla de reseteo de contraseña (2)" />

---

## 3. 🩺 Home Médico

Home del médico - Modo Claro
<img src="doc/images/medico/home_normal.jpeg" width="300" alt="Home del médico - Modo Claro" />
Home del médico - Modo Oscuro
<img src="doc/images/medico/home.jpeg" width="300" alt="Home del médico - Modo Oscuro" />
Edición del perfil médico
<img src="doc/images/medico/editar_perfil.jpeg" width="300" alt="Edición del perfil médico" />
Listado de pacientes
<img src="doc/images/medico/ver_pacientes.jpeg" width="300" alt="Listado de pacientes" />
Vista de datos del paciente
<img src="doc/images/medico/datos_paciente.jpeg" width="300" alt="Vista de datos del paciente" />
Formulario para cargar consulta médica
<img src="doc/images/medico/cargar_consulta.jpeg" width="300" alt="Formulario para cargar consulta médica" />
Historia clínica del paciente
<img src="doc/images/medico/ver_historia.jpeg" width="300" alt="Historia clínica del paciente" />
Pantalla de soporte médico
<img src="doc/images/medico/soporte.jpeg" width="300" alt="Pantalla de soporte médico" />

---

## 4. 👨‍⚕️ Home Paciente

Home del paciente
<img src="doc/images/paciente/home.jpeg" width="300" alt="Home del paciente" />
Edición del perfil del paciente
<img src="doc/images/paciente/editarperfil.jpeg" width="300" alt="Edición del perfil del paciente" />
Historia clínica del paciente
<img src="doc/images/paciente/mi_historia.jpeg" width="300" alt="Historia clínica del paciente" />
Listado de médicos disponibles
<img src="doc/images/paciente/medicosdisponibles.jpeg" width="300" alt="Listado de médicos disponibles" />

---

## 5. 🧠 Estructura del Código

Configuración de API (ApiConfig.dart):
Permite centralizar la dirección base (baseUrl) de la API utilizada por la aplicación. Modificando esta línea, se puede apuntar fácilmente a otros entornos, como la API en localhost u otro servidor externo que no sea render.
<img src="doc/images/otros/ApiConfig.png" width="300" alt="Configuración de API (ApiConfig.dart)" />
Estructura general del proyecto
<img src="doc/images/otros/estructura.png" width="300" alt="Estructura general del proyecto" />
Contenido de la carpeta lib
<img src="doc/images/otros/lib.png" width="300" alt="Contenido de la carpeta lib/" />
Ruteo principal (MainRouter):
Definí las rutas de navegación de la aplicación organizandolas por tipo de usuario (admin, médico, paciente). Cada grupo de rutas se gestiona en listas separadas, que luego se utilizan para construir dinámicamente el menú de navegación en el NavigatorCardWidget dentro de cada home.
<img src="doc/images/otros/MainRouter.png" width="300" alt="Ruteo principal (MainRouter)" />

---

## 6. ♻️ Widgets Reutilizables

Listado de componentes personalizados reutilizados en la aplicación:

- `CustomCardMedico`  
- `CustomCardPaciente`  
- `CustomCardUser`  
- `DataPickerFormField`  
- `FutureFetcher`, `FutureUpdater`, `FuturePoster`, `FutureDeleter`, `FuturePatcher`
- `Drawe Menu`
- `IsFavouriteIcon`
- `NavigatorCardWidget`

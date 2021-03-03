# WS Sipe Multifuentes Persona Humanav1

WS Sipe Multifuentes Persona Humanav1

Descripción: El Web Service retorna la información de la persona consultada a la Base de Datos del SIPE,  en caso de no encontrarla busca la información en el RENAPER.

Url: https://soa.sanjuan.gob.ar/persona/dni/restv1

Método: Get
Content-Type:  application/json

Parámetros de Entrada:

- dni ( sin puntos )
- sexo  (en letra mayúscula, solo la primera ej.: M para Masculino.

Salida del Ws:

Nombres
Apellido
Sexo
Fecha Nacimiento
Fecha Fallecimiento
cuil
fechaEmisionDni
fechaVencimientoDni
ejemplarDni
idTramiteTarjetaReimpresa
domicilios
Id de Persona
idTramiteRenaper
Origen de BD
fechaActualizaDesdeRenaper

##

{
  "resultadoWS" : {
    "exito" : false,
    "codigoError" : "0001",
    "msgError" : "Error en el servicio"
  }
}

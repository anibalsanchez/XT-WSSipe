function initialState() {
  return {
    consultaDni: {
      query: {
        dni: null,
        sexo: null,
        tramiteNro: null,

        web_token: window.web_token,
      },

      respuesta: {
        nombre: null,
        apellido: null,
        fechaNacimiento: null,
        domicilio: null,
        firma: null,
      },

      incompleta: false,
      procesando: false,

      dniVerificado: false,
      dniValido: false,
    },
  };
}

function verificarConsultaDni(consultaDni) {
  const DELAY = 30 * 1000;

  consultaDni.incompleta = !consultaDni.query.dni
    || !consultaDni.query.sexo
    || !consultaDni.query.tramiteNro
    || !consultaDni.query.web_token;

  if (consultaDni.incompleta) {
    return;
  }

  consultaDni.procesando = true;
  consultaDni.dniVerificado = false;
  consultaDni.dniValido = false;

  const consultaAjax = function () {
    fetch(
      '/index.php?option=com_ajax&plugin=xtwssipe&format=json', {
        method: 'POST',
        body: JSON.stringify(consultaDni.query),
      },
    )
      .then((response) => response.json())
      .then((resultado) => {
        if (resultado && resultado.data && resultado.data[0] && resultado.data[0].estado) {
          consultaDni.dniVerificado = true;
          consultaDni.dniValido = true;
          consultaDni.respuesta = resultado.data[0];

          if (window.gtag) {
            gtag('event', 'verificado');
          }

          return;
        }

        // console.log('Estado inválido');
        consultaDni.dniVerificado = true;
        consultaDni.dniValido = false;
      })
      .catch((err) => {
        // console.log(err);

        consultaDni.dniVerificado = true;
        consultaDni.dniValido = false;
      })
      .finally(() => {
        consultaDni.procesando = false;
      });
  };

  setTimeout(consultaAjax, DELAY);
}

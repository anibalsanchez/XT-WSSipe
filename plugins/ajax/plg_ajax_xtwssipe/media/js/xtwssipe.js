/* eslint-disable no-unused-vars */
/* eslint-disable no-param-reassign */

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
      dniYaEnviado: false,
    },
  };
}

function verificarDniSimple(consultaDni) {
  consultaDni.incompleta = !consultaDni.query.dni
    || !consultaDni.query.sexo
    || !consultaDni.query.tramiteNro
    || !consultaDni.query.web_token;

  if (consultaDni.incompleta) {
    return;
  }

  consultaDni.dniVerificado = true;
  consultaDni.dniValido = true;
}

function verificarConsultaDni(consultaDni) {
  return verificarDniSimple(consultaDni);
}

function verificarConsultaDniApi(consultaDni) {
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
  consultaDni.dniYaEnviado = false;

  function consultaAjax() {
    fetch(
      '/index.php?option=com_ajax&plugin=xtwssipe&format=json', {
        method: 'POST',
        body: JSON.stringify(consultaDni.query),
      },
    )
      .then((response) => response.json())
      .then((resultado) => {
        if (resultado && resultado.data && resultado.data[0]) {
          if (resultado.data[0].estado) {
            consultaDni.dniVerificado = true;
            consultaDni.dniValido = true;
            [consultaDni.respuesta] = resultado.data;

            if (window.gtag) {
              // eslint-disable-next-line no-undef
              gtag('event', 'verificado');
            }

            return;
          }

          if (resultado.data[0].codigoError && resultado.data[0].codigoError === 'ya-recibido') {
            consultaDni.dniYaEnviado = true;
            consultaDni.dniVerificado = false;
            consultaDni.dniValido = false;

            return;
          }
        }

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
  }

  setTimeout(consultaAjax, DELAY);
}

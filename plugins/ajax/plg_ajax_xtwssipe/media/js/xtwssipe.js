function initialState() {
  return {
    consultaDni: {
      query: {
        dni: null,
        sexo: null,
        tramiteNro: null,
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
  consultaDni.incompleta = !consultaDni.query.dni || !consultaDni.query.sexo || !consultaDni.query.tramiteNro;

  if (consultaDni.incompleta) {
    return;
  }

  consultaDni.procesando = true;
  consultaDni.dniVerificado = false;
  consultaDni.dniValido = false;

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

        return;
      }

      console.log('Estado inválido');
      consultaDni.dniVerificado = true;
      consultaDni.dniValido = false;
    })
    .catch((err) => {
      console.log(err);

      consultaDni.dniVerificado = true;
      consultaDni.dniValido = false;
    })
    .finally(() => {
      consultaDni.procesando = false;
    });
}

function (value) {
  // fechaMasDe80AnosDeEdad

  var fechaCorte = luxon.DateTime.fromFormat("28/02/1941", "dd/MM/yyyy");
  var fechaNac = luxon.DateTime.fromFormat(value, "dd/MM/yyyy");

  return fechaNac < fechaCorte;
}

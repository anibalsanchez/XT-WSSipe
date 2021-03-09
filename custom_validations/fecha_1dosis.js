function (value) {
  // fechaDe1DosisDeLaVacuna
  var fechaCorte = luxon.DateTime.fromFormat("01/12/2020", "dd/MM/yyyy");
  var fechaVacuna = luxon.DateTime.fromFormat(value, "dd/MM/yyyy");
  return fechaVacuna > fechaCorte;
}

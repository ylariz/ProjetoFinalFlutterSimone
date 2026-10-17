enum DiaSemana {
  segunda('Segunda'),
  terca('Terça'),
  quarta('Quarta'),
  quinta('Quinta'),
  sexta('Sexta'),
  sabado('Sábado');

  final String label;
  const DiaSemana(this.label);

  static DiaSemana fromString(String valor) {
    return DiaSemana.values.byName(valor);
  }
}

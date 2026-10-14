import 'diasemana.dart';

class Horario {
  final DiaSemana dia;
  final String inicio;
  final String fim;

  const Horario({required this.dia, required this.inicio, required this.fim});

  factory Horario.fromTexto(DiaSemana dia, String texto) {
    final partes = texto.split('-');
    return Horario(
      dia: dia, 
      inicio: partes[0].trim(), 
      fim: partes[1].trim()
    );
  }
}

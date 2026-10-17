import 'diasemana.dart';
import 'horario.dart';

class Monitor {
  final int id;
  final String nome;
  final List<Horario> horarios;

  const Monitor({
    required this.id,
    required this.nome,
    required this.horarios,
  });

  factory Monitor.fromJson(Map<String, dynamic> json) {
    final horariosJson = json['horarios'] as Map<String, dynamic>;
    final List<Horario> horarios = [];

    horariosJson.forEach((chaveDia, listaTextos) {
      final dia = DiaSemana.fromString(chaveDia);

      for (final texto in listaTextos as List) {
        horarios.add(Horario.fromTexto(dia, texto as String));
      }
    });

    return Monitor(
      id: json['id'] as int,
      nome: json['nome'] as String,
      horarios: horarios,
    );
  }
}

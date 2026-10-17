import 'package:flutter/foundation.dart';
import '../data/monitorservice.dart';
import '../model/diasemana.dart';
import '../model/horario.dart';
import '../model/monitor.dart';

class MonitorViewModel extends ChangeNotifier {
  final Monitorservice _service;

  MonitorViewModel(this._service);

  List<Monitor> _todos = [];
  bool _carregando = false;
  String? _erro;

  bool _algoSelecionado = false;
  DiaSemana? _diaSelecionado; 

  bool get carregando => _carregando;
  String? get erro => _erro;
  bool get algoSelecionado => _algoSelecionado;
  DiaSemana? get diaSelecionado => _diaSelecionado;

  List<DiaSemana> get diasDoMenu => [
        DiaSemana.segunda,
        DiaSemana.terca,
        DiaSemana.quarta,
        DiaSemana.quinta,
        DiaSemana.sexta,
      ];

  String get titulo {
    if (!_algoSelecionado) return 'Monitores';
    return _diaSelecionado?.label ?? 'Todos';
  }

  List<Monitor> get monitoresFiltrados {
    if (!_algoSelecionado) return [];
    if (_diaSelecionado == null) return _todos;
    return _todos
        .where((m) => m.horarios.any((h) => h.dia == _diaSelecionado))
        .toList();
  }

  Future<void> carregar() async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      _todos = await _service.buscarMonitores();
    } catch (e) {
      _erro = 'Não foi possível carregar os monitores.';
    }

    _carregando = false;
    notifyListeners();
  }

  void selecionarDia(DiaSemana dia) {
    _algoSelecionado = true;
    _diaSelecionado = dia;
    notifyListeners();
  }

  void selecionarTodos() {
    _algoSelecionado = true;
    _diaSelecionado = null;
    notifyListeners();
  }

  Monitor? buscarPorId(int id) {
    final encontrados = _todos.where((m) => m.id == id);
    return encontrados.isEmpty ? null : encontrados.first;
  }

  List<Horario> horariosDoMonitor(Monitor monitor, DiaSemana? dia) {
    if (dia == null) return monitor.horarios; // veio de "Todos"
    return monitor.horarios.where((h) => h.dia == dia).toList();
  }
}

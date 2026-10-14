import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/monitor.dart';

class Monitorservice {
  static const String _url =
      'https://api.mockfly.dev/mocks/bfbee8e6-9909-496b-af5a-3f457f77a894/monitores';

  Future<List<Monitor>> buscarMonitores() async {
    final resposta = await http.get(Uri.parse(_url));

    if (resposta.statusCode != 200) {
      throw Exception('Erro ao buscar monitores: ${resposta.statusCode}');
    }

    final List<dynamic> lista = jsonDecode(resposta.body);
    return lista
        .map((item) => Monitor.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

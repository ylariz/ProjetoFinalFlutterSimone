import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/diasemana.dart';
import '../viewmodel/monitorviewmodel.dart';

class DetalheScreen extends StatelessWidget {
  final int monitorId;
  final DiaSemana? dia; 

  const DetalheScreen({super.key, required this.monitorId, this.dia});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MonitorViewModel>();
    final monitor = vm.buscarPorId(monitorId);

    if (monitor == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final horarios = vm.horariosDoMonitor(monitor, dia);

   
    return Scaffold(
      appBar: AppBar(title: Text(monitor.nome)),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              dia == null ? 'Todos os horários' : 'Horários de ${dia!.label}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          for (final h in horarios)
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text('${h.inicio} às ${h.fim}'),
              subtitle: dia == null ? Text(h.dia.label) : null,
            ),
        ],
      ),
    );
  }
}

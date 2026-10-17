import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../model/monitor.dart';
import '../viewmodel/monitorviewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MonitorViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text(vm.titulo)),

      drawer: Drawer(
        child: ListView(
          children: [
             DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dias da semana'),
                  const SizedBox(height: 12),
                  Image.asset('assets/logo.png', height: 80),
                ],
              ),
            ),
            for (final dia in vm.diasDoMenu)
              ListTile(
                title: Text(dia.label),
                onTap: () {
                  vm.selecionarDia(dia);
                  Navigator.pop(context);
                },
              ),
            ListTile(
              title: const Text('Todos'),
              onTap: () {
                vm.selecionarTodos();
                Navigator.pop(context); 
              },
            ),
          ],
        ),
      ),

      body: _corpo(context, vm),
    );
  }

  Widget _corpo(BuildContext context, MonitorViewModel vm) {
    if (vm.carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.erro != null) {
      return Center(child: Text(vm.erro!));
    }

    if (!vm.algoSelecionado) {
      return const Center(child: Text('Selecione um dia no menu ☰'));
    }

    return Carrossel(
      key: ValueKey(vm.titulo), 
      monitores: vm.monitoresFiltrados,
      aoClicar: (monitor) {
        final dia = vm.diaSelecionado;
        if (dia == null) {
          context.push('/monitor/${monitor.id}');
        } else {
          context.push('/monitor/${monitor.id}?dia=${dia.name}');
        }
      },
    );
  }
}

class Carrossel extends StatefulWidget {
  final List<Monitor> monitores;
  final void Function(Monitor) aoClicar;

  const Carrossel({super.key, required this.monitores, required this.aoClicar});

  @override
  State<Carrossel> createState() => _CarrosselState();
}

class _CarrosselState extends State<Carrossel> {
  final PageController _controller = PageController(viewportFraction: 0.8);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.monitores.length,
            scrollBehavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
              },
            ),
            itemBuilder: (context, index) {
              final monitor = widget.monitores[index];
              return Card(
                margin: const EdgeInsets.all(12),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => widget.aoClicar(monitor),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person, size: 50),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          monitor.nome,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        const Text('← deslize para ver mais →'),
      ],
    );
  }
}

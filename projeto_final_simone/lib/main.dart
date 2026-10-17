import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/monitorservice.dart';
import 'route/approuter.dart';
import 'viewmodel/monitorviewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MonitorViewModel(Monitorservice())..carregar(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
    );
  }
}

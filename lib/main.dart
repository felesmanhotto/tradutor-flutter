import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Tradutor',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TradutorHome(),
    );
  }
}

class TradutorHome extends StatefulWidget {
  const TradutorHome({super.key});

  @override
  State<TradutorHome> createState() => _TradutorHomeState();
}

class _TradutorHomeState extends State<TradutorHome> {
  final TextEditingController _controller = TextEditingController();
  String _textoTraduzido = '';

  void _traduzirTexto() {
    setState(() {
      _textoTraduzido = _controller.text.split('').reversed.join('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Traduzir')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite o texto a traduzir',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _traduzirTexto,
              child: const Text('Traduzir'),
            ),
            const SizedBox(height: 16),
            Text(
              _textoTraduzido,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

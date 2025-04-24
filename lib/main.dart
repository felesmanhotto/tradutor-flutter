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

  final idiomas = ['Português', 'Inglês', 'Espanhol', 'Francês'];

  String idiomaEntrada = 'Português';
  String idiomaSaida = 'Espanhol';

  void _traduzirTexto() {
    setState(() {
      _textoTraduzido = _controller.text.split('').reversed.join('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Traduzir'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: idiomaEntrada,
                    onChanged: (novoValor) {
                      setState(() {
                        idiomaEntrada = novoValor!;
                      });
                    },
                    items:
                        idiomas.map((idioma) {
                          return DropdownMenuItem<String>(
                            value: idioma,
                            child: Text(idioma),
                          );
                        }).toList(),
                  ),
                ),

                const SizedBox(width: 16),
                const Icon(Icons.arrow_forward),
                const SizedBox(width: 16),

                Expanded(
                  child: DropdownButton<String>(
                    value: idiomaSaida,
                    onChanged: (novoValor) {
                      setState(() {
                        idiomaSaida = novoValor!;
                      });
                    },
                    items:
                        idiomas.map((idioma) {
                          return DropdownMenuItem<String>(
                            value: idioma,
                            child: Text(idioma),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200, // Altura fixa
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          expands: true,
                          decoration: const InputDecoration(
                            labelText: 'Texto original',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Image.asset(
                        'assets/placeholder.png',
                        height: 40,
                      ), // bandeira de entrada
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Output
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: TextField(
                          controller: TextEditingController(
                            text: _textoTraduzido,
                          ),
                          readOnly: true,
                          maxLines: null,
                          expands: true,
                          decoration: const InputDecoration(
                            labelText: 'Texto traduzido',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Image.asset(
                        'assets/placeholder.png',
                        height: 40,
                      ), // bandeira de saída
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _traduzirTexto,
              child: const Text('Traduzir'),
            ),
          ],
        ),
      ),
    );
  }
}

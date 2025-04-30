import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue.shade50,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // cor do botao
            foregroundColor: Colors.white, // cor do texto
            textStyle: const TextStyle(fontSize: 18),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
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
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  final idiomas = [
    'Portuguese',
    'English',
    'Spanish',
    'French',
    'Italian',
    'German',
  ];

  String idiomaEntrada = 'Portuguese';
  String idiomaSaida = 'English';
  bool _isLoading = false;

  Future<void> _traduzirTexto() async {
    final texto = _inputController.text;
    final sourceLang = _converterIdiomaParaCodigo(idiomaEntrada);
    final targetLang = _converterIdiomaParaCodigo(idiomaSaida);

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
      'https://api.mymemory.translated.net/get?q=$texto&langpair=$sourceLang|$targetLang',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final translatedText = jsonBody['responseData']['translatedText'];
        setState(() {
          _outputController.text = translatedText;
        });
      } else {
        _mostrarErro('Translation failed. Please try again later.');
        setState(() {
          _outputController.text = '';
        });
      }
    } catch (e) {
      print('Erro na tradução: $e');
      _mostrarErro(
        'Connection error. Please check your internet and try again.',
      );
      setState(() {
        _outputController.text = '';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _converterIdiomaParaCodigo(String idioma) {
    switch (idioma) {
      case 'Portuguese':
        return 'pt';
      case 'English':
        return 'en';
      case 'Spanish':
        return 'es';
      case 'French':
        return 'fr';
      case 'Italian':
        return 'it';
      case 'German':
        return 'de';
      default:
        return 'en';
    }
  }

  void _mostrarErro(String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _copiarTexto() {
    final texto = _outputController.text;

    if (texto.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: texto));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Translation copied!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Translator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4, // sombra
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        child: Padding(
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

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _inputController,
                              maxLines: null,
                              expands: true,
                              decoration: InputDecoration(
                                labelText: 'Original Text',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Image.asset('assets/$idiomaEntrada.png', height: 40),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Stack(
                                children: [
                                  TextField(
                                    controller: _outputController,
                                    readOnly: true,
                                    maxLines: null,
                                    expands: true,
                                    decoration: InputDecoration(
                                      labelText: 'Translated Text',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        12,
                                        12,
                                        40,
                                        12,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: _copiarTexto,
                                      child: const Icon(
                                        Icons.copy,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Image.asset('assets/$idiomaSaida.png', height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                    onPressed: _traduzirTexto,
                    child: const Text('Translate'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

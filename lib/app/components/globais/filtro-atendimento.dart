import 'package:flutter/material.dart';

class FiltroAtendimento extends StatefulWidget {
  final List<String> subgrupos;
  final List<String> tiposAtendimento;
  final Function(Map<String, dynamic>) onSave;

  FiltroAtendimento({required this.subgrupos, required this.tiposAtendimento, required this.onSave});

  @override
  _FiltroAtendimentoState createState() => _FiltroAtendimentoState();
}

class _FiltroAtendimentoState extends State<FiltroAtendimento> {
  String? selectedItensAssistencia;
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filtros',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  selectedDateRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color(0xFF1B7CB3),
                            onPrimary: Colors.white,
                            onSurface: Color(0xFF1B7CB3),
                            surface: const Color.fromARGB(255, 193, 214, 230),
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Color(0xFF1B7CB3),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  setState(() {});
                },
                child: AbsorbPointer(
                  child: TextField(
                    decoration: _customInputDecoration(
                      selectedDateRange == null
                          ? 'Selecione período para filtrar (máx 15 dias)'
                          : 'Período: ${selectedDateRange?.start.toIso8601String().split('T').first} - ${selectedDateRange?.end.toIso8601String().split('T').first}',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: _customInputDecoration('Entrega de itens assistência humanitária'),
                items: ['Sim', 'Não'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItensAssistencia = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> filters = {
                        'dataInicio': selectedDateRange?.start,
                        'dataFim': selectedDateRange?.end,
                        'itensAssistencia': selectedItensAssistencia == 'Sim',
                      };
                      widget.onSave(filters);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _customInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

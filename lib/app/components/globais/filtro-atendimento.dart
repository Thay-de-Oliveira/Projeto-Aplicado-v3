import 'package:flutter/material.dart';

class FiltroAtendimento extends StatelessWidget {
  final List<String> subgrupos;
  final Function(Map<String, dynamic>) onSave;

  FiltroAtendimento({required this.subgrupos, required this.onSave});

  @override
  Widget build(BuildContext context) {
    String? selectedSubgroup;
    TextEditingController protocoloController = TextEditingController();
    TextEditingController bairroController = TextEditingController();
    DateTimeRange? selectedDateRange;

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
              DropdownButtonFormField<String>(
                decoration: _customInputDecoration('Subgrupo'),
                items: subgrupos.map((String subgroup) {
                  return DropdownMenuItem<String>(
                    value: subgroup,
                    child: Text(subgroup),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedSubgroup = value;
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: protocoloController,
                decoration: _customInputDecoration('Número do protocolo'),
              ),
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
                            primary: Color(0xFF1B7CB3), // cor principal
                            onPrimary: Colors.white, // cor do texto do botão selecionado
                            onSurface: Color(0xFF1B7CB3), // cor do texto dos dias
                            surface: Colors.blue.shade50, // cor da barra de dias selecionados
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Color(0xFF1B7CB3), // cor do texto dos botões
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                },
                child: AbsorbPointer(
                  child: TextField(
                    decoration: _customInputDecoration(
                      selectedDateRange == null
                          ? 'Selecione o período'
                          : 'Período: ${selectedDateRange?.start.toIso8601String().split('T').first} - ${selectedDateRange?.end.toIso8601String().split('T').first}',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: bairroController,
                decoration: _customInputDecoration('Bairro'),
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
                        'subgrupo': selectedSubgroup,
                        'protocolo': protocoloController.text.isEmpty ? null : protocoloController.text,
                        'dataInicio': selectedDateRange?.start,
                        'dataFim': selectedDateRange?.end,
                        'bairro': bairroController.text.isEmpty ? null : bairroController.text,
                      };
                      onSave(filters);
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

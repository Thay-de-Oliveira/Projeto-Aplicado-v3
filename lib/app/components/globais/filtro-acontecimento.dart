import 'package:flutter/material.dart';

class FiltroAcontecimento extends StatefulWidget {
  final List<String> subgrupos;
  final Function(Map<String, dynamic>) onSave;
  final DateTime? initialDataInicio;
  final DateTime? initialDataFim;

  FiltroAcontecimento({
    required this.subgrupos,
    required this.onSave,
    this.initialDataInicio,
    this.initialDataFim,
  });

  @override
  _FiltroAcontecimentoState createState() => _FiltroAcontecimentoState();
}

class _FiltroAcontecimentoState extends State<FiltroAcontecimento> {
  DateTimeRange? selectedDateRange;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.initialDataInicio != null && widget.initialDataFim != null) {
      selectedDateRange = DateTimeRange(
        start: widget.initialDataInicio!,
        end: widget.initialDataFim!,
      );
    }
  }

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
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  DateTimeRange? picked = await showDateRangePicker(
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
                            surface: const Color.fromARGB(255, 193, 214, 230), // cor da barra de dias selecionados
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
                    initialDateRange: selectedDateRange,
                  );

                  if (picked != null) {
                    final daysDifference = picked.end.difference(picked.start).inDays;

                    if (daysDifference > 31) {
                      setState(() {
                        errorMessage = 'O intervalo não pode exceder 31 dias.';
                      });
                    } else {
                      setState(() {
                        selectedDateRange = picked;
                        errorMessage = null;
                      });
                    }
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    decoration: _customInputDecoration(
                      selectedDateRange == null
                          ? 'Selecionar período (máx 31 dias)'
                          : '${selectedDateRange?.start.toIso8601String().split('T').first} a ${selectedDateRange?.end.toIso8601String().split('T').first}',
                    ),
                  ),
                ),
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 10),
                Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ],
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
                      if (selectedDateRange != null) {
                        final daysDifference = selectedDateRange!.end.difference(selectedDateRange!.start).inDays;

                        if (daysDifference > 31) {
                          setState(() {
                            errorMessage = 'O intervalo não pode exceder 31 dias.';
                          });
                        } else {
                          Map<String, dynamic> filters = {
                            'dataInicio': selectedDateRange?.start,
                            'dataFim': selectedDateRange?.end,
                          };
                          widget.onSave(filters);
                          Navigator.of(context).pop();
                        }
                      } else {
                        widget.onSave({});
                        Navigator.of(context).pop();
                      }
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
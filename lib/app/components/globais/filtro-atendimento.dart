import 'package:flutter/material.dart';

class FiltroAtendimento extends StatelessWidget {
  final List<String> subgrupos;

  FiltroAtendimento({required this.subgrupos});

  @override
  Widget build(BuildContext context) {
    String? selectedSubgroup;

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
              const Divider(color: Colors.grey), // Linha fina e cinza
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
                decoration: _customInputDecoration('Número do protocolo'),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: _customInputDecoration('Data do acontecimento'),
              ),
              const SizedBox(height: 10),
              TextField(
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
                      // Ação do botão Salvar
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

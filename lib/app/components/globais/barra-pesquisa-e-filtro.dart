import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  final Function(String) onSearch;

  SearchFilterBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 32,
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Pesquisar',
            hintStyle: TextStyle(
              color: Color(0xFF979797),
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Color(0xFF979797),
              ),
              onPressed: () {
                onSearch(searchController.text);
              },
            ),
          ),
          onChanged: (value) {
            // Lógica de filtragem pode ser adicionada aqui, se necessário.
          },
        ),
      ),
    );
  }
}

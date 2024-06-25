import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final Function() onFilter;

  SearchFilterBar({
    required this.searchController,
    required this.onSearch,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onFilter,
            child: Container(
              width: 65,
              height: 32,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 65,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: Color(0xFFCFDDF2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x269FE3FF),
                            blurRadius: 8,
                            offset: Offset(1, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 6.09,
                    top: 7,
                    child: Container(
                      width: 53.91,
                      height: 18,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 18.91,
                            top: 2,
                            child: SizedBox(
                              width: 35,
                              height: 13,
                              child: Text(
                                'Filtrar',
                                style: TextStyle(
                                  color: Color(0xFF2F2F2F),
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Icon(
                              Icons.filter_list,
                              size: 18,
                              color: Color(0xFF2F2F2F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10), // Adiciona um espaçamento entre o botão e a barra de pesquisa
          Expanded(
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
                onSubmitted: (value) {
                  onSearch(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Botão FILTRO
        InkWell(
          onTap: () {
            // Ação a ser executada quando o botão de filtro for pressionado
            print('Ação de filtro');
          },
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
                        ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: Color(0xff121212),
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ), // Espaço entre o ícone e o texto
                        Text(
                          'Filtrar',
                          style: TextStyle(
                            color: Color(0xFF2F2F2F),
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
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

        // Barra de pesquisa
        Container(
          width: 330,
          height: 32,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 330,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x199FE3FF),
                        blurRadius: 8,
                        offset: Offset(1, 3),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 227,
                top: 8,
                child: Container(
                  width: 15.37,
                  height: 16,
                  child: Stack(
                    children: [],
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 0,
                child: Container(
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: 200.0), //Espaçamento à direita do texto
                        child: Text(
                          'Pesquisar',
                          style: TextStyle(
                            color: Color(0xFF979797),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Color(0xFF979797),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:math';

List<List<String>> boardMatrixCity = 
[
  ['8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8'],
  ['8', '3', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '4', '4', '4', '7', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '4', '4', '4', '7', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '4', '4', '4', '7', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '9', '2', '5', '2', '6', '0', '0', '0', '11', '11', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '11', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '9', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '11', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '4', '4', '4', '4', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'P', '0', '0', '0', '0', '0', '0', '10', '4', '4', '4', '4', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '4', '4', '4', '4', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '9', '2', '2', '5', '2', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '8'],
  ['8', '3', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '3', '8'],
  ['8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8', '8'],
];

List<List<String>> matrizcomplet2 = [
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],
  ['1', '7', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '6', '1'],
  ['1', '4', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '0', '8', '3', '3', '3', '3', '3', '0', '5', '1'],
  ['1', '4', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '8', '3', '3', '3', '3', '3', '10', '0', '5', '1'],
  ['1', '4', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '3', '3', '3', '3', '12', '3', '0', '0', '5', '1'],
  ['1', '4', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '3', '3', '3', '3', '0', '0', '0', '0', '5', '1',],
  ['1', '4', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '3', '3', '3', '3', '0', 'T', '0', '0', '5', '1'],
  ['1', '4', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '3', '3', '3', '3', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '10', '0', '0', '0', '0', '0', '0', '0', '11', '3', '3', '10', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '12', '12', '12', '12', '12', '12', '12', '12', '12', '10', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'I', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '0', '0', '8', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'IM', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '0', '0', '3', '3', '3', '3', '0', '0', '0', '0', '0', '8', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '0', '0', '3', '3', '3', '3', '0', '0', '0', '0', '0', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '0', '0', '3', '3', '3', '3', '9', '0', '0', '0', '0', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '0', '0', '3', '3', '3', '3', '3', '9', '0', '0', '0', '3', '3', '3', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', 'I', '0', '0', '8', '3', '3', '3', '3', '3', '3', '9', '0', '0', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '8', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '0', '0', '5', '1'],
  ['1', '4', 'I', '0', '8', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '3', '3', '3', '3', '12', '12', '3', '3', '3', '3', '0', '0', '0', '0', '5', '1'],
  ['1', '4', 'I', '8', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '0', '0', '3', '3', '3', '3', '0', '0', '11', '3', '3', '3', '3', '0', '0', '0', '5', '1'],
  ['1', '4', '8', '3', '3', '3', '3', '3', '3', '13', '12', '12', '3', '10', '0', '0', '11', '12', '12', '10', '0', '0', '0', '11', '12', '12', '12', '12', '12', '12', '5', '1'],
  ['1', '4', '3', '3', '3', '3', '3', '3', '10', '0', 'P', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '11', '12', '12', '12', '12', '10', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'I', '0', '5', '1'],
  ['1', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '1'],
  ['1', '11', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '1'],
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],

];

List<List<String>> boardMatrix = [
    ['2', '2', '2', '2', '2', '2', '2', '2'],
    ['1', '0', '0', '0', '0', '0', '0', '1'],
    ['1', '0', '0', '0', '0', 'T', '0', '1'],
    ['1', '1', '1', '1', '1', '1', 'M', '1'],
    ['1', '0', '0', '0', '0', '0', '0', '1'],
    ['1', '0', '0', '0', '0', '0', 'R', '1'],
    ['1', 'P', '0', '0', '0', 'A', '0', '1'],
    ['1', '1', '1', '1', '1', '1', '1', '1'],
  ];
  List<List<String>> boardHome = 
[
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],
  ['1', '1', '1', '4', '2', '2', '2', '2', '2', '2', '2', '3', '1', '1', '1', '1'],
  ['1', '1', '1', '4', '7', 'M', '0', '0', '10', '11', '6', '3', '1', '1', '1', '1'],
  ['1', '1', '1', '4', '12', '0', '0', '0', '0', '0', '0', '3', '1', '1', '1', '1'],
  ['1', '1', '1', '4', '0', '0', '0', '0', '0', '0', '0', '3', '1', '1', '1', '1'],
  ['1', '1', '1', '4', '0', '0', '0', '0', '0', '0', 'T', '3', '1', '1', '1', '1'],
  ['1', '1', '1', '4', '9', 'P', '0', '0', '14', '16', '2', '3', '1', '1', '1', '1'],
  ['1', '1', '1', '4', '13', '0', '0', '0', '0', '0', '0', '3', '1', '1', '1', '1'],
  ['1', '1', '1', '4', '0', '0', '0', '0', '0', '0', '0', '3', '1', '1', '1', '1'],
  ['1', '1', '1', '4', '2', '2', '2', '2', '2', '2', '2', '3', '1', '1', '1', '1'],
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],
  ];
List<List<String>> map2 = [
    ['0', 'M', '0', '0', '0', '0', '1', 'T'],
    ['0', '0', '0', '0', '0', '0', '1', '2'],
    ['0', '0', '0', '0', '0', '0', '0', '0'],
    ['0', '0', '0', '0', '0', '0', '0', '0'],
    ['1', '0', '0', '0', '0', '0', '0', '0'],
    ['0', '0', '0', '0', '0', '0', 'R', '0'],
    ['0', '2', '0', '0', '1', '0', '0', '0'],
    ['0', '0', '0', '0', '0', 'P', 'A', '0'],
  ];
  List<List<String>> map2ok = [
    ['0', '0', '0', '0', '0', '0', '0', 'T'],
    ['0', '0', '0', '0', '0', '0', '1', '0'],
    ['0', '0', '0', '0', '0', '0', '0', '0'],
    ['0', '0', '0', '0', '0', '0', '0', '0'],
    ['1', '0', '0', '0', '0', '0', '0', '0'],
    ['0', '0', '0', '0', '0', '0', 'R', '0'],
    ['0', '2', '0', '0', '1', '0', '0', '0'],
    ['0', '0', '0', '0', '0', 'P', 'A', '0'],
  ];

  void movePlayerImg(String direction){}

  void gameOver(){
    
  }
    List<String> groundstypesCity = ["cground1.png", "cground2.png", "cground3.png", "cground4.png", "cground5.png", "cground6.png", "cground7.png","cground8.png","cground9.png","cground10.png"];
    //List<String> grounds = [""];
    List<String> ccemens = ["ccemen1.png", "ccemen2.png", "ccemen3.png", "ccemen4.png"];

  int rows = 32;
  int cols = 32;

  // Função para criar o board com padrões
  List<List<String>> generateBoard(int rows, int cols) {
    List<List<String>> boardMatrix = List.generate(
      rows,
      (_) => List.generate(cols, (_) => '0'),
    );

    // Criar a borda de '8's
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (i == 0 || i == rows - 1 || j == 0 || j == cols - 1) {
          boardMatrix[i][j] = '8'; // Borda de 8
        }
      }
    }

    // Gerar valores aleatórios para o meio da matriz
    Random random = Random();

    for (int i = 1; i < rows - 1; i++) {
      for (int j = 1; j < cols - 1; j++) {
        // Colocando alguns valores aleatórios no meio
        if (boardMatrix[i][j] == '0') {
          boardMatrix[i][j] = random.nextInt(10).toString(); // valores aleatórios de 0 a 9
        }
      }
    }

    // Colocar padrões como 23 e 24 juntos
    placePattern(boardMatrix, rows, cols);

    return boardMatrix;
  }

  // Função para garantir o padrão 23 e 24 juntos
  void placePattern(List<List<String>> boardMatrix, int rows, int cols) {
    Random random = Random();

    for (int i = 1; i < rows - 2; i++) {
      for (int j = 1; j < cols - 2; j++) {
        if (random.nextBool()) { // Decide aleatoriamente se coloca o padrão
          if (boardMatrix[i][j] == '0' && boardMatrix[i][j + 1] == '0') {
            boardMatrix[i][j] = '23';
            boardMatrix[i][j + 1] = '24';
          }
        }
      }
    }
  }

  // Gerar o mapa
  List<List<String>> boardMatrixRandom1 = generateBoard(rows, cols);


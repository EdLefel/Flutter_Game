class Item {
  final String name;
  final String imagePath;
  final String description;
  final int price;
  final int rarity;
  final int valor;
  final int tipo;

  Item({
    required this.name,
    required this.imagePath,
    this.description = '',
    this.price = 0,
    this.rarity = 0,
    this.valor = 0,
    this.tipo = 0,
  });
}
/*
Itens tipo:
0 = armadura
1 = arma
2 = armadura
3 = calça
4 = botas
5 = consumiveis vida
6 = consumiveis mana
7 = consumiveis veneno 
8= consumiveis
*/
final List<Item> items = [
 
];

final List<Item> itemsnews = [
  Item(name: 'Helmet \nde Couro', imagePath: 'assets/items/helmet1.png', description: 'capacete C', price: 10, rarity: 1, valor: 8, tipo: 0),
  Item(name: 'Sword de Aço', imagePath: 'assets/items/sword1.png', description: 'espada C', price: 15, rarity: 0, valor: 2, tipo: 1),
  Item(name: 'Body Armor \n', imagePath: 'assets/items/body1.png',description: 'armadura C', price: 25, rarity: 1, valor: 15, tipo: 2),
  Item(name: 'Pants Armor \nde Couro', imagePath: 'assets/items/pants1.png', description: 'calças C', price: 90, rarity: 1, valor: 10, tipo: 3),
  Item(name: 'Boots \nde Couro', imagePath: 'assets/items/boots1.png',description: 'botas C', price: 90, rarity: 1, valor: 5, tipo: 4),
  Item(name: 'Sword de Damasco', imagePath: 'assets/items/sword2.png', description: 'espada B', price: 500, rarity: 0, valor: 7, tipo: 1),
  Item(name: 'Sword de Lendaria', imagePath: 'assets/items/sword3.png', description: 'espada A', price: 1200, rarity: 0, valor: 18, tipo: 1),
  Item(name: 'Sword Arabe', imagePath: 'assets/items/sword4.png', description: 'espada A+', price: 2000, rarity: 0, valor: 32, tipo: 1),
  Item(name: 'Life Potion', imagePath: 'assets/items/potionlife.png', description: 'espada A+', price: 40, rarity: 0, valor: 25, tipo: 5),




  // Adicione mais itens conforme necessário
];

final Map<String, String> equippedItems = {
  'helmet': 'assets/items/empty_slot.png',
  'body': 'assets/items/empty_slot.png',
  'pants': 'assets/items/empty_slot.png',
  'boots': 'assets/items/empty_slot.png',
  'hand1': 'assets/items/empty_slot.png',
  'hand2': 'assets/items/empty_slot.png',
};

void removeItem(Item item) {
  items.remove(item);
}

void addItem(Item item) {
  items.add(item);
}

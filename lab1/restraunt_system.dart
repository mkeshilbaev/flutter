class MenuItem {
  String name;
  double price;

  MenuItem(this.name, this.price);
}

class OrderItem {
  MenuItem menuItem;
  int quantity;

  OrderItem(this.menuItem, this.quantity);
}

class Order {
  List<OrderItem> items = [];

  void addItem(MenuItem menuItem, int quantity) {
    items.add(OrderItem(menuItem, quantity));
  }

  void removeItem(MenuItem menuItem) {
    items.removeWhere((item) => item.menuItem == menuItem);
  }

  double calculateTotal({double taxRate = 0.1, Function discountFunction = defaultDiscountFunction}) {
    double subtotal = 0.0;

    for (var item in items) {
      subtotal += item.menuItem.price * item.quantity;
    }

    double discount = discountFunction != null ? discountFunction(subtotal) : 0.0;

    double total = subtotal - discount;
    total *= (1 + taxRate); // Apply tax

    return total;
  }

  // Default discount function
  static double defaultDiscountFunction(double subtotal) {
    return subtotal * 0.1;
  }
}

void main() {
  // Создание меню
  var menu = [
    MenuItem("Манты", 2490),
    MenuItem("Оливье", 1690),
    MenuItem("Беш", 4990),
  ];

  // Создание заказа
  var order = Order();

  // Добавление блюд в заказ
  order.addItem(menu[0], 2);
  order.addItem(menu[1], 1);

  // Удаление блюда из заказа
  order.removeItem(menu[0]);

  // Расчет и вывод итоговой стоимости заказа
  print("Счет: ${order.calculateTotal().toStringAsFixed(2)} \KZT");
}
abstract class Character {
  String name;
  int health;
  int strength;

  Character(this.name, this.health, this.strength);

  void attack(Character target) {
    print('$name attacks ${target.name}!');
    target.receiveDamage(strength);
  }

  void receiveDamage(int damage) {
    health -= damage;
    print('$name damaged by: -$damage hp');
    if (health <= 0) {
      print('$name defeat.');
    }
  }
}

// Интерфейс для персонажей, способных летать
mixin Flyable {
  void fly(String name) {
    print('$name flying in the sky!');
  }
}

// Интерфейс для персонажей с магическими способностями
mixin Magical {
  void castSpell(String name) {
    print('$name conjures a spell!');
  }
}

// Класс воина, наследующийся от персонажа
class Warrior extends Character {
  Warrior(String name) : super(name, 100, 20);
}

// Класс мага, наследующийся от персонажа и использующий миксин Magical
class Mage extends Character with Magical, Flyable {
  Mage(String name) : super(name, 80, 15);
}

// Класс монстра, наследующийся от персонажа
class Monster extends Character {
  Monster(String name) : super(name, 50, 10);
}

void main() {
  // Создание персонажей
  var warrior = Warrior('Warrior');
  var mage = Mage('Magician');
  var monster = Monster('Monster');

  // Взаимодействие персонажей
  warrior.attack(monster);
  mage.castSpell(mage.name);
  monster.attack(warrior);

  // Применение миксина для персонажа
  var flyingMage = Mage('Flyung magician')..fly('Flyung magician');
}
class InsufficientFundsException implements Exception {
  String errorMessage() => 'Недостаточно средств на счете';
}

class BankAccount {
  String owner;
  double balance;

  BankAccount(this.owner, this.balance);

  void deposit(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Сумма вклада должна быть положительной');
    }
    balance += amount;
    print('$owner, внесено: $amount, баланс: $balance');
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Сумма снятия должна быть положительной');
    }
    if (amount > balance) {
      throw InsufficientFundsException();
    }
    balance -= amount;
    print('$owner, снято: $amount, баланс: $balance');
  }

  void transfer(BankAccount recipient, double amount) {
    if (amount <= 0) {
      throw ArgumentError('Сумма перевода должна быть положительной');
    }
    if (amount > balance) {
      throw InsufficientFundsException();
    }
    withdraw(amount);
    recipient.deposit(amount);
    print('$owner, переведено $amount пользователю ${recipient.owner}');
  }

  double getBalance() {
    return balance;
  }
}

void main() {
  try {
    var account1 = BankAccount('Madi', 1000);
    var account2 = BankAccount('Nariman', 500);

    account1.deposit(200);
    account1.withdraw(150);
    account1.transfer(account2, 100);

    print('Баланс Madi: ${account1.getBalance()}');
    print('Баланс Nariman: ${account2.getBalance()}');

    // Примеры обработки ошибок
    account1.withdraw(1000); // Недостаточно средств
    account1.deposit(-50);   // Ошибка аргумента
  } catch (e) {
    print('Произошла ошибка: $e');
  }
}
class Library {
  Map<int, Book> books = {};
  List<Reader> readers = [];
  Set<Book> issuedBooks = {};

  // Добавление книги в библиотеку
  void addBook(int id, String title, String author) {
    books[id] = Book(id, title, author);
  }

  // Удаление книги из библиотеки
  void removeBook(int id) {
    books.remove(id);
  }

  // Регистрация нового читателя
  void registerReader(String name, DateTime registrationDate) {
    readers.add(Reader(name, registrationDate));
  }

  // Удаление информации о читателе
  void removeReader(String name) {
    readers.removeWhere((reader) => reader.name == name);
  }

  // Выдача книги читателю
  void issueBook(int bookId, String readerName) {
    Book? book = books[bookId];
    Reader? reader = readers.firstWhere((reader) => reader.name == readerName);

    if (book != null && reader != null && !issuedBooks.contains(book)) {
      reader.takeBook(book);
      issuedBooks.add(book);
      print('${reader.name} взял книгу "${book.title}"');
    } else {
      print('Ошибка: Книга не найдена или уже выдана, либо читатель не зарегистрирован.');
    }
  }

  // Возврат книги в библиотеку
  void returnBook(int bookId, String readerName) {
    Book? book = books[bookId];
    Reader? reader = readers.firstWhere((reader) => reader.name == readerName);

    if (book != null && reader != null && issuedBooks.contains(book)) {
      reader.returnBook(book);
      issuedBooks.remove(book);
      print('${reader.name} вернул книгу "${book.title}"');
    } else {
      print('Ошибка: Книга не найдена или не была выдана, либо читатель не зарегистрирован.');
    }
  }

  // Поиск книг по названию или автору
  List<Book> searchBooks(String query) {
    return books.values
        .where(
          (book) =>
              book.title.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // Фильтрация списка читателей по критериям
  List<Reader> filterReaders(bool Function(Reader) filterFunction) {
    return readers.where(filterFunction).toList();
  }
}

class Book {
  final int id;
  final String title;
  final String author;

  Book(this.id, this.title, this.author);
}

class Reader {
  final String name;
  final DateTime registrationDate;
  List<Book> borrowedBooks = [];

  Reader(this.name, this.registrationDate);

  void takeBook(Book book) {
    borrowedBooks.add(book);
  }

  void returnBook(Book book) {
    borrowedBooks.remove(book);
  }
}

void main() {
  // Пример использования системы управления библиотекой
  Library library = Library();

  // Добавление книг в библиотеку
  library.addBook(1, "The Great Gatsby", "F. Scott Fitzgerald");
  library.addBook(2, "To Kill a Mockingbird", "Harper Lee");
  library.addBook(3, "1984", "George Orwell");

  // Регистрация читателей
  library.registerReader("Madi", DateTime.now());
  library.registerReader("Serik", DateTime.now());

  // Выдача и возврат книг
  library.issueBook(1, "Madi");
  library.issueBook(2, "Serik");
  library.returnBook(1, "Ainur");

  // Поиск книг
  List<Book> searchResult = library.searchBooks("Mockingbird");
  print(
      'Результат поиска: ${searchResult.map((book) => book.title).join(", ")}');

  // Фильтрация списка читателей
  List<Reader> filteredReaders =
      library.filterReaders((reader) => reader.borrowedBooks.isNotEmpty);
  print(
      'Читатели с взятыми книгами: ${filteredReaders.map((reader) => reader.name).join(", ")}');
}
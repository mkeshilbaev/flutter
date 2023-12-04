import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Animal {
  final String name;
  final String imageUrl;
  final List<String> imageUrls;
  final String description;

  Animal({required this.name, required this.imageUrl, required this.imageUrls, required this.description});
}

final List<Animal> allAnimals = [
  Animal(name: 'Lion', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaNBC-P9efdGn1i98vXxj0O2SI329iS4YZLA&usqp=CAU', imageUrls: ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaNBC-P9efdGn1i98vXxj0O2SI329iS4YZLA&usqp=CAU', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFuo2H8zrA81dAiIDJzsUOzxB3h8gXa0ifvw&usqp=CAU'], description: 'The king of the jungle'),
  Animal(name: 'Elephant', imageUrl: 'https://i.natgeofe.com/k/78b20329-9758-42c3-baa4-10c613dd2820/baby-african-elephant.jpg?w=1084.125&h=609', imageUrls: ['https://i.natgeofe.com/k/78b20329-9758-42c3-baa4-10c613dd2820/baby-african-elephant.jpg?w=1084.125&h=609', 'https://u4d2z7k9.rocketcdn.me/wp-content/uploads/2021/08/rsz_william_fortescue-7.jpg'], description: 'The gentle giant'),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Zoo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimalListScreen(),
    );
  }
}

class AnimalListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Zoo'),
      ),
      body: ListView.builder(
        itemCount: allAnimals.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(allAnimals[index].imageUrl),
            ),
            title: Text(allAnimals[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalDetailsScreen(animal: allAnimals[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AnimalDetailsScreen extends StatefulWidget {
  final Animal animal;

  AnimalDetailsScreen({required this.animal});

  @override
  _AnimalDetailsScreenState createState() => _AnimalDetailsScreenState();
}

class _AnimalDetailsScreenState extends State<AnimalDetailsScreen> {
  bool isFavorite = false;
  int currentImageIndex = 0;

  void _changeImage() {
    setState(() {
      currentImageIndex = (currentImageIndex + 1) % widget.animal.imageUrls.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animal.name),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.animal.imageUrls[currentImageIndex],
              height: 150.0,
            ),
            SizedBox(height: 16.0),
            Text('Name: ${widget.animal.name}'),
            Text('Description: ${widget.animal.description}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _changeImage,
              child: Text('Change Image'),
            ),
            // Add more information about the animal
          ],
        ),
      ),
    );
  }
}


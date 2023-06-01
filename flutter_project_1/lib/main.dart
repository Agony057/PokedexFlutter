import 'package:flutter/material.dart';
import 'package:flutter_project_1/pokemon/pokemon.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // <== définit le thème Light
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        // <== définit le thème Dark
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
      // home: SnackBarPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final pokedex = <Pokemon>[
    // <== liste finale, contenu constant
    Pokemon(name: 'Artikodin', icon: Icons.ac_unit),
    Pokemon(name: 'Sulfura', icon: Icons.fireplace),
    Pokemon(name: 'Elektor', icon: Icons.thunderstorm),
    Pokemon(name: 'Mewtwo', icon: Icons.remove_red_eye),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premier projet'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        labelText: 'Ecrivez un nom',
                      ),
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        final nameToAdd = controller.text.toUpperCase().trim();

                        if (pokedex.contains(nameToAdd)) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Le pokemon existe déjà !"),
                          ));
                        } else if (nameToAdd.length < 3) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Ecrire au moins 3 caractères !"),
                          ));
                        } else {
                          pokedex.insert(
                              0,
                              Pokemon(
                                  icon: Icons.emoji_emotions, name: nameToAdd));
                          setState(() {});
                          controller.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
              for (final Pokemon item in pokedex)
                TheAmazingRow(
                  icon: item.icon,
                  label: item.name.toUpperCase(),
                  onDelete: () => onPokemonDelete(item.name),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void onPokemonDelete(String nameToDelete) {
    pokedex.removeWhere((element) => element.name == nameToDelete);
    setState(() {});
  }
}

class TheAmazingRow extends StatelessWidget {
  const TheAmazingRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.onDelete,
  }) : super(key: key);
// la c'est entre le constructeur
  final IconData icon;
  final String label;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 16),
              Expanded(
                child: Text(label),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(),
              ),
            ],
          )),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnackBar Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final snackBar = SnackBar(
              content: const Text('Yay! A SnackBar!'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: const Text('Show SnackBar'),
        ),
      ),
    );
  }
}

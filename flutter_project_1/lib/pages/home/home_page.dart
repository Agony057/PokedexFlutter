import 'package:flutter/material.dart';
import 'package:flutter_project_1/pages/home/widgets/the_amazing_row.dart';
import 'package:flutter_project_1/pokemon/pokedex.dart';
import 'package:flutter_project_1/pokemon/pokemon.dart';

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

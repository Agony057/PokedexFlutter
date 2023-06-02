import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonName = ModalRoute.of(context)!.settings.arguments as String;
    // final pokemonIcon = ModalRoute.of(context)!.settings.arguments as IconData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SnackBar Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            // Icon(pokemonIcon),
            Text(pokemonName),
          ],
        ),
      ),
    );
  }
}

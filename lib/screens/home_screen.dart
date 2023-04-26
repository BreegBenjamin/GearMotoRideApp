import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:gear_moto_ride_app/search/search_delegate.dart';
import 'package:gear_moto_ride_app/providers/movies_provider.dart';
import 'package:gear_moto_ride_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Gear Moto Ride'),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Card Motos

              // Tarjetas principales
              CardSwiper(motorcycle: moviesProvider.listMotocicles),

              // Slider de Motos
              GearMotoSlider(
                motorcycles: moviesProvider.listMotocicles, // populares,
                title: 'Lista de motos', // opcional
                onNextPage: () => moviesProvider.getMotorcycleByPagination(),
              ),
            ],
          ),
        ));
  }
}

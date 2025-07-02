import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty/business_logic/cubit/characters_cubit.dart';
import 'package:ricky_morty/data/models/character.dart';
import 'package:ricky_morty/data/repository/characters_repository.dart';
import 'package:ricky_morty/data/web_services/characters_web_services.dart';
import 'package:ricky_morty/presentation/screens/character_details_screen.dart';
import 'constants/strings.dart';
import 'package:ricky_morty/presentation/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => charactersCubit,
                child: CharactersScreen(),
              ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(character: character),
        );
    }
    return null;
  }
}

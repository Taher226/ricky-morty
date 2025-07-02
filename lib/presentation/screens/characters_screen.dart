import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty/business_logic/cubit/characters_cubit.dart';
import 'package:ricky_morty/constants/my_colors.dart';
import 'package:ricky_morty/data/models/character.dart';
import 'package:ricky_morty/presentation/widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> filteredCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();
  Widget buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedItemsToSearchedList(String searchedCharacter) {
    filteredCharacters =
        allCharacters
            .where(
              (character) =>
                  character.name.toLowerCase().startsWith(searchedCharacter),
            )
            .toList();
    setState(() {
      buildAppBarActions();
    });
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColors.myGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: Icon(Icons.search, color: MyColors.myGrey),
        ),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoading) {
          return showLoadingIndicator();
        } else if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildLoadedListWidgets();
        } else if (state is CharactersError) {
          return Center(child: Text('Error loading characters'));
        }
        return Container();
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(child: CircularProgressIndicator(color: MyColors.myYellow));
  }

  Widget buildLoadedListWidgets() {
    return Container(
      color: MyColors.myGrey,
      child: Column(
        children: [
          Expanded(child: SingleChildScrollView(child: buildCharactersList())),
        ],
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount:
          searchTextController.text.isEmpty
              ? allCharacters.length
              : filteredCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character:
              searchTextController.text.isEmpty
                  ? allCharacters[index]
                  : filteredCharacters[index],
        );
      },
    );
  }

  Widget buildAppBarTitle() {
    return Text('Characters', style: TextStyle(color: MyColors.myGrey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
        leading: isSearching ? BackButton(color: MyColors.myGrey) : null,
        backgroundColor: MyColors.myYellow,
      ),
      body: buildBlocWidget(),
    );
  }
}

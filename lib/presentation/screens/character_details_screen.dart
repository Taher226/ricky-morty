import 'package:flutter/material.dart';
import 'package:ricky_morty/constants/my_colors.dart';
import 'package:ricky_morty/data/models/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({super.key, required this.character});
  Widget buildSliverAppBar() {
    return SliverAppBar(
      iconTheme: IconThemeData(color: MyColors.myWhite),
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(character.name, style: TextStyle(color: MyColors.myWhite)),
        background: Hero(
          tag: character.id,
          child: Image.network(character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: MyColors.myWhite, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Episodes :', character.episode.join(' -- ')),
                    buildDivider(240),
                    characterInfo('Location :', character.location['name']),
                    buildDivider(250),
                    character.type.isEmpty
                        ? Container()
                        : characterInfo('Type :', character.type),
                    character.type.isEmpty ? Container() : buildDivider(280),
                    characterInfo('Origin :', character.origin['name']),
                    buildDivider(270),
                    characterInfo('status :', character.status),
                    buildDivider(260),
                    characterInfo('species :', character.species),
                    buildDivider(250),
                    characterInfo('gender :', character.gender),
                    buildDivider(240),
                  ],
                ),
              ),
              SizedBox(height: 600),
            ]),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ricky_morty/constants/my_colors.dart';
import 'package:ricky_morty/constants/strings.dart';
import 'package:ricky_morty/data/models/character.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            characterDetailsScreen,
            arguments: character,
          );
        },
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: TextStyle(
                height: 1.3,
                color: MyColors.myWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: character.id,
            child: Container(
              color: MyColors.myGrey,

              child: Image.network(
                character.image,
                fit: BoxFit.fill,
                errorBuilder:
                    (context, error, stackTrace) =>
                        Image.asset('assets/images/noImage.png'),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: Image.asset(
                      'assets/images/loadingIndicator.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

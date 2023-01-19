import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinch_assignment/domain/database/entities/game_entity.dart';
import 'package:flutter_pinch_assignment/presentation/widgets/rating.dart';
import 'package:flutter_pinch_assignment/router/app_router.gr.dart';

import '../../utils/constants.dart';

class GameTile extends StatelessWidget {
  const GameTile(this.game, {super.key});

  final GameEntity? game;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      height: 230,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                color: ThemeColors.containerDarkColor,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff21264b).withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(8, 8), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      game != null ? _Thumbnail(game!.coverImage) : Container(),
                      const SizedBox(height: 30),
                      game != null ? _Rating(game!.rating) : Container()
                    ],
                  ),
                  game != null ? _Body(game!.name, game!.description) : Container()
                ],
              )
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35)),
              ),
              width: double.infinity,
              height: double.infinity,
              child: MaterialButton(
                splashColor: ThemeColors.defaultButtonColor.withOpacity(0.2),
                highlightColor: Colors.white.withOpacity(0.1),
                onPressed: () => AutoRouter.of(context).push(DetailRoute(game: game!)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail(this.image, {Key? key}) : super(key: key);

  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: SizedBox(
        height: 75,
        child: Image.memory(
          image,
          errorBuilder: (context, error, stackStrace){
            return const Icon(Icons.error, color: Colors.white);
          },
        ),
      ),
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating(this.rating, {Key? key}) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Rating(
      rating: rating,
      size: 60,
      trackWidth: 10,
      fontSize: 14,
      animation: false,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.title, this.description, {Key? key}) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                overflow: TextOverflow.ellipsis,
              )
            ),
            const SizedBox(height: 15.0),
            Text(
              description,
              maxLines: 7,
              style:  Theme.of(context).textTheme.bodySmall!.copyWith(
                overflow: TextOverflow.ellipsis,
              )
            ),
          ],
        ),
      ),
    );
  }
}


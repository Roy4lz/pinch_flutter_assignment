import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinch_assignment/domain/database/entities/game_entity.dart';
import 'package:intl/intl.dart';

import '../widgets/rating.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(this._game, {Key? key}) : super(key: key);

  final GameEntity _game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff30355e),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: false,
              floating: false,
              delegate: _CoverHeaderDelegate(_game.coverImage, _game.rating)
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _game.name,
                      style: Theme.of(context).textTheme.headlineLarge
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Release date: ${DateFormat('MMM d, yyyy').format(DateTime.fromMillisecondsSinceEpoch((_game.releaseDate*1000).round()))}",
                      style: Theme.of(context).textTheme.bodySmall
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _game.description,
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                    const SizedBox(height: 30),
                    Text(
                      _game.storyline,
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                    const SizedBox(height: 50),
                  ],
                )
              ),
            ]),
          )
        ],
      )
    );
  }
}


class _CoverHeaderDelegate extends SliverPersistentHeaderDelegate {
  _CoverHeaderDelegate(this._image, this._rating);

  final Uint8List _image;
  final double _rating;

  @override
  Widget build(
    BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 600,
          child: Image.memory(
            _image,
            errorBuilder: (context, error, stackStrace){
              return const Icon(Icons.error, color: Colors.white);
            },
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        SizedBox(
          height: 700,
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  const Color(0xff30355e),
                  const Color(0xff30355e).withOpacity(0),
                ],
              )
            ),
            //To get rid of this 1 pixel bug in sliver list.
            child: Container(
              height: 3,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: Color(0xff30355e),
                boxShadow: [BoxShadow(
                    color: Color(0xff30355e),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30, top: 90),
          child: Align(
            alignment: Alignment.topRight,
            child: Rating(
              rating: _rating,
              size: 100,
              trackWidth: 12,
              fontSize: 25,
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 90),
          child: IconButton(
            padding: EdgeInsets.zero,
            iconSize: 35,
            icon: Icon(Icons.arrow_back_ios_new_rounded,
              shadows: <Shadow>[
                Shadow(color: const Color(0xff30355e).withOpacity(0.3),
                    blurRadius: 6.0,
                    offset: const Offset(2, 1)
                )
              ],
            ),
            constraints: const BoxConstraints(),
            color: Colors.white,
            onPressed: () => {
              AutoRouter.of(context).pop()
            },
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 500;

  @override
  double get minExtent => 500 / 1.6;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

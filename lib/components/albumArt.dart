import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Album art
class AlbumArt extends StatelessWidget {
  final String path;

  /// Whether to use large variant (used in playerRoute)
  final bool isLarge;

  /// Creates round album art if true
  final bool round;
  AlbumArt(
      {Key key, @required this.path, this.isLarge: false, this.round: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: path != null
            ? _AlbumArtPic(path: path, isLarge: isLarge, round: round)
            : _AlbumArtPlaceholder(isLarge: isLarge, round: round));
  }
}

class _AlbumArtPic extends StatelessWidget {
  final String path;
  final bool isLarge;
  final bool round;
  const _AlbumArtPic(
      {Key key,
      @required this.path,
      @required this.isLarge,
      @required this.round})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.all(
            Radius.circular(round ? constraint.maxHeight : 10)),
        child: Image.file(
          File(path),
          width: isLarge
              ? constraint.maxWidth - 80
              : round // Reduce the size of art if using round
                  ? constraint.maxHeight -
                      6 -
                      3 // The `CircularPercentIndicator` `lineWidth` doubled and additional 3 spacing
                        -2 // Border width
                  : constraint.maxHeight,
          height: isLarge
              ? constraint.maxWidth - 80
              : round // Reduce the size of art if using round
                  ? constraint.maxHeight -
                      6 -
                      3 // The `CircularPercentIndicator` `lineWidth` doubled and additional 3 spacing
                        -2 // Border width
                  : constraint.maxHeight,
          fit: BoxFit.fill,
        ),
      );
    });
  }
}

class _AlbumArtPlaceholder extends StatelessWidget {
  final bool isLarge;
  final bool round;
  const _AlbumArtPlaceholder({
    Key key,
    @required this.isLarge,
    @required this.round,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint1) {
      return Container(
        width: isLarge
            ? constraint1.maxWidth - 80
            : round // Reduce the size of art if using round
                ? constraint1.maxHeight -
                    6 -
                    3 // The `CircularPercentIndicator` `lineWidth` doubled and additional 3 spacing
                    -2 // Border width
                : constraint1.maxHeight,
        height: isLarge
            ? constraint1.maxWidth - 80
            : round // Reduce the size of art if using round
                ? constraint1.maxHeight -
                    6 -
                    3 // The `CircularPercentIndicator` `lineWidth` doubled and additional 3 spacing
                      -2 // Border width
                : constraint1.maxHeight,
        decoration: BoxDecoration(
          // color: Colors.white.withOpacity(0.04),
          color: isLarge ?  Colors.white.withOpacity(0.9):Colors.white.withOpacity(1),
          borderRadius: BorderRadius.all(Radius.circular(round ? 500 : 10)),
        ),
        padding: isLarge ? EdgeInsets.all(70) : EdgeInsets.all(round?8:10),
        child: LayoutBuilder(builder: (context, constraint) {
          // return Icon(
          //   Icons.music_note,
          //   size: isLarge
          //       ? constraint.biggest.width - 115
          //       : constraint.biggest.height,
          //   color: Colors.deepPurple,
          // );
          return SvgPicture.asset(
            'images/icons/note_rounded.svg',
          );
        }),
      );
    });
  }
}
// TODO: refactor constructors and add comments

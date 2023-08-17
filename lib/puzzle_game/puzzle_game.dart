// import 'package:flutter/material.dart';
// import 'dart:math';

// class PuzzleGame extends StatefulWidget {
//   @override
//   _PuzzleGameState createState() => _PuzzleGameState();
// }

// class _PuzzleGameState extends State<PuzzleGame> {
//   List<Widget> puzzlePieces = [];
//   List<int> correctOrder = [0, 1, 2, 3, 4, 5, 6, 7, 8];
//   int emptyIndex = 8;

//   @override
//   void initState() {
//     super.initState();
//     // Load the puzzle image and divide it into smaller pieces
//     Image puzzleImage = Image.asset('assets/puzzle.jpg');
//     puzzleImage.image.resolve(ImageConfiguration()).addListener(
//       (ImageStreamListener((ImageInfo info, bool _) {
//         int width = info.image.width;
//         int height = info.image.height;
//         int pieceWidth = width ~/ 3;
//         int pieceHeight = height ~/ 3;

//         // Create a list of smaller puzzle pieces
//         List<ImageProvider> imagePieces = [];
//         for (int i = 0; i < 9; i++) {
//           int x = (i % 3) * pieceWidth;
//           int y = (i ~/ 3) * pieceHeight;
//           imagePieces.add(
//             CropImageProvider(
//               puzzleImage.image,
//               x: x,
//               y: y,
//               width: pieceWidth,
//               height: pieceHeight,
//             ),
//           );
//         }

//         // Shuffle the puzzle pieces
//         List<int> randomOrder = List.generate(9, (index) => index)..shuffle();
//         puzzlePieces = randomOrder
//             .map((index) => PuzzlePiece(
//                   image: imagePieces[index],
//                   correctIndex: correctOrder.indexOf(index),
//                   onMoved: _handlePieceMoved,
//                 ))
//             .toList();
//         setState(() {});
//       })),
//     );
//   }

//   void _handlePieceMoved(int index) {
//     // Check if the puzzle is complete
//     if (List.generate(9, (index) => puzzlePieces[index].currentIndex) ==
//         correctOrder) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: Text('Congratulations!'),
//           content: Text('You solved the puzzle!'),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 setState(() {
//                   emptyIndex = 8;
//                   puzzlePieces = puzzlePieces
//                       .map((piece) => piece.resetPosition())
//                       .toList();
//                 });
//               },
//               child: Text('Play Again'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Puzzle Game'),
//       ),
//       body: GridView.count(
//         crossAxisCount: 3,
//         children: List.generate(9, (index) {
//           if (index == emptyIndex) {
//             return PuzzlePiece(
//               image: null,
//               correctIndex: null,
//               onMoved: _handlePieceMoved,
//             );
//           } else {
//             return puzzlePieces[index];
//           }
//         }),
//       ),
//     );
//   }
// }

// class PuzzlePiece extends StatefulWidget {
//   final ImageProvider image;
//   final

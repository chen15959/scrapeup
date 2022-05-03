import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';






class GamePage extends StatefulWidget {
  const GamePage({required this.target, this.width = 6, this.height = 7, Key? key}) : super(key: key);

  ///
  final int target;

  final int width;
  final int height;


  @override
  State<GamePage> createState() => _GamePageState();
}



class _GamePageState extends State<GamePage> {

  List<int> _puzzle = [];

  @override
  void initState() {
    super.initState();
    int total = widget.width * widget.height;
    List<int> value = [];

    while (value.length < total) {
      int r = math.Random.secure().nextInt(widget.target - 1) + 1;
      value.add(r);
      value.add(widget.target - r);
    }

    while (value.isNotEmpty) {
      _puzzle.add(value.removeAt(math.Random.secure().nextInt(value.length)));
    }
  }

  int _current = -1;








  @override
  Widget build(BuildContext context) {
    List<Widget> cells = [];

    bool done = true;
    for (int i = 0; i < _puzzle.length; ++i) {
      if (_puzzle[i] >= 0) {
        done = false;
      }

      cells.add(Container(
        width: double.infinity, height: double.infinity,
        color: _current == i ? Colors.red : Colors.white,
          child: FittedBox(
            // 居中
            child: Center(
              // 内容
              child: _puzzle[i] < 0 ? null :
                TextButton(
                child: Text(_puzzle[i].toString(), style: TextStyle(fontSize: 9999,)),
                onPressed: () {
                  setState(() {
                    if (_current >= 0) {
                      if (_puzzle[i] + _puzzle[_current] == widget.target) {
                        // todo good beep
                        _puzzle[_current] = -1;
                        _puzzle[i] = -1;
                        _current = -1;
                      }
                      else {
                        //todo bad beep
                        _current = -1;
                      }
                    }
                    else {
                      _current = i;
                    }
                  });
                },
                onLongPress: () {
                  setState(() {
                    _current = -1;
                  });
                },
              )
              )
          )
      ));
    }


    if (done) {

    }












    return Scaffold(
      appBar: AppBar(
        title: Text("? + ? = " + widget.target.toString()),
      ),
      body:
      Center(
        child: Padding(
          padding: EdgeInsets.all(math.min(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width) * 0.05),
            child: GridView.count(crossAxisCount: widget.width, children: cells)
          ),
        )
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Flexible(flex: 1,
      //         child: TextButton(
      //           child: const ImageIcon(AssetImage('assets/left-arrow.png')),
      //           onPressed: () {
      //             Navigator.of(context).pushReplacement(
      //                 MaterialPageRoute(builder: (context) =>
      //                     GamePage(puzzles: widget.puzzles.moveToPrev()))
      //             );
      //           },
      //         ),
      //       ),
      //       Flexible(flex: 1,
      //         child: TextButton(
      //           child: const ImageIcon(AssetImage('assets/undo.png'), ),
      //           onPressed: () {
      //             setState(() {
      //               _undoCmd = true;
      //             });
      //           },
      //         ),
      //       ),
      //       const Flexible(flex: 1, child: Text('                                                                                                                                    ')),
      //       Flexible(flex: 1,
      //         child: TextButton(
      //           child: const ImageIcon(AssetImage('assets/redo.png')),
      //           onPressed: () {
      //             setState(() {
      //               _redoCmd = true;
      //             });
      //           },
      //         ),
      //       ),
      //       Flexible(flex: 1,
      //         child: TextButton(
      //           child: const ImageIcon(AssetImage('assets/right-arrow.png')),
      //           onPressed: () {
      //             Navigator.of(context).pushReplacement(
      //                 MaterialPageRoute(builder: (context) =>
      //                     GamePage(puzzles: widget.puzzles.moveToNext()))
      //             );
      //           },
      //         ),
      //       ),
      //     ]
      //     ,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   child: Image(image: AssetImage('assets/check.png')),
      //   onPressed: () async {
      //     //TODO check
      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (context) =>
      //             GamePage(puzzles: widget.puzzles.moveToNext()))
      //     );
      //     // print("game.undoCmd=$_undoCmd");
      //     // print("game.redoCmd=$_redoCmd");
      //   },
      //   tooltip: 'check',
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }






}




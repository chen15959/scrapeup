import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';


/*
Widget buildGamePage(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  if (width == 1728 && height == 1080) {
    //pad横屏
  }
  else if (width == 1080 && height == 1728) {
    //pad竖屏
  }
  else {
    //其他

  }


  return null;
}


class SPadGamePage extends GamePage {

//  SPadGamePage({required this.target, this.max = 2147483647, this.size = 48, this.widthL = 12, this.widthP = 6, Key? key}) : super();

}
*/


class GamePage extends StatefulWidget {
  GamePage({required this.target, this.max = 2147483647,
    this.widthP = 4, this.heightP = 6, this.widthL = 8, this.heightL = 3,
    this.paddingPH = 62.0, this.paddingPV = 32.0, this.paddingLH = 1.0, this.paddingLV = 55.0, this.innerPadding = 4.0,
    Key? key}) : super(key: key) {
    if (widthP * heightP != widthL * heightL) {
      throw "数据大小不匹配";
    }
  }

  // 加法的目标值
  final int target;
  // 加数的最大值
  final int max;

  // 竖屏时矩阵宽度
  final int widthP;
  // 竖屏时矩阵高度
  final int heightP;

  // 横屏时矩阵宽度
  final int widthL;
  // 横屏时矩阵高度
  final int heightL;

  // 竖屏时横向padding
  final double paddingPH;
  // 竖屏时竖向padding
  final double paddingPV;

  // 横屏时横向padding
  final double paddingLH;
  // 横屏时竖向padding
  final double paddingLV;

  // cell间padding
  final double innerPadding;


  @override
  State<GamePage> createState() => _GamePageState();
}



class _GamePageState extends State<GamePage> {

  /// 谜题
  ///
  List<int> _puzzle = [];

  /// 当前选中的格子
  ///
  int _current = -1;

  /// 计时器
  ///
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //   });
    // });


    List<int> value = [];

    while (value.length < widget.heightL * widget.widthL) {
      int r = math.Random.secure().nextInt(math.min(widget.target - 1, widget.max)) + 1;
      value.add(r);
      value.add(widget.target - r);
    }

    while (value.isNotEmpty) {
      _puzzle.add(value.removeAt(math.Random.secure().nextInt(value.length)));
    }
  }


  @override
  void disppose() {
    // _timer!.cancel();

    super.dispose();
  }










  @override
  Widget build(BuildContext context) {
    List<Widget> cells = [];

    int left = 0;

    for (int i = 0; i < _puzzle.length; ++i) {
      if (_puzzle[i] >= 0) {
        left++;
      }

      cells.add(
        Padding(padding: EdgeInsets.all(5), child:
          Container(
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

                        if (left == 2) {
                          showDialog(context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("太棒啦！在...内解决了问题！"),
                                  actions: [
                                    TextButton(child: Text(r'再来一局'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(builder: (context) =>
                                                  GamePage(target: widget.target, max: widget.max,
                                                      widthL: widget.widthL, heightL: widget.heightL, widthP: widget.widthP, heightP: widget.heightP,
                                                      paddingLH: widget.paddingLH, paddingLV: widget.paddingLV, paddingPH: widget.paddingPH, paddingPV: widget.paddingPV, innerPadding: widget.innerPadding,))
                                          );
                                        })
                                  ],
                                );
                              }
                          );
                        }
                        else {
                          _puzzle[_current] = -1;
                          _puzzle[i] = -1;
                          _current = -1;
                        }
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
          )
      ));
    }

    bool isPMode = MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        title: Text("Mia，请找到两个数字，他们加在一起等于" + widget.target.toString()),
      ),
      body:
      Center(
        child: Padding(
            padding: EdgeInsets.only(left: isPMode ? widget.paddingPH : widget.paddingLH, right:  isPMode ? widget.paddingPH : widget.paddingLH, top: isPMode ? widget.paddingPV : widget.paddingLV, bottom: isPMode ? widget.paddingPV : widget.paddingLV),
            child: GridView.count(crossAxisCount: isPMode ? widget.widthP : widget.widthL, children: cells)
          ),
        ),
      // ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('nihisadfhffffffffffffffffffffffffffffffffffffffffffffffffsssssssssssssssssssss')
            ]
          //   Flexible(flex: 1,
          //     child: TextButton(
          //       child: Text('width($_width)--'),
          //       onPressed: () {
          //         setState(() {
          //           _width--;
          //         });
          //
          //       },
          //     ),
          //   ),
          //   Flexible(flex: 1,
          //     child: TextButton(
          //       child: Text('width($_width)++'),
          //       onPressed: () {
          //         setState(() {
          //           _width++;
          //         });
          //       },
          //     ),
          //   ),
          //   const Flexible(flex: 1, child: Text('                                                                                                                                    ')),
          //   Flexible(flex: 1,
          //     child: TextButton(
          //       child: Text('height($_height)--'),
          //       onPressed: () {
          //         setState(() {
          //           _height--;
          //         });
          //       },
          //     ),
          //   ),
          //   Flexible(flex: 1,
          //     child: TextButton(
          //       child: Text('height($_height)++'),
          //       onPressed: () {
          //         setState(() {
          //           _height++;
          //         });
          //       },
          //     ),
          //   ),
          // ]
          ,
        ),
      ),
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




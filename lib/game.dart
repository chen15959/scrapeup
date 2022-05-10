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

import 'package:flutter_beep/flutter_beep.dart';




class GamePage extends StatefulWidget {
  GamePage({required this.target, this.max = 2147483647,
    this.widthP = 4, this.heightP = 6, this.widthL = 8, this.heightL = 3, supe = false,
    this.paddingPH = 62.0, this.paddingPV = 32.0, this.paddingLH = 10.0, this.paddingLV = 55.0, this.innerPadding = 4.0,
    Key? key}) : super(key: key) {
    if (widthP * heightP != widthL * heightL) {
      throw "数据大小不匹配";
    }

    if (supe) {
      widthP = widthP * 2;
      heightP = heightP * 2;
      widthL = widthL * 2;
      heightL = heightL * 2;
    }
  }

  // 加法的目标值
  final int target;
  // 加数的最大值
  final int max;

  // 竖屏时矩阵宽度
  int widthP;
  // 竖屏时矩阵高度
  int heightP;

  // 横屏时矩阵宽度
  int widthL;
  // 横屏时矩阵高度
  int heightL;

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

  /// 得分
  ///
  int score = 0;

  /// 当前选中的格子
  ///
  int _current = -1;

  /// 计时器
  ///
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
      });
    });


    List<int> value = [];

    while (value.length < widget.heightL * widget.widthL) {
      int r = math.Random.secure().nextInt(widget.target - 1) + 1;
      if (r <= widget.max && widget.target - r <= widget.max) {
        value.add(r);
        value.add(widget.target - r);
      }
    }

    while (value.isNotEmpty) {
      _puzzle.add(value.removeAt(math.Random.secure().nextInt(value.length)));
    }
  }


  @override
  void dispose() {
    _timer!.cancel();

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
        Padding(
          padding: EdgeInsets.all(widget.innerPadding),
          child: _puzzle[i] < 0 ? null :
          TextButton(
            child:
            Container(
              width: double.infinity, height: double.infinity,
              color: _current == i ? Colors.lightBlueAccent : Colors.white,
              child:
              Center(
                child:
                FittedBox(
                  child:
                  Text(
                    _puzzle[i].toString(),
                    style:
                    const TextStyle(
                      fontSize: 9999,
                      color: Colors.black,
                    )
                  )
                )
              )
            ),
            onPressed: () {
              setState(() {
                if (_current >= 0) {
                  if (_current == i) {
                    _current = -1;
                    return;
                  }

                  if (_puzzle[i] + _puzzle[_current] == widget.target) {
                    FlutterBeep.beep();
                    score = score + 200;

                    if (left == 2) {
                      _timer!.cancel();
                      showDialog(context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('太棒啦！\n在' + _timer!.tick.toString() + '秒内全部做完！\n总得分为：$score分！', textScaleFactor: 4.0),
                            actions: [
                              TextButton(
                                child:
                                const Text(r'再来一局', textScaleFactor: 4.0),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) =>
                                      GamePage(target: widget.target, max: widget.max,
                                               widthL: widget.widthL, heightL: widget.heightL, widthP: widget.widthP, heightP: widget.heightP,
                                               paddingLH: widget.paddingLH, paddingLV: widget.paddingLV, paddingPH: widget.paddingPH, paddingPV: widget.paddingPV, innerPadding: widget.innerPadding,))
                                  );
                                }
                              )
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
                    FlutterBeep.beep(false);
                    score = score - 100;
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
      );
    }


    bool isPMode = MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        title: Text("Mia，请找到两个数字，他们加在一起等于" + widget.target.toString()),
      ),
      body:
          Container(width: double.infinity, height: double.infinity, color: Colors.grey, child:
            Center(
              child: Padding(
                  padding: EdgeInsets.only(left: isPMode ? widget.paddingPH : widget.paddingLH, right:  isPMode ? widget.paddingPH : widget.paddingLH, top: isPMode ? widget.paddingPV : widget.paddingLV, bottom: isPMode ? widget.paddingPV : widget.paddingLV),
                  child: GridView.count(crossAxisCount: isPMode ? widget.widthP : widget.widthL, children: cells)
              ),
            ),
          ),
      // ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('共有' + (_puzzle.length / 2).toString() + '组谜题。已完成' + ((_puzzle.length - left) / 2).toString() + '组', textScaleFactor: 2.0),
            Text('当前得分$score', style: TextStyle(color: score >= 0 ? Colors.black : Colors.red), textScaleFactor: 2.0),
            Text('用时' + _timer!.tick.toString() + '秒', textScaleFactor: 2.0)
            ]
        ),
      ),
    );
  }



}




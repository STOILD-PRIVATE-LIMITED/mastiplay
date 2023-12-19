import 'dart:math';

import 'package:flutter/material.dart';

class JackpotScreen extends StatefulWidget {
  JackpotScreen({
    super.key,
    required this.items,
    this.itemHeight = 24,
    this.slots = 5,
    this.rows = 3,
    this.duration = 5,
  });
  final int slots;
  final int rows;
  final List<Widget> items;
  final int duration;
  final double itemHeight;
  final random = Random();

  @override
  State<JackpotScreen> createState() => _JackpotScreenState();
}

class _JackpotScreenState extends State<JackpotScreen>
    with TickerProviderStateMixin {
  List<List<int>> itemIndices = [];
  List<int> indices = [];

  List<AnimationController> _controllers = [];
  List<ScrollController> _scrollControllers = [];
  List<Animation> _animations = [];

  List<int> oldIndices = [];

  @override
  void initState() {
    super.initState();
    int n = widget.items.length;
    itemIndices = List.generate(widget.slots, (index) => []);
    _scrollControllers =
        List.generate(widget.slots, (index) => ScrollController());
    // itemIndices[0] = List.generate(n, (index) => index);
    // itemIndices = List.generate(widget.slots, (index) => itemIndices[0]);
    // for (var element in itemIndices) {
    //   element.shuffle(Random(widget.random.nextInt(n)));
    // }
    List<int> randomIndices = List.generate(n, (index) => index);
    randomIndices.shuffle(Random());
    for (var i = 0; i < widget.slots; i++) {
      itemIndices[i] = List.from(randomIndices);
      itemIndices[i].shuffle(Random());
    }

    indices = List.generate(widget.slots, (index) => 0);
    oldIndices = List.generate(widget.slots, (index) => indices[index]);

    _controllers = List.generate(
      widget.slots,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(seconds: widget.duration),
      ),
    );

    _animations = List.generate(
      widget.slots,
      (index) => Tween<double>(
        begin: 0,
        end: widget.items.length.toDouble(),
      ).animate(
        CurvedAnimation(
          parent: _controllers[index],
          curve: Curves.easeInOut,
        ),
      ),
    );

    for (int i = 0; i < widget.slots; ++i) {
      _controllers[i].addListener(() {
        // indices[i] =
        //     ((_animations[i].value * 10) % widget.items.length).toInt();
        // if (oldIndices[i] != indices[i]) {
        _scrollControllers[i].animateTo(
            (_animations[i].value * 10).toInt() + _scrollControllers[i].offset,
            duration: const Duration(milliseconds: 1),
            curve: Curves.easeOut);
        oldIndices[i] = indices[i];
        // }
      });
    }
    for (int i = 0; i < widget.slots; ++i) {
      _controllers[i].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print(
              "_scrollControllers[i].offset = ${_scrollControllers[i].offset}");
          int endindex =
              ((_scrollControllers[i].offset ~/ widget.itemHeight) ~/ 3) * 3;
          print("endindex = $endindex");
          print(
              "endindex * widget.itemHeight = ${endindex * widget.itemHeight}");
          _scrollControllers[i].animateTo(
            endindex * (widget.itemHeight),
            duration: const Duration(milliseconds: 1),
            curve: Curves.decelerate,
          );
          indices[i] = endindex;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jackpot'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int index = 0; index < widget.slots; ++index)
                SizedBox(
                  height: widget.itemHeight * widget.rows,
                  width: 20,
                  child: ListView.builder(
                    controller: _scrollControllers[index],
                    itemBuilder: (context, i) {
                      return Container(
                        color: Color.fromRGBO(
                          widget.random.nextInt(255),
                          widget.random.nextInt(255),
                          widget.random.nextInt(255),
                          1,
                        ),
                        height: widget.itemHeight,
                        width: 30,
                        child: widget
                            .items[itemIndices[index][i % widget.items.length]],
                      );
                    },
                  ),
                )
              // Card(
              //   margin: const EdgeInsets.all(10),
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: widget.items[itemIndices[index][indices[index]]],
              //   ),
              // ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () async {
              for (int i = 0; i < widget.slots; ++i) {
                _animations[i] = Tween<double>(
                  begin: 0,
                  end: widget.items.length.toDouble(),
                ).animate(
                  CurvedAnimation(
                    parent: _controllers[i],
                    curve: Curves.easeInOut,
                  ),
                );
              }
              for (var element in _controllers) {
                element.reset();
              }
              for (var element in _controllers) {
                await Future.delayed(const Duration(milliseconds: 200));
                element.forward();
              }
            },
            icon: const Icon(Icons.rotate_left),
            label: const Text('Spin'),
          )
        ],
      ),
    );
  }
}

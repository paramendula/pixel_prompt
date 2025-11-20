import 'dart:async';

import 'package:pixel_prompt/core/size.dart';
import 'package:pixel_prompt/pixel_prompt.dart';
import 'package:pixel_prompt/terminal/terminal_functions.dart';

// This demo will be enhanced when Expanded, Center and BorderBox
// are added.

// Let's create a count box, which will count numbers for us
class CountBox extends StatefulComponent {
  final int countStart;
  final Size boxSize;
  final bool isBackwards;
  final EdgeInsets margin;
  final EdgeInsets pad;

  CountBox({
    required this.boxSize,
    this.countStart = 0,
    this.isBackwards = false,
    this.margin = const EdgeInsets.all(0),
    this.pad = const EdgeInsets.all(0),
  });

  @override
  ComponentState<CountBox> createState() =>
      _CountBoxState(countStart, boxSize, isBackwards, margin, pad);
}

// State is a must-have for such a component (number being counted is *the* state)
class _CountBoxState extends ComponentState<CountBox> {
  int count;
  final Size boxSize;
  final bool isBackwards;
  final EdgeInsets margin, padding;

  _CountBoxState(
    this.count,
    this.boxSize,
    this.isBackwards,
    this.margin,
    this.padding,
  );

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() {
        count += (isBackwards) ? -1 : 1;
      }),
    );
  }

  @override
  List<Component> build() {
    return [
      SizedBox(
        child: TextComponent(count.toString()),
        size: boxSize,
        margin: margin,
        padding: padding,
      ),
    ];
  }
}

void main() {
  // Won't resize on terminal resize, keep in mind.
  final Size halved = Size(
    width: TerminalFunctions.terminalWidth ~/ 2,
    height: TerminalFunctions.terminalHeight ~/ 2,
  );

  var box1 = CountBox(boxSize: halved);
  var box2 = SizedBox(
    child: TextComponent("I'm on the right side!"),
    size: halved,
  );
  var box3 = SizedBox(
    child: TextComponent("And I'm on the left side! (Padded)"),
    size: halved,
    padding: EdgeInsets.all(2),
  );
  var box4 = CountBox(boxSize: halved, countStart: 100, isBackwards: true);

  App(
    children: [
      Column(
        children: [
          Row(children: [box1, box2]),
          Row(children: [box3, box4]),
        ],
      ),
    ],
  ).run(fullScreenMode: true);
}

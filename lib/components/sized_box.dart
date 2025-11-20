import 'package:pixel_prompt/core/component_instance.dart';
import 'package:pixel_prompt/core/size.dart';
import 'package:pixel_prompt/pixel_prompt.dart';

class SizedBox extends Component {
  final Component child;

  final Size size;
  final EdgeInsets margin;

  const SizedBox({
    required this.child,
    required this.size,
    this.margin = const EdgeInsets.all(0),
    super.padding,
  });

  @override
  ComponentInstance createInstance() =>
      _SizedBoxInstance(child, size, padding: padding, margin: margin);
}

class _SizedBoxInstance extends ComponentInstance {
  final ComponentInstance _childInstance;

  final Size size;
  final EdgeInsets margin;

  _SizedBoxInstance(
    Component child,
    this.size, {
    super.padding,
    this.margin = const EdgeInsets.all(0),
  }) : _childInstance = child.createInstance();

  @override
  Size measure(Size maxSize) {
    return Size(
      width: size.width + margin.horizontal,
      height: size.height + margin.vertical,
    );
  }

  @override
  int fitHeight() => size.height + margin.vertical;

  @override
  int fitWidth() => size.width + margin.horizontal;

  @override
  void render(CanvasBuffer buffer, Rect bounds) {
    _childInstance.render(
      buffer,
      Rect(
        x: bounds.x + padding.left,
        y: bounds.y + padding.top,
        width: bounds.width - padding.right,
        height: bounds.bottom - padding.bottom,
      ),
    );
  }
}

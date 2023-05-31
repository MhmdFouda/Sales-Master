import 'package:fluent_ui/fluent_ui.dart';

extension IconSizeExtension on IconData {
  Widget size(double size) {
    return Icon(this, size: size);
  }
}

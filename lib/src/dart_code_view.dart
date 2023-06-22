import 'package:dart_style/dart_style.dart';
import 'package:flutter/widgets.dart';
import 'package:webviewx/webviewx.dart';

class DartCodeView extends StatefulWidget {
  final double height;
  final double width;
  final String code;
  final bool runFormatter;
  const DartCodeView({
    super.key,
    required this.height,
    required this.width,
    required this.code,
    this.runFormatter = false,
  });

  @override
  State<DartCodeView> createState() => _DartCodeViewState();
}

class _DartCodeViewState extends State<DartCodeView> {
  String? code;

  @override
  void initState() {
    if (widget.runFormatter) {
      code = DartFormatter().format(widget.code);
    } else {
      code = widget.code;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewX(
      height: widget.height,
      width: widget.width,
      onWebViewCreated: (controller) {
        controller.loadContent(
          'packages/dart_code_view/assets/code_viewer.html',
          SourceType.html,
          fromAssets: true,
        );

        Future.delayed(const Duration(seconds: 1), () {
          controller.callJsMethod('updateCodeContent', [code]);
        });
      },
    );
  }
}

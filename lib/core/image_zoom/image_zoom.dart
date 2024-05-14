import 'package:flutter/material.dart';

mixin ImageZoomMixin {
  Future<T?> imageZoom<T>(BuildContext context, String url) {
    return showDialog(
      context: context,
      builder: (context) {
        return ImageZoom(url: url);
      },
    );
  }
}

class ImageZoom extends StatelessWidget {
  const ImageZoom({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
          height: _WidgetSizes().sizedBoxHeight,
          child: InteractiveViewer(
            child: Image.network(
              url,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * _WidgetSizes().imageNetworkHeight,
            ),
          )),
    );
  }
}

class _WidgetSizes {
  final double sizedBoxHeight = 400.0;
  final double imageNetworkHeight = 0.6;
}

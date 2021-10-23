import 'package:flutter/material.dart';

class LoadingIndicatorCustom extends StatelessWidget {
  const LoadingIndicatorCustom({Key? key, required this.loading})
      : super(key: key);
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Center(child: CircularProgressIndicator())])
        : Container();
  }
}

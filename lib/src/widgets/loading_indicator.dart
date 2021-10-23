import 'package:flutter/material.dart';

class LoadingIndicatorCustom extends StatelessWidget {
  const LoadingIndicatorCustom({Key? key, required this.loading})
      : super(key: key);
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: CircularProgressIndicator())]),
          )
        : Container();
  }
}

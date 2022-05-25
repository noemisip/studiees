
import 'package:flutter/cupertino.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: CupertinoActivityIndicator(),
        ));
  }
}
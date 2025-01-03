import 'package:flutter/material.dart';

class PrefText<T> extends StatelessWidget {
  final Future<T> future;
  final Widget? onError;
  final Widget Function(T? value) child;
  const PrefText({
    super.key,
    required this.future,
    this.onError,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: Stream<T>.fromFuture(future),
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          // Handle error or null data
          return onError ?? const SizedBox.shrink();
        } else {
          // Return the child widget with the data
          return child(snapshot.data as T);
        }
      },
    );
  }
}

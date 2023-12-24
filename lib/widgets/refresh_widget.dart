import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshWidget extends StatelessWidget {
  const RefreshWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const SizedBox();
        } else if (mode == LoadStatus.loading) {
          body = const CircularProgressIndicator();
        } else if (mode == LoadStatus.failed) {
          body = const Text(
            "Load Failed! Scroll Up to retry!",
            style: TextStyle(color: Colors.black),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = const Text(
            "Release to load more",
            style: TextStyle(color: Colors.black),
          );
        } else {
          body = const Text(
            "",
            style: TextStyle(color: Colors.black),
          );
        }
        return Container(
          margin: const EdgeInsets.only(top: 25, bottom: 40),
          height: 35.0,
          child: Center(child: body),
        );
      },
    );
  }
}

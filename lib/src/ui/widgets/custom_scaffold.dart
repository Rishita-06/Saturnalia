import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Saturnalia/src/constants/colors.dart';

class CustomScaffold extends ConsumerStatefulWidget {
  final Widget? body;
  final Color color;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomBar;

  const CustomScaffold({
    super.key,
    this.body,
    this.appBar,
    this.bottomBar,
    this.color = scaffoldColor,
    this.floatingActionButton,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends ConsumerState<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: widget.appBar,
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       'assets/images/home_background.png',
        //     ),
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: widget.body ?? const SizedBox(),
      ),
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar: widget.bottomBar,
    );
  }
}

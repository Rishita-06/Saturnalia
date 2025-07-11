import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageBanners extends StatefulWidget {
  final List<String> imageList;
  final bool isFeatured;
  final VoidCallback onTap;

  const ImageBanners({
    required this.onTap,
    required this.imageList,
    this.isFeatured = false,
    super.key,
  });

  @override
  State<ImageBanners> createState() => _ImageBannersState();
}

class _ImageBannersState extends State<ImageBanners> {
  int index = 1;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = _setTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 570,
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        children: [
          ...widget.imageList
              .map((e) => _CarouselImageItem(
                    isActive: widget.imageList
                            .indexWhere((element) => element == e) ==
                        (index - 1),
                    imagePath: e,
                  ))
              .toList(),
          if (widget.isFeatured)
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                radius: 0.7,
                colors: [
                  Colors.white.withOpacity(0.65),
                  Colors.white.withOpacity(0.1),
                ],
              )),
            ),
        ],
      ),
    );
  }

  Timer _setTimer() {
    return Timer.periodic(const Duration(milliseconds: 4003), (Timer t) {
      if (index == widget.imageList.length) {
        setState(() {
          index = 1;
        });
        return;
      }
      setState(() {
        index++;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }
}

class _CarouselImageItem extends StatelessWidget {
  const _CarouselImageItem({
    required this.imagePath,
    required this.isActive,
    Key? key,
  }) : super(key: key);

  final String imagePath;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: isActive ? 1 : 0,
          child: Container(
            color: Colors.black,
            child: CachedNetworkImage(
              imageUrl: imagePath,
              height: 570,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.2),
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
      ],
    );
  }
}

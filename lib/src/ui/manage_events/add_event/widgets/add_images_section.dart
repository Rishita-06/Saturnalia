import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Saturnalia/src/utils/toast_utils.dart';

import '../add_event_model.dart';

class AddImagesSection extends ConsumerStatefulWidget {
  const AddImagesSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddImagesSectionState();
}

class _AddImagesSectionState extends ConsumerState<AddImagesSection> {
  bool isProcessing = false;
  bool isProcessing2 = false;
  @override
  Widget build(BuildContext context) {
    final bannerUrl = ref.watch(
      addEventModelProvider.select((_) => _.bannerImageUrl),
    );
    ref.listen(addEventModelProvider, (prev, next) {
      if (prev?.bannerImageUrl != next.bannerImageUrl) {
        if (next.bannerImageUrl.trim().isNotEmpty) {
          setState(() {
            isProcessing = false;
          });
        }
      }
    });
    final imageList = ref.watch(
      addEventModelProvider.select((_) => _.eventImages),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Banner Image',
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (bannerUrl.trim().isNotEmpty) ...[
          Stack(
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff181818),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: bannerUrl,
                          height: 110,
                          width: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    if (!isProcessing || !isProcessing2) {
                      ref
                          .read(addEventModelProvider.notifier)
                          .setBannerUrl('', 'banner');
                    }
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ] else ...[
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              if (!isProcessing) {
                setState(() {
                  isProcessing = true;
                });
                final res = await ref
                    .read(addEventModelProvider.notifier)
                    .pickFile('banner');
                if (res != '') {
                  showErrorMessage(context, res);
                  setState(() {
                    isProcessing = false;
                  });
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff181818),
                borderRadius: BorderRadius.circular(15),
              ),
              height: 120,
              width: 120,
              child: isProcessing
                  ? Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white.withOpacity(0.6),
                        size: 40,
                      ),
                    ),
            ),
          )
        ],
        const SizedBox(
          height: 20,
        ),
        Text(
          'Add Display Images',
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: imageList.length + 1,
              itemBuilder: (context, index) => index == 0
                  ? GestureDetector(
                      onTap: () async {
                        if (!isProcessing2) {
                          setState(() {
                            isProcessing2 = true;
                          });
                          final res = await ref
                              .read(addEventModelProvider.notifier)
                              .pickFile('display');
                          if (res != '') {
                            showErrorMessage(context, res);
                            setState(() {
                              isProcessing2 = false;
                            });
                          } else {
                            setState(() {
                              isProcessing2 = false;
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff181818),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 120,
                        width: 120,
                        child: isProcessing2
                            ? Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              )
                            : Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white.withOpacity(0.6),
                                  size: 40,
                                ),
                              ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 130,
                            height: 130,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff181818),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: imageList[index - 1],
                                      height: 110,
                                      width: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                ref
                                    .read(addEventModelProvider.notifier)
                                    .removeImage(imageList[index - 1]);
                              },
                              child: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            )),
        const SizedBox(height: 10),
      ],
    );
  }
}

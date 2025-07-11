import 'dart:io';

import 'package:flutter/services.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert' as convert;

import 'package:crypto/crypto.dart';

import '../models/reward_points_data.dart';

Future<XFile?> assetToXFile(String assetPath) async {
  final ByteData assetByteData = await rootBundle.load(assetPath);
  final List<int> assetBytes = assetByteData.buffer.asUint8List();
  final String tempFileName =
      "${DateTime.now().millisecondsSinceEpoch}.png"; // You can choose a different file format based on your
  final String tempFilePath =
      '${(await getTemporaryDirectory()).path}/$tempFileName';

  await File(tempFilePath).writeAsBytes(assetBytes);
  final XFile xFile = XFile(tempFilePath);

  return xFile;
}

Future<File> getAvatarFile(String userId, String userName) async {
  final avatarSvgString = multiavatar(
    userId.toLowerCase() + userName.toLowerCase(),
    trBackground: true,
  );

  final imageFile =
      await File('${(await getTemporaryDirectory()).path}/$userId$userName.svg')
          .writeAsString(avatarSvgString);
  return imageFile;
}

int getTotalCoins(List<RewardPointsData> data) {
  if (data.isEmpty) {
    return 0;
  }
  int coins = 0;
  for (RewardPointsData reward in data) {
    if (reward.isAwarded == 0) {
    } else if (reward.isAwarded == 1) {
      coins += reward.coins;
    } else {
      coins -= reward.coins;
    }
  }
  return coins;
}

String generateReferralCode(String userId, bool isReferral) {
  final bytes = convert.utf8.encode(userId);
  final hash = sha256.convert(bytes);
  return isReferral
      ? hash.toString().substring(0, 6)
      : hash.toString().substring(0, 8);
}

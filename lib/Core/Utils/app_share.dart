import 'package:share_plus/share_plus.dart';

class AppShare {
  Future<bool> shareText({String? title, required String text}) async {
    var res = await SharePlus.instance.share(
      ShareParams(text: text, title: title),
    );

    return res.status == ShareResultStatus.success ||
        res.status == ShareResultStatus.dismissed;
  }

  Future<bool> shareFiles({required List<XFile> files}) async {
    var res = await SharePlus.instance.share(
      ShareParams(files: files, previewThumbnail: files.first),
    );

    return res.status == ShareResultStatus.success ||
        res.status == ShareResultStatus.dismissed;
  }
}

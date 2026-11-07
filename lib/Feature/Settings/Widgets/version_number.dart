import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VersionNumber extends StatefulWidget {
  const VersionNumber({super.key});

  @override
  State<VersionNumber> createState() => _VersionNumberState();
}

class _VersionNumberState extends State<VersionNumber> {
  late final Future<PackageInfo> future;

  @override
  void initState() {
    future = PackageInfo.fromPlatform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<PackageInfo>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Skeletonizer(
              enabled: true,
              child: Text(
                AppLocalization.of(context).versionLoading,
                style: AppText().caption(context),
              ),
            );
          } else if (snapshot.hasData) {
            return Text(
              AppLocalization.of(context).version(snapshot.data!.version),
              style: AppText().caption(context),
            );
          } else {
            return Text(
              AppLocalization.of(context).version('1.0.0'),
              style: AppText().caption(context),
            );
          }
        },
      ),
    );
  }
}

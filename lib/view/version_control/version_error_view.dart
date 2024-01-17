import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/constants/image_constants.dart';
import 'package:flutter_base_riverpod/_library/helpers/translation/locale_keys.g.dart';
import 'package:flutter_base_riverpod/_library/widgets/space_sized_height_box.dart';
import 'package:flutter_base_riverpod/controller/version_controller.dart';

class VersionErrorView extends StatelessWidget {
  const VersionErrorView({Key? key, required this.data}) : super(key: key);
  final VersionControlModel? data;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SpaceSizedHeightBox(height: 0.15),
                  Image.asset(ImageConstants.maintenance),
                  const SpaceSizedHeightBox(height: 0.015),
                  Text(
                    LocaleKeys.general_maintenanceHeadline.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SpaceSizedHeightBox(height: 0.015),
                  Text(
                    data?.message ?? LocaleKeys.error_notFoundPage.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SpaceSizedHeightBox(height: 0.015),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Utils/app_theme.dart';
import 'package:resto_qr/Core/Utils/navigation.dart';
import 'package:resto_qr/Core/Widgets/universal_image.dart';
import 'package:resto_qr/Feature/Website/Models/component_model.dart';
import 'package:resto_qr/Feature/Website/View%20Model/website_cubit.dart';

class ComponentCard extends StatelessWidget {
  const ComponentCard({super.key, required this.component});

  final ComponentModel component;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        var bloc = context.read<WebsiteCubit>();
        Navigation().push(
          context,
          BlocProvider.value(value: bloc, child: component.preview),
        );
      },
      tileColor: AppTheme().fillColor(context),
      contentPadding: const .symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppTheme().borderColor(context),
          width: 2,
        ),
      ),
      leading: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppConstants().neonBlue.withValues(alpha: 0.15),
          borderRadius: .circular(12),
        ),
        child: UniversalImage(
          source: component.image,
          color: component.color,
        ),
      ),
      title: Text(
        component.name,
        style: AppText().semiBold16(context),
      ),
      subtitle: Text(
        component.description,
        style: AppText().caption(context),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppConstants().neonBlue,
      ),
    );
  }
}

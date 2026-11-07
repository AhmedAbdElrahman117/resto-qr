import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resto_qr/Core/Services/pick_image.dart';
import 'package:resto_qr/Core/Utils/app_constants.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';
import 'package:resto_qr/Core/Utils/app_text.dart';
import 'package:resto_qr/Core/Widgets/custom_icon.dart';
import 'package:resto_qr/Core/Widgets/universal_image.dart';

class PickImageButton extends StatefulWidget {
  const PickImageButton({
    super.key,
    this.onImageSelected,
    this.onMultiImageSelected,
    required this.title,
    this.isMultiImage = false,
    this.initialValue,
  });

  final void Function(String imagePath)? onImageSelected;
  final void Function(List<String> imagePaths)? onMultiImageSelected;
  final String title;
  final bool isMultiImage;
  final List<String>? initialValue;

  @override
  State<PickImageButton> createState() => _PickImageButtonState();
}

class _PickImageButtonState extends State<PickImageButton> {
  bool ignore = false;
  List<XFile> images = [];

  @override
  void initState() {
    super.initState();
    _initializeImages();
  }

  // --- State & Logic Handlers ---

  void _initializeImages() {
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      if (widget.isMultiImage) {
        images = widget.initialValue!.map((path) => XFile(path)).toList();
      } else {
        images = [XFile(widget.initialValue!.first)];
      }
    }
  }

  void _removeImage(int index, FormFieldState<List<XFile>> field) {
    setState(() {
      images.removeAt(index);
    });

    field.didChange(images);
    field.validate();

    if (widget.isMultiImage) {
      if (images.isNotEmpty) {
        widget.onMultiImageSelected?.call(images.map((e) => e.path).toList());
      }
    } else {
      if (images.isNotEmpty) {
        widget.onImageSelected?.call(images.first.path);
      }
    }
  }

  Future<void> _handleImageSelection(FormFieldState<List<XFile>> field) async {
    setState(() => ignore = true);

    if (widget.isMultiImage) {
      await _pickMultipleImages(field);
    } else {
      await _pickSingleImage(field);
    }

    setState(() => ignore = false);
  }

  Future<void> _pickMultipleImages(FormFieldState<List<XFile>> field) async {
    var pickedImages = await PickImage().pickMultipleImages();

    if (pickedImages != null && pickedImages.isNotEmpty) {
      List<XFile> validImages = [];
      for (var img in pickedImages) {
        if (!(await isImageLargerThan5MB(img))) {
          validImages.add(img);
        }
      }

      field.setState(() {
        images.addAll(validImages);
        field.didChange(images);
        field.validate();
      });

      widget.onMultiImageSelected?.call(images.map((e) => e.path).toList());
    }
  }

  Future<void> _pickSingleImage(FormFieldState<List<XFile>> field) async {
    var pickedImage = await PickImage().pickSingleImage();

    if (pickedImage != null) {
      if (!(await isImageLargerThan5MB(pickedImage))) {
        field.setState(() {
          images = [pickedImage];
          field.didChange(images);
          field.validate();
        });

        widget.onImageSelected?.call(images.first.path);
      } else {
        field.setState(() {
          images = [XFile('No Length')];
          field.didChange(images);
          field.validate();
        });
      }
    }
  }

  Future<bool> isImageLargerThan5MB(XFile file) async {
    if (file.path.startsWith('http')) return false;

    try {
      const int maxSizeBytes = 5242880;
      final int imageSize = await file.length();
      return imageSize > maxSizeBytes;
    } catch (e) {
      return false;
    }
  }

  String? _validateField(List<XFile>? value) {
    final l10n = AppLocalization.of(context);
    if (images.isEmpty) {
      return widget.isMultiImage ? l10n.imagesRequired : l10n.logoRequired;
    } else if (!widget.isMultiImage && images.first.path == 'No Length') {
      return l10n.imageMustBeLessThanFiveMb;
    }
    return null;
  }

  // --- UI Builders ---

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ignore,
      child: FormField<List<XFile>>(
        initialValue: images,
        validator: _validateField,
        builder: (field) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _handleImageSelection(field),
              child: _buildMainContainer(field),
            ),
            if (field.hasError) _buildErrorText(field.errorText!),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContainer(FormFieldState<List<XFile>> field) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: field.hasError
              ? AppConstants().errorRed
              : const Color(0xFF475569),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImagePreview(field),
          const SizedBox(height: 20),
          Text(
            widget.title,
            style: AppText().bold20(context),
          ),
          const SizedBox(height: 6),
          Text(
            AppLocalization.of(context).supportedImageFormats,
            style: AppText().caption(context),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorText(String errorText) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        errorText,
        style: AppText().regular14(context, AppConstants().errorRed),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildImagePreview(FormFieldState<List<XFile>> field) {
    if (images.isEmpty) {
      return CustomIcon(
        icon: widget.isMultiImage ? Icons.photo_library : Icons.camera_alt,
      );
    }

    return widget.isMultiImage
        ? _buildMultiImagePreview(field)
        : _buildSingleImagePreview(field);
  }

  Widget _buildMultiImagePreview(FormFieldState<List<XFile>> field) {
    const int maxDisplay = 5;
    final bool showPlus = images.length > maxDisplay;
    final int displayCount = showPlus ? maxDisplay : images.length;
    final int remainingCount = images.length - maxDisplay;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < displayCount; i++) _buildStackedAvatar(i, field),
          if (showPlus) _buildRemainingCountBubble(remainingCount),
        ],
      ),
    );
  }

  Widget _buildStackedAvatar(int index, FormFieldState<List<XFile>> field) {
    return Align(
      widthFactor: 0.7,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: UniversalImage(
                source: images[index].path,
                height: 80,
                width: 80,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: _buildDeleteBadge(() => _removeImage(index, field)),
          ),
        ],
      ),
    );
  }

  Widget _buildRemainingCountBubble(int remainingCount) {
    return Align(
      widthFactor: 0.5,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: const Color(0xFF334155),
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            '+$remainingCount',
            style: AppText().bold20(context).copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSingleImagePreview(FormFieldState<List<XFile>> field) {
    if (images.first.path == 'No Length') {
      return const CustomIcon(icon: Icons.camera_alt);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: UniversalImage(
            source: images.first.path,
            height: 120,
            width: 120,
          ),
        ),
        Positioned(
          top: -8,
          right: -8,
          child: _buildDeleteBadge(() => _removeImage(0, field)),
        ),
      ],
    );
  }

  Widget _buildDeleteBadge(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.close, color: Colors.white, size: 16),
      ),
    );
  }
}

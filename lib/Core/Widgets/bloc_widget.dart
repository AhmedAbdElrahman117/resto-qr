import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_qr/Core/Base%20State/base_state.dart';
import 'package:resto_qr/Core/Widgets/sliver_sized_box.dart';

class BlocWidget<C extends Cubit<S>, S> extends StatelessWidget {
  final Widget Function(BuildContext context, DataLoaded state)? childBuilder;

  final bool Function(S prev, S curr)? buildWhen;

  final Widget Function(BuildContext context, DataError state)? errorBuilder;

  final Widget Function(BuildContext context, DataLoading state)?
  loadingBuilder;

  final Widget Function(BuildContext context, DataEmpty state)? emptyBuilder;

  final Widget Function(BuildContext context, S state)? builder;

  final void Function(BuildContext context, S state)? listener;

  final bool isSliver;

  const BlocWidget({
    super.key,
    this.childBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.emptyBuilder,
    this.listener,
    this.buildWhen,
    this.isSliver = false,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<C, S>(
      listener: listener ?? (context, state) {},
      buildWhen: buildWhen,
      builder: (context, state) {
        if (state is DataError && errorBuilder != null) {
          return errorBuilder!(context, state as DataError);
        } else if (state is DataLoading && loadingBuilder != null) {
          return loadingBuilder!(context, state);
        } else if (state is DataEmpty && emptyBuilder != null) {
          return emptyBuilder!(context, state);
        } else if (state is DataLoaded && childBuilder != null) {
          return childBuilder!(context, state);
        } else if (errorBuilder == null &&
            loadingBuilder == null &&
            emptyBuilder == null &&
            childBuilder == null) {
          return builder!(context, state);
        }
        return isSliver ? const SliverSizedBox() : const SizedBox();
      },
    );
  }
}

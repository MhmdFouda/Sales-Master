import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/resources/extension.dart';

enum WidgetType {
  product,
  client,
  order,
}

class CustomInfoleWidget extends ConsumerWidget {
  final String objectName;
  final int? count;
  final String? date;
  final String? phoneNumber;
  final String? total;
  final VoidCallback onPressed;
  final WidgetType widgetType;
  final int colorIndex;
  const CustomInfoleWidget({
    super.key,
    this.date,
    this.phoneNumber,
    this.total,
    required this.objectName,
    this.count,
    required this.onPressed,
    required this.widgetType,
    required this.colorIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeDataProvider.notifier).getColor(context, colorIndex)!;
    return Material(
      elevation: 5.0, // Adjust the elevation value as needed
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16.0),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: onPressed,
          hoverColor: Colors.grey.withOpacity(0.4),
          splashColor: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final minWidth = constraints.maxWidth * 0.3;
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: switch (widgetType) {
                  WidgetType.product => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            objectName,
                            style: fluent.FluentTheme.of(context)
                                .typography
                                .title
                                ?.copyWith(
                                    fontSize:
                                        getResponsiveFontSize(context, 16)),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).wrapWithArabicDirectionality(context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomBadgeWidget(
                                count: count.toString(),
                                color: color,
                                size: minWidth,
                                type: WidgetType.product,
                              ),
                            ],
                          ),
                        ]),
                  WidgetType.client => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            size: getResponsiveFontSize(context, 60),
                            color: fluent.FluentTheme.of(context)
                                .typography
                                .body
                                ?.color,
                          ).expand(),
                          Text(
                            objectName,
                            style: fluent.FluentTheme.of(context)
                                .typography
                                .title
                                ?.copyWith(
                                    fontSize:
                                        getResponsiveFontSize(context, 18)),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).wrapWithArabicDirectionality(context),
                        ]),
                  WidgetType.order => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              objectName,
                              style: fluent.FluentTheme.of(context)
                                  .typography
                                  .title
                                  ?.copyWith(
                                      fontSize:
                                          getResponsiveFontSize(context, 20)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ).wrapWithArabicDirectionality(context),
                            const SizedBox(height: 12),
                            Text(
                              date!,
                              style: fluent.FluentTheme.of(context)
                                  .typography
                                  .body
                                  ?.copyWith(
                                      fontSize:
                                          getResponsiveFontSize(context, 16)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ).wrapWithArabicDirectionality(context),
                          ],
                        ),
                        CustomBadgeWidget(
                          count: total ?? "0",
                          color: color,
                          size: minWidth / 3,
                          type: WidgetType.order,
                        ),
                      ],
                    ),
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomBadgeWidget extends StatelessWidget {
  final String count;
  final Color color;
  final double size;
  final WidgetType type;
  const CustomBadgeWidget({
    Key? key,
    required this.count,
    required this.color,
    required this.size,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getHight(WidgetType type) {
      switch (type) {
        case WidgetType.product:
          return size + 5;
        case WidgetType.client:
          return size * 0.6;
        case WidgetType.order:
          return size * 0.6;
      }
    }

    double getWidth(WidgetType type) {
      switch (type) {
        case WidgetType.product:
          return size + 5;
        case WidgetType.client:
          return size * 2;
        case WidgetType.order:
          return size * 0.8;
      }
    }

    final bool isSircle = type == WidgetType.product;
    final shape = isSircle ? BoxShape.circle : BoxShape.rectangle;
    return Material(
      elevation: 3.0, // Adjust the elevation value as needed
      color: Colors.transparent,
      shape: isSircle
          ? const CircleBorder()
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        width: getWidth(type),
        height: getHight(type),
        decoration: BoxDecoration(
            color: color.generateShade(context),
            shape: shape,
            borderRadius:
                !isSircle ? const BorderRadius.all(Radius.circular(16)) : null),
        child: Center(
          child: CountTextStyle(count: count),
        ),
      ),
    );
  }
}

class CountTextStyle extends ConsumerWidget {
  const CountTextStyle({
    super.key,
    required this.count,
  });

  final String count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      count,
      style: fluent.FluentTheme.of(context)
          .typography
          .bodyStrong
          ?.copyWith(fontSize: getResponsiveFontSize(context, 14)),
      textAlign: TextAlign.start,
    );
  }
}

double getResponsiveFontSize(BuildContext context, double fontSize) {
  final screenWidth = MediaQuery.sizeOf(context).width;
  final width = Platform.isWindows ? 1000 : 600;
  final responsiveFontSize = fontSize * (screenWidth / width);
  return responsiveFontSize - 2;
}

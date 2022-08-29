import 'package:flutter/material.dart';

/// StatsCard
class StatsCard extends StatelessWidget {
  /// Provides information about a stat.
  ///
  /// It has preconfigured styles and tap handlers.
  const StatsCard(
    this.iconData, {
    Key? key,
    required this.title,
    required this.stat,
    this.onTap,
  }) : super(key: key);

  /// Icon to be displayed
  final IconData iconData;

  /// Label of the stat displayed
  final String title;

  /// Value of the stat displayed
  final String stat;

  /// On tap handler for the card
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.15) ??
            Colors.black12;

    return InkWell(
      splashColor: color,
      onTap: onTap,
      child: ColoredBox(
        color: color,
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 14,
                  left: 14,
                  right: 8,
                ),
                child: Icon(
                  iconData,
                  size: 18,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  stat,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.16,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

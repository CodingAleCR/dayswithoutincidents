import 'package:dwi/core/resources/resources.dart';
import 'package:flutter/material.dart';

/// [ListEmptyState]
class ListEmptyState extends StatelessWidget {
  /// Displays an empty state view for adding a new counter easily when
  /// there's no counters in storage.
  const ListEmptyState({
    required this.subtitle,
    required this.title,
    super.key,
    this.action,
  });

  /// Title to be displayed
  final String title;

  /// Subtitle to be displayed
  final String subtitle;

  /// Action displayed if there's any.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (action != null) ...[
            const Spacer(),
          ],
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Resources.asset(context, 'empty_counters'),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[
            const Spacer(),
            action!,
          ],
        ],
      ),
    );
  }
}

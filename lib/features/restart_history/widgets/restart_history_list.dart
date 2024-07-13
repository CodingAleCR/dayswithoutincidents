import 'package:domain/domain.dart';
import 'package:dwi/features/restart_history/widgets/restart_history_item.dart';
import 'package:flutter/material.dart';

/// RestartHistoryList
class RestartHistoryList extends StatelessWidget {
  /// Displays a list of restarts as tiles inside a [ListView]
  const RestartHistoryList({
    required this.restarts,
    super.key,
  });

  /// List of restarts to be used
  final List<CounterRestart> restarts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Divider(),
      ),
      itemBuilder: (context, index) => RestartHistoryItem(
        restart: restarts[index],
      ),
      itemCount: restarts.length,
    );
  }
}

import 'dart:async';

import 'package:dwi/core/extensions/date.extensions.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:dwi/core/utils/date_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef OnSubmitCallback = FutureOr<void> Function(
  String title,
  DateTime lastRestart,
);

class CounterForm extends StatefulWidget {
  const CounterForm({
    required this.title,
    required this.lastRestart,
    this.onSubmit,
    super.key,
  });

  /// Counter title
  final String title;

  /// Counter's last restart
  final DateTime lastRestart;

  /// Callback when the information should be submitted.
  final OnSubmitCallback? onSubmit;

  @override
  State<CounterForm> createState() => _CounterFormState();
}

class _CounterFormState extends State<CounterForm> {
  late TextEditingController _titleController;
  late TextEditingController _lastRestartController;
  late DateTime _currentLastRestart;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _lastRestartController =
        TextEditingController(text: widget.lastRestart.toLocalizedString());
    _currentLastRestart = widget.lastRestart;
  }

  @override
  void didUpdateWidget(covariant CounterForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentLastRestart = widget.lastRestart;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).counterFormTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Text(
                    S.of(context).counterFormSubtitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                tooltip: MaterialLocalizations.of(context).closeButtonLabel,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              Text(
                S.of(context).counterFormNameField,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _titleController,
                decoration:  InputDecoration(
                  hintText: S.of(context).counterFormNameFieldHint,
                ),
                onTapOutside: (event) {
                  final currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).counterFormLastRestartField,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _lastRestartController,
                onTap: () async {
                  final updatedRestart = await showDateTimePicker(
                    context,
                    initialDate: DateTime.now(),
                    currentDate: widget.lastRestart,
                  );
                  
                  if (updatedRestart != null) {
                    setState(() {
                      _lastRestartController.text =
                          updatedRestart.toLocalizedString();
                      _currentLastRestart = updatedRestart;
                    });
                  }
                },
                showCursor: false,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.calendar_today_outlined,
                  ),
                  hintText: DateTime.now().toLocalizedString(),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 24),
          color: Theme.of(context).extension<BrandedTheme>()?.textColor,
          child: TextButton(
            onPressed: () {
              widget.onSubmit?.call(
                _titleController.text,
                _currentLastRestart,
              );
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor:
                  Theme.of(context).extension<BrandedTheme>()?.primaryColor,
            ),
            child: Text(S.of(context).counterFormSubmitBtn),
          ),
        ),
      ],
    );
  }
}

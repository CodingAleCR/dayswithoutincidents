import 'package:dwi/core/app_localizations.dart';
import 'package:flutter/material.dart';

class DefaultCounter extends StatefulWidget {
  final int days;
  final String title;
  final VoidCallback onReset;

  const DefaultCounter(
      {Key key,
      @required this.days,
      @required this.title,
      @required this.onReset})
      : super(key: key);

  @override
  _DefaultCounterState createState() => _DefaultCounterState();
}

class _DefaultCounterState extends State<DefaultCounter> {
  @override
  Widget build(BuildContext context) {
    String dayString = widget.days != 1
        ? AppLocalizations.of(context).translate(AppStrings.DAYS)
        : AppLocalizations.of(context).translate(AppStrings.DAY);
    String widgetString = "${widget.days} $dayString.";

    return Stack(
      children: <Widget>[
        Positioned(
          top: 16,
          bottom: 16,
          left: 16,
          right: 16,
          child: Center(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Container(
                    height: 32,
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widgetString,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.display3,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      textColor: Theme.of(context).errorColor,
                      child: Text(
                        AppLocalizations.of(context)
                            .translate(AppStrings.BTN_RESET),
                      ),
                      onPressed: () {
                        widget.onReset();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

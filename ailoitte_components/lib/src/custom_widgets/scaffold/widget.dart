import 'package:flutter/material.dart';

const EdgeInsets defaultBodyPadding = EdgeInsets.symmetric(
  horizontal: 20,
  vertical: 20,
);

class AiloitteScaffoldWidget extends StatelessWidget {
  final bool useSafeArea;
  final Function? onWillPop;
  final PreferredSizeWidget? appBar;
  final Widget? child;
  final Widget? drawer;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final EdgeInsets? bodyPadding;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool extendBody;
  final bool extendBodyBehindAppBar;


  const AiloitteScaffoldWidget({
    this.useSafeArea = true,
    this.onWillPop,
    this.appBar,
    this.child,
    this.drawer,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.bodyPadding,
    this.floatingActionButtonLocation,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (onWillPop != null) {
           onWillPop?.call();
        }
        return onWillPop == null;
      },
      child: useSafeArea
          ? SafeArea(
              top: useSafeArea,
              child: Scaffold(
                extendBodyBehindAppBar: extendBodyBehindAppBar,
                backgroundColor: backgroundColor,
                appBar: appBar,
                body: Padding(
                  padding: bodyPadding ?? defaultBodyPadding,
                  child: child,
                ),
                drawer: drawer,
                bottomSheet: bottomSheet,
                bottomNavigationBar: bottomNavigationBar,
                floatingActionButton: floatingActionButton,
                floatingActionButtonLocation: floatingActionButtonLocation,
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                extendBody: extendBody,

              ),
            )
          : Scaffold(
              backgroundColor: backgroundColor,
              extendBodyBehindAppBar: extendBodyBehindAppBar,
              appBar: appBar,
              body: Padding(
                padding: bodyPadding ?? defaultBodyPadding,
                child: child,
              ),
              drawer: drawer,
              bottomSheet: bottomSheet,
              bottomNavigationBar: bottomNavigationBar,
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation: floatingActionButtonLocation,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              extendBody: extendBody,
            ),
    );
  }
}

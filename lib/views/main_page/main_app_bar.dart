import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

const double _KLeadingWidth = kToolbarHeight;

class _ToolbarContainerLayout extends SingleChildLayoutDelegate {
  const _ToolbarContainerLayout();

  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    return false;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, kToolbarHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.tighten(height: kToolbarHeight);
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({
    Key key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation = 4.0,
    this.bacgroundColor,
    this.brightness,
    this.iconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  })  : assert(automaticallyImplyLeading != null),
        assert(elevation != null),
        assert(primary != null),
        assert(titleSpacing != null),
        assert(toolbarOpacity != null),
        assert(bottomOpacity != null),
        preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  final Widget leading;

  final bool automaticallyImplyLeading;

  final Widget title;

  final List<Widget> actions;

  final Widget flexibleSpace;

  final PreferredSizeWidget bottom;

  final double elevation;

  final Color bacgroundColor;

  final Brightness brightness;

  final IconThemeData iconTheme;

  final TextTheme textTheme;

  final bool primary;

  final bool centerTitle;

  final double titleSpacing;

  final double toolbarOpacity;

  final double bottomOpacity;

  @override
  final Size preferredSize;

  bool _getEffectiveCenterTitle(ThemeData themeData) {
    if (null != centerTitle) {
      return centerTitle;
    }
    assert(null != themeData.platform);
    switch (themeData.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return false;
      case TargetPlatform.iOS:
        return actions == null || actions.length < 2;
    }
    return null;
  }

  @override
  State createState() => _MyAppBarBar();

}

class _MyAppBarBar extends State<MyAppBar> {
  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _handleDrawerButtonEnd() {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    assert(!widget.primary || debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData themeData = Theme.of(context);
    final ScaffoldState scaffold = Scaffold.of(context, nullOk: true);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);

    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton = parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    IconThemeData appBarIconTheme = widget.iconTheme ?? themeData.primaryIconTheme;
    TextStyle centerStyle = widget.textTheme?.title ?? themeData.primaryTextTheme.title;
    TextStyle sideStyle = widget.textTheme?.body1 ?? themeData.primaryTextTheme.body1;

    if (1.0 != widget.toolbarOpacity) {
      final double opacity = const Interval(0.25, 1.0, curve: Curves.fastOutSlowIn).transform(widget.toolbarOpacity);
      if (null != centerStyle?.color) {
        centerStyle = centerStyle.copyWith(color: centerStyle.color.withOpacity(opacity));
      }
      if (null != sideStyle?.color) {
        sideStyle = sideStyle.copyWith(color: sideStyle.color.withOpacity(opacity));
      }
      appBarIconTheme = appBarIconTheme.copyWith(opacity: opacity * (appBarIconTheme.opacity ?? 1.0));
    }

    Widget leading = widget.leading;

    if (widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: leading ?? const Icon(Icons.menu),
          onPressed: _handleDrawerButton,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (canPop) {
          leading = useCloseButton ? const CloseButton() : const BackButton();
        }
      }
    }

    if (null != leading) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: _KLeadingWidth),
        child: leading,
      );
    }

    Widget title = widget.title;
    if (null != title) {
      bool namesRoute;
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          namesRoute = true;
          break;
        case TargetPlatform.iOS:
          namesRoute = false;
          break;
        default:
          break;
      }
      title = DefaultTextStyle(
        style: centerStyle,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Semantics(
          namesRoute: namesRoute,
          child: title,
          header: true,
        ),
      );
    }

    Widget actions;
    if (null != widget.actions && widget.actions.isNotEmpty) {
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.actions,
      );
    } else if (hasEndDrawer) {
      actions = IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _handleDrawerButtonEnd,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }

    final Widget toolbar = NavigationToolbar(
      leading: leading,
      middle: title,
      trailing: actions,
      centerMiddle: widget._getEffectiveCenterTitle(themeData),
      middleSpacing: widget.titleSpacing,
    );

    Widget appbar = ClipRect(
      child: CustomSingleChildLayout(
        delegate: const _ToolbarContainerLayout(),
        child: IconTheme.merge(
          data: appBarIconTheme,
          child: DefaultTextStyle(
            style: sideStyle,
            child: toolbar,
          ),
        ),
      ),
    );

    if (null != widget.bottom) {
      appbar = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: kToolbarHeight),
              child: appbar,
            ),
          ),
          widget.bottomOpacity == 1.0
              ? widget.bottom
              : Opacity(
                  opacity: const Interval(0.25, 1.0, curve: Curves.fastOutSlowIn).transform(widget.bottomOpacity),
                )
        ],
      );
    }

    if (widget.primary) {
      appbar = SafeArea(
        top: true,
        child: appbar,
      );
    }

    appbar = Align(
      alignment: Alignment.topCenter,
      child: appbar,
    );

    if (widget.flexibleSpace != null) {
      appbar = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          widget.flexibleSpace,
          appbar,
        ],
      );
    }
    final Brightness brightness = widget.brightness ?? themeData.primaryColorBrightness;
    final SystemUiOverlayStyle overlayStyle =
        brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          color: widget.bacgroundColor ?? themeData.primaryColor,
          elevation: widget.elevation,
          child: appbar,
        ),
      ),
    );
  }
}

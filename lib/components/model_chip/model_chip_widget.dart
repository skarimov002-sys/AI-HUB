// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model_chip_model.dart';
export 'model_chip_model.dart';

class ModelChipWidget extends StatefulWidget {
  const ModelChipWidget({
    super.key,
    this.icon,
    String? name,
    bool? active,
    bool? comingSoon,
  })  : this.name = name ?? 'Claude',
        this.active = active ?? true,
        this.comingSoon = comingSoon ?? false;

  final Widget? icon;
  final String name;
  final bool active;

  /// When true the chip is dimmed, labeled "Soon", and never shows as active.
  final bool comingSoon;

  @override
  State<ModelChipWidget> createState() => _ModelChipWidgetState();
}

class _ModelChipWidgetState extends State<ModelChipWidget> {
  late ModelChipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ModelChipModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.active && !widget.comingSoon;
    final textColor = isActive
        ? FlutterFlowTheme.of(context).onPrimary
        : widget.comingSoon
            ? FlutterFlowTheme.of(context).secondaryText
            : FlutterFlowTheme.of(context).primaryText;

    return Opacity(
      opacity: widget.comingSoon ? 0.6 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: isActive
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(9999.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: isActive
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 8.0),
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget!.icon!,
                Text(
                  widget.comingSoon
                      ? '${widget.name} · Soon'
                      : valueOrDefault<String>(
                          widget!.name,
                          'Claude',
                        ),
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                        font: GoogleFonts.spaceGrotesk(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelLarge.fontStyle,
                        ),
                        color: textColor,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelLarge.fontStyle,
                        lineHeight: 1.3,
                      ),
                ),
              ].divide(SizedBox(width: 4.0)),
            ),
          ),
        ),
      ),
    );
  }
}

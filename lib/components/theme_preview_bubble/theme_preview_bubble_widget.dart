import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'theme_preview_bubble_model.dart';
export 'theme_preview_bubble_model.dart';

class ThemePreviewBubbleWidget extends StatefulWidget {
  const ThemePreviewBubbleWidget({
    super.key,
    String? tone,
    bool? isAi,
  })  : this.tone = tone ?? 'primary',
        this.isAi = isAi ?? true;

  final String tone;
  final bool isAi;

  @override
  State<ThemePreviewBubbleWidget> createState() =>
      _ThemePreviewBubbleWidgetState();
}

class _ThemePreviewBubbleWidgetState extends State<ThemePreviewBubbleWidget> {
  late ThemePreviewBubbleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ThemePreviewBubbleModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          valueOrDefault<bool>(
            widget!.isAi,
            true,
          )
              ? FlutterFlowTheme.of(context).surfaceVariant
              : FlutterFlowTheme.of(context).primary,
          FlutterFlowTheme.of(context).surfaceVariant,
        ),
        borderRadius: BorderRadius.circular(12.0),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    valueOrDefault<bool>(
                      widget!.isAi,
                      true,
                    )
                        ? FlutterFlowTheme.of(context).secondaryText30
                        : FlutterFlowTheme.of(context).onPrimary40,
                    FlutterFlowTheme.of(context).secondaryText30,
                  ),
                  borderRadius: BorderRadius.circular(9999.0),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                width: 90.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    valueOrDefault<bool>(
                      widget!.isAi,
                      true,
                    )
                        ? FlutterFlowTheme.of(context).secondaryText20
                        : FlutterFlowTheme.of(context).onPrimary30,
                    FlutterFlowTheme.of(context).secondaryText20,
                  ),
                  borderRadius: BorderRadius.circular(9999.0),
                  shape: BoxShape.rectangle,
                ),
              ),
            ].divide(SizedBox(height: 4.0)),
          ),
        ),
      ),
    );
  }
}

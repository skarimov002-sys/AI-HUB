import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'history_item_model.dart';
export 'history_item_model.dart';

class HistoryItemWidget extends StatefulWidget {
  const HistoryItemWidget({
    super.key,
    Color? modelColor,
    String? snippet,
    String? time,
    String? title,
    String? model,
  })  : this.modelColor = modelColor ?? Colors.orange,
        this.snippet = snippet ??
            'The syntax looks much cleaner now with the new indentation rules...',
        this.time = time ?? '10:45 AM',
        this.title = title ?? 'Refactoring Flutter DSL',
        this.model = model ?? 'claude';

  final Color modelColor;
  final String snippet;
  final String time;
  final String title;
  final String model;

  @override
  State<HistoryItemWidget> createState() => _HistoryItemWidgetState();
}

class _HistoryItemWidgetState extends State<HistoryItemWidget> {
  late HistoryItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(18.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    widget!.modelColor,
                    Colors.orange,
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Container(
                  width: 24.0,
                  height: 24.0,
                  child: Stack(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    children: [
                      if (valueOrDefault<bool>(
                        valueOrDefault<String>(
                                  widget!.model,
                                  'claude',
                                ) ==
                                'gemini'
                            ? true
                            : false,
                        false,
                      ))
                        Icon(
                          Icons.help,
                          color: valueOrDefault<Color>(
                            widget!.modelColor,
                            Colors.orange,
                          ),
                          size: 24.0,
                        ),
                      if (valueOrDefault<bool>(
                        valueOrDefault<String>(
                                  widget!.model,
                                  'claude',
                                ) ==
                                'gemini'
                            ? false
                            : true,
                        true,
                      ))
                        Icon(
                          Icons.auto_awesome_rounded,
                          color: valueOrDefault<Color>(
                            widget!.modelColor,
                            Colors.orange,
                          ),
                          size: 24.0,
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            widget!.title,
                            'Refactoring Flutter DSL',
                          ),
                          maxLines: 1,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                                lineHeight: 1.4,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          valueOrDefault<String>(
                            widget!.time,
                            '10:45 AM',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                font: GoogleFonts.spaceGrotesk(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontStyle,
                                lineHeight: 1.2,
                              ),
                        ),
                      ],
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget!.snippet,
                        'The syntax looks much cleaner now with the new indentation rules...',
                      ),
                      maxLines: 2,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                            lineHeight: 1.4,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: valueOrDefault<Color>(
                                widget!.modelColor,
                                Colors.orange,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                            child: Text(
                              valueOrDefault<String>(
                                widget!.model,
                                'claude',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    font: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                    ),
                                    color: valueOrDefault<Color>(
                                      widget!.modelColor,
                                      Colors.orange,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                    lineHeight: 1.2,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(width: 4.0)),
                      ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
            ].divide(SizedBox(width: 16.0)),
          ),
        ),
      ),
    );
  }
}

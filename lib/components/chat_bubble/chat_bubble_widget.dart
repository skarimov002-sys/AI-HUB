import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_bubble_model.dart';
export 'chat_bubble_model.dart';

class ChatBubbleWidget extends StatefulWidget {
  const ChatBubbleWidget({
    super.key,
    String? message,
    String? time,
    Color? tone,
    String? role,
  })  : this.message = message ??
            'Hello! I\'m Claude. How can I help you explore the Nexus AI Hub today?',
        this.time = time ?? '10:02 AM',
        this.tone = tone ?? const Color(0x26FF9800),
        this.role = role ?? 'claude';

  final String message;
  final String time;
  final Color tone;
  final String role;

  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  late ChatBubbleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatBubbleModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (valueOrDefault<bool>(
                valueOrDefault<String>(
                          widget!.role,
                          'claude',
                        ) ==
                        'user'
                    ? false
                    : true,
                true,
              ))
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget!.tone,
                      Color(0x26FF9800),
                    ),
                    borderRadius: BorderRadius.circular(9999.0),
                    shape: BoxShape.rectangle,
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: 18.0,
                    height: 18.0,
                    child: Stack(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      children: [
                        if (valueOrDefault<bool>(
                          valueOrDefault<String>(
                                    widget!.role,
                                    'claude',
                                  ) ==
                                  'gemini'
                              ? true
                              : false,
                          false,
                        ))
                          Icon(
                            Icons.memory_rounded,
                            color: FlutterFlowTheme.of(context).onSurface,
                            size: 18.0,
                          ),
                      ],
                    ),
                  ),
                ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 300.0,
                ),
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    valueOrDefault<String>(
                              widget!.role,
                              'claude',
                            ) ==
                            'user'
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).surfaceVariant,
                    FlutterFlowTheme.of(context).surfaceVariant,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                  child: Container(
                    child: Text(
                      valueOrDefault<String>(
                        widget!.message,
                        'Hello! I\'m Claude. How can I help you explore the Nexus AI Hub today?',
                      ),
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            color: valueOrDefault<Color>(
                              valueOrDefault<String>(
                                        widget!.role,
                                        'claude',
                                      ) ==
                                      'user'
                                  ? FlutterFlowTheme.of(context).onPrimary
                                  : FlutterFlowTheme.of(context).primaryText,
                              FlutterFlowTheme.of(context).primaryText,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                            lineHeight: 1.5,
                          ),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(width: 8.0)),
          ),
          Container(
            child: Text(
              valueOrDefault<String>(
                widget!.time,
                '10:02 AM',
              ),
              style: FlutterFlowTheme.of(context).labelSmall.override(
                    font: GoogleFonts.spaceGrotesk(
                      fontWeight:
                          FlutterFlowTheme.of(context).labelSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).labelSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelSmall.fontStyle,
                    lineHeight: 1.2,
                  ),
            ),
          ),
        ].divide(SizedBox(height: 4.0)),
      ),
    );
  }
}

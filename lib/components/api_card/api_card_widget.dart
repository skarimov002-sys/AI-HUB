import '/components/button/button_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'api_card_model.dart';
export 'api_card_model.dart';

class ApiCardWidget extends StatefulWidget {
  const ApiCardWidget({
    super.key,
    this.icon,
    String? name,
    String? slug,
    Color? tone,
    bool? connected,
  })  : this.name = name ?? 'OpenAI',
        this.slug = slug ?? 'openai',
        this.tone = tone ?? const Color(0xFFFF6B00),
        this.connected = connected ?? true;

  final Widget? icon;
  final String name;
  final String slug;
  final Color tone;
  final bool connected;

  @override
  State<ApiCardWidget> createState() => _ApiCardWidgetState();
}

class _ApiCardWidgetState extends State<ApiCardWidget> {
  late ApiCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApiCardModel());
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            widget!.tone,
                            Color(0xFFFF6B00),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                        child: widget!.icon!,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              widget!.name,
                              'OpenAI',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'nw1hzvpw' /* API Configuration */,
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
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
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
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
                ],
              ),
              wrapWithModel(
                model: _model.textFieldModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: 'API Key',
                  labelPresent: true,
                  helper: '',
                  helperPresent: false,
                  leadingIconPresent: false,
                  trailingIcon: Icon(
                    Icons.visibility_off_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  trailingIconPresent: true,
                  hint: 'sk-...',
                  value: valueOrDefault<String>(
                    valueOrDefault<bool>(
                      widget!.connected,
                      true,
                    )
                        ? '••••••••••••••••'
                        : '',
                    '••••••••••••••••',
                  ),
                  onChange: '',
                  onSubmit: '',
                  variant: 'outlined',
                  error: false,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  wrapWithModel(
                    model: _model.buttonModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: ButtonWidget(
                      iconPresent: false,
                      iconEndPresent: false,
                      content: 'Test Connection',
                      variant: 'ghost',
                      size: 'small',
                      fullWidth: false,
                      loading: false,
                      disabled: valueOrDefault<bool>(
                        valueOrDefault<bool>(
                          widget!.connected,
                          true,
                        )
                            ? false
                            : true,
                        false,
                      ),
                    ),
                  ),
                  wrapWithModel(
                    model: _model.buttonModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: ButtonWidget(
                      iconPresent: false,
                      iconEndPresent: false,
                      content: valueOrDefault<String>(
                        valueOrDefault<bool>(
                          widget!.connected,
                          true,
                        )
                            ? 'Update Key'
                            : 'Save Key',
                        'Update Key',
                      ),
                      variant: 'primary',
                      size: 'small',
                      fullWidth: false,
                      loading: false,
                      disabled: false,
                    ),
                  ),
                ].divide(SizedBox(width: 16.0)),
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }
}

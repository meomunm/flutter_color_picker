/// HSV(HSB)/HSL color picker

library flutter_colorpicker;

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/hsv_picker.dart';

export 'package:flutter_colorpicker/hsv_picker.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({
    @required this.pickerColor,
    @required this.onColorChanged,
    this.paletteType: PaletteType.hsv,
    this.enableAlpha: true,
    this.enableLabel: true,
    this.displayThumbColor: false,
    this.colorPickerWidth: 300.0,
    this.pickerAreaHeightPercent: 1.0,
    this.headerText,
    this.headerTextStyle,
    this.doneText,
    this.doneTextStyle,
    @required this.callBackColor,
  });

  final Function(Color) callBackColor;
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final PaletteType paletteType;
  final bool enableAlpha;
  final bool enableLabel;
  final bool displayThumbColor;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;
  final String headerText;
  final TextStyle headerTextStyle;
  final String doneText;
  final TextStyle doneTextStyle;

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);

  @override
  void initState() {
    super.initState();
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  @override
  void didUpdateWidget(ColorPickerDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.headerText,
              style: widget.headerTextStyle,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: widget.colorPickerWidth,
            height: widget.colorPickerWidth * widget.pickerAreaHeightPercent,
            child: ColorPickerArea(currentHsvColor, (HSVColor color) {
              setState(() => currentHsvColor = color);
              // widget.onColorChanged(currentHsvColor.toColor());
            }, widget.paletteType),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ColorIndicator(currentHsvColor),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                        width: widget.colorPickerWidth - 75.0,
                        child: ColorPickerSlider(
                          TrackType.hue,
                          currentHsvColor,
                          (HSVColor color) {
                            setState(() => currentHsvColor = color);
                            // widget.onColorChanged(currentHsvColor.toColor());
                          },
                          displayThumbColor: widget.displayThumbColor,
                        ),
                      ),
                      widget.enableAlpha
                          ? SizedBox(
                              height: 40.0,
                              width: widget.colorPickerWidth - 75.0,
                              child: ColorPickerSlider(
                                TrackType.alpha,
                                currentHsvColor,
                                (HSVColor color) {
                                  setState(() => currentHsvColor = color);
                                  // widget.onColorChanged(
                                  //     currentHsvColor.toColor());
                                },
                                displayThumbColor: widget.displayThumbColor,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.enableLabel ? ColorPickerLabel(currentHsvColor) : SizedBox(),
          SizedBox(height: 20.0),
          InkWell(
            onTap: () {
              widget.onColorChanged(currentHsvColor.toColor());
              widget.callBackColor(currentHsvColor.toColor());
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  widget.doneText,
                  style: widget.doneTextStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

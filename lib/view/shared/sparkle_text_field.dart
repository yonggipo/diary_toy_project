import 'package:diary_toy_project/application/common/app_color.dart';
import 'package:flutter/material.dart';

typedef OnTextChanged = void Function(String text);
typedef OnTagsChanged = void Function(List<String> tags);

final class SparkleTextField extends StatefulWidget {
  const SparkleTextField({
    super.key,
    this.initialValue = "",
    this.onTextChanged,
    this.labelText,
    this.placeholder,
    this.tags,
    this.onTagsChanged,
    this.autofocus = false,
    this.autoTag = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.validator,
  });

  final String initialValue;
  final String? labelText;
  final OnTextChanged? onTextChanged;
  final List<String>? tags;
  final bool autoTag;
  final OnTagsChanged? onTagsChanged;
  final String? placeholder;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final AutovalidateMode autovalidateMode;
  final FormFieldValidator<String>? validator;

  @override
  State<SparkleTextField> createState() => _SparkleTextFieldState();
}

final class _SparkleTextFieldState extends State<SparkleTextField> {
  // MARK: - Properties

  bool _isEditing = false;
  late String _cached = widget.autoTag
      ? convertToTags(widget.tags?.join() ?? "").join(' ')
      : widget.initialValue;
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  // MARK: - Life Cycle Methods

  @override
  void initState() {
    super.initState();
    if (widget.initialValue.isNotEmpty) {
      _textEditingController.text = widget.initialValue;
    }
    _textEditingController.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _textEditingController
      ..removeListener(_onTextChanged)
      ..dispose();
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  // MARK: - Handler Methods

  void _onTextChanged() {
    var tags = convertToTags(_textEditingController.text).map((word) {
      return word.replaceAll(RegExp(r'[,\s#]+'), '');
    }).toList();

    widget.autoTag
        ? (this
          ..saveCache()
          ..widget.onTagsChanged?.call(tags))
        : widget.onTextChanged?.call(_textEditingController.text);
  }

  void _onFocusChange() {
    saveCache();
    setState(() {
      _isEditing = _focusNode.hasFocus;
      if (_focusNode.hasFocus) {
        _textEditingController.text = _cached;
      }
    });
  }

  // MARK: - Support Methods

  void saveCache() {
    print('<<<<<<<< tag 캐쉬 저장 >>>>>>>>');
    final text = _textEditingController.text;
    if (text.isNotEmpty) {
      _cached = widget.autoTag ? convertToTags(text).join(' ') : text;
    }
  }

  List<String> convertToTags(String text) {
    return text
        .split(RegExp(r'[,\s#]+'))
        .map((word) => '#${word.replaceAll(RegExp(r'[,\s#]+'), '')}')
        .where((word) => word != '#')
        .toList();
  }

  // MARK: - Widget Build Method

  @override
  Widget build(BuildContext context) {
    final bolder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColor.border),
      borderRadius: BorderRadius.circular(10),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: (!_isEditing && widget.autoTag)
          ? Container(
              width: double.infinity,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: AppColor.border,
                  width: 1.0,
                ),
              ),
              child: Text(
                _cached,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            )
          : TextFormField(
              autovalidateMode: widget.autovalidateMode,
              validator: widget.validator,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              controller: _textEditingController,
              focusNode: _focusNode,
              autofocus: widget.autofocus,
              onFieldSubmitted: (value) {
                setState(() {
                  _isEditing = false;
                });
              },
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                border: bolder,
                focusedBorder: bolder,
                enabledBorder: bolder,
                errorBorder: bolder,
                disabledBorder: bolder,
                label: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.labelText,
                        style: const TextStyle(
                          color: AppColor.label,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                hintText: widget.placeholder,
                hintStyle: const TextStyle(
                  color: AppColor.placeholder,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import '../catalog/section_header.dart';

class InputsScreen extends StatefulWidget {
  const InputsScreen({super.key});

  @override
  State<InputsScreen> createState() => _InputsScreenState();
}

class _InputsScreenState extends State<InputsScreen> {
  bool _checkboxValue = false;
  bool _switchValue = false;
  double _sliderValue = 0.5;
  String? _dropdown;
  String _radioValue = 'option_a';
  List<String> _multiSelected = [];

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return ListView(
      padding: EdgeInsets.fromLTRB(
        WidgetXSpacing.md, WidgetXSpacing.md,
        WidgetXSpacing.md, WidgetXSpacing.md + bottom,
      ),
        children: [
          const SectionHeader(title: 'Text Fields'),
          const WidgetXTextField(label: 'Full Name', hint: 'Enter your name'),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXPasswordField(label: 'Password'),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXSearchField(hint: 'Search components…'),
          const SizedBox(height: WidgetXSpacing.sm),
          const WidgetXTextField(
            label: 'Error example',
            hint: 'Required field',
            errorText: 'This field is required',
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Selection Controls'),
          WidgetXCheckbox(
            label: 'Accept terms and conditions',
            value: _checkboxValue,
            onChanged: (v) => setState(() => _checkboxValue = v ?? false),
          ),
          WidgetXSwitch(
            label: 'Enable notifications',
            value: _switchValue,
            onChanged: (v) => setState(() => _switchValue = v),
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Slider'),
          WidgetXSlider(
            label: 'Volume',
            value: _sliderValue,
            onChanged: (v) => setState(() => _sliderValue = v),
            showValueLabel: true,
          ),
          const SizedBox(height: WidgetXSpacing.lg),
          const SectionHeader(title: 'Dropdown'),
          WidgetXDropdown<String>(
            label: 'Country',
            items: const [
              'United States',
              'United Kingdom',
              'Australia',
              'Canada',
            ],
            itemLabel: (v) => v,
            value: _dropdown,
            onChanged: (v) => setState(() => _dropdown = v),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Multi-select
          const SectionHeader(
            title: 'Multi-Select Dropdown',
            description: 'Select multiple options with chip display.',
          ),
          WidgetXMultiSelectDropdown<String>(
            label: 'Technologies',
            hint: 'Select your skills…',
            items: const [
              'Flutter',
              'Dart',
              'Firebase',
              'Riverpod',
              'go_router',
              'REST APIs',
            ],
            itemLabel: (v) => v,
            selectedValues: _multiSelected,
            onChanged: (v) => setState(() => _multiSelected = v),
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // Radio buttons
          const SectionHeader(
            title: 'Radio Buttons',
            description: 'Mutually exclusive single selection.',
          ),
          WidgetXRadioGroup<String>(
            groupValue: _radioValue,
            onChanged: (v) => setState(() => _radioValue = v!),
            children: const [
              WidgetXRadio<String>(
                value: 'option_a',
                label: 'Option A — Standard plan',
              ),
              WidgetXRadio<String>(
                value: 'option_b',
                label: 'Option B — Professional plan',
              ),
              WidgetXRadio<String>(
                value: 'option_c',
                label: 'Option C — Enterprise plan',
              ),
            ],
          ),
          const SizedBox(height: WidgetXSpacing.lg),

          // OTP field
          const SectionHeader(
            title: 'OTP Field',
            description:
                '6-digit one-time password input with auto-advance, '
                'backspace support, and paste handling.',
          ),
          const WidgetXOTPField(length: 6),
          const SizedBox(height: WidgetXSpacing.lg),
          const WidgetXOTPField(length: 4, obscureText: true),
          const SizedBox(height: WidgetXSpacing.xl),
        ],
      );
  }
}

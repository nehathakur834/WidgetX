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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetXAppBar(title: 'Inputs'),
      body: ListView(
        padding: const EdgeInsets.all(WidgetXSpacing.md),
        children: [
          const SectionHeader(title: 'Text Fields'),
          const WidgetXTextField(
            label: 'Full Name',
            hint: 'Enter your name',
          ),
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
            items: const ['United States', 'United Kingdom', 'Australia', 'Canada'],
            itemLabel: (v) => v,
            value: _dropdown,
            onChanged: (v) => setState(() => _dropdown = v),
          ),
        ],
      ),
    );
  }
}

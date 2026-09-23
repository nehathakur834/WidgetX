import 'package:flutter/material.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import 'otp_verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;
  String _password = '';

  double get _strength {
    final p = _password;
    if (p.length < 4) return 0;
    double s = 0;
    if (p.length >= 8) s += 0.25;
    if (p.length >= 12) s += 0.1;
    if (RegExp(r'[A-Z]').hasMatch(p)) s += 0.25;
    if (RegExp(r'[0-9]').hasMatch(p)) s += 0.25;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(p)) s += 0.15;
    return s.clamp(0.0, 1.0);
  }

  Color _strengthColor(BuildContext context) {
    final s = _strength;
    if (s < 0.35) return Theme.of(context).colorScheme.error;
    if (s < 0.65) return Colors.orange;
    return Colors.green.shade600;
  }

  String _strengthLabel() {
    final s = _strength;
    if (s < 0.35) return 'Weak';
    if (s < 0.65) return 'Fair';
    if (s < 0.85) return 'Good';
    return 'Strong';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(WidgetXSpacing.xl),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create account',
                  style: tt.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: WidgetXSpacing.xs),
                Text(
                  'Join WidgetX and start building beautiful apps',
                  style: tt.bodyMedium
                      ?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: WidgetXSpacing.xxl),

                WidgetXTextField(
                  controller: _nameController,
                  label: 'Full name',
                  hint: 'Jane Smith',
                  prefixIcon: const Icon(Icons.person_outline, size: 18),
                ),
                const SizedBox(height: WidgetXSpacing.md),

                WidgetXTextField(
                  controller: _emailController,
                  label: 'Email address',
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined, size: 18),
                ),
                const SizedBox(height: WidgetXSpacing.md),

                // Password with strength meter
                WidgetXTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'At least 8 characters',
                  obscureText: _obscurePassword,
                  onChanged: (v) => setState(() => _password = v),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20,
                    ),
                    onPressed: () => setState(
                        () => _obscurePassword = !_obscurePassword),
                  ),
                ),

                // Password strength indicator
                if (_password.isNotEmpty) ...[
                  const SizedBox(height: WidgetXSpacing.xs),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: _strength,
                            minHeight: 6,
                            backgroundColor: cs.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation(
                                _strengthColor(context)),
                          ),
                        ),
                      ),
                      const SizedBox(width: WidgetXSpacing.sm),
                      Text(
                        _strengthLabel(),
                        style: tt.labelSmall?.copyWith(
                            color: _strengthColor(context),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: WidgetXSpacing.md),

                WidgetXTextField(
                  controller: _confirmController,
                  label: 'Confirm password',
                  hint: 'Repeat your password',
                  obscureText: _obscureConfirm,
                  errorText: _confirmController.text.isNotEmpty &&
                          _confirmController.text != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20,
                    ),
                    onPressed: () => setState(
                        () => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                const SizedBox(height: WidgetXSpacing.md),

                WidgetXCheckbox(
                  value: _agreeTerms,
                  onChanged: (v) =>
                      setState(() => _agreeTerms = v ?? false),
                  label:
                      'I agree to the Terms of Service and Privacy Policy',
                ),
                const SizedBox(height: WidgetXSpacing.xl),

                WidgetXButton(
                  label: 'Create account',
                  onPressed: _agreeTerms
                      ? () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  const OtpVerificationScreen(),
                            ),
                          )
                      : null,
                  variant: WidgetXButtonVariant.primary,
                  isFullWidth: true,
                ),
                const SizedBox(height: WidgetXSpacing.lg),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?', style: tt.bodyMedium),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

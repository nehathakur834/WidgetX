import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:widgetx_ui/widgetx_ui.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(WidgetXSpacing.xl),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo — fade + scale in
                Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: cs.primary,
                      borderRadius:
                          BorderRadius.circular(WidgetXRadius.lg),
                    ),
                    child: Icon(Icons.widgets_outlined,
                        color: cs.onPrimary, size: 28),
                  ).animate().fadeIn(duration: 400.ms).scaleXY(
                        begin: 0.8,
                        end: 1.0,
                        curve: Curves.easeOutBack,
                      ),
                ),
                const SizedBox(height: WidgetXSpacing.lg),
                Text(
                  'Welcome back',
                  style: tt.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: 80.ms, duration: 350.ms)
                    .slideY(begin: 0.2, end: 0),
                const SizedBox(height: WidgetXSpacing.xs),
                Text(
                  'Sign in to your WidgetX account',
                  style: tt.bodyMedium
                      ?.copyWith(color: cs.onSurfaceVariant),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: 130.ms, duration: 350.ms)
                    .slideY(begin: 0.2, end: 0),
                const SizedBox(height: WidgetXSpacing.xxl),

                // Social login
                _SocialButton(
                  icon: Icons.g_mobiledata,
                  label: 'Continue with Google',
                  onTap: () {},
                )
                    .animate()
                    .fadeIn(delay: 180.ms, duration: 300.ms)
                    .slideY(begin: 0.15, end: 0),
                const SizedBox(height: WidgetXSpacing.sm),
                _SocialButton(
                  icon: Icons.apple,
                  label: 'Continue with Apple',
                  onTap: () {},
                )
                    .animate()
                    .fadeIn(delay: 220.ms, duration: 300.ms)
                    .slideY(begin: 0.15, end: 0),
                const SizedBox(height: WidgetXSpacing.lg),

                // Divider
                Row(children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: WidgetXSpacing.sm),
                    child: Text('or',
                        style: tt.bodySmall
                            ?.copyWith(color: cs.onSurfaceVariant)),
                  ),
                  const Expanded(child: Divider()),
                ]).animate().fadeIn(delay: 260.ms, duration: 300.ms),
                const SizedBox(height: WidgetXSpacing.lg),

                // Email
                WidgetXTextField(
                  controller: _emailController,
                  label: 'Email address',
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 300.ms)
                    .slideY(begin: 0.1, end: 0),
                const SizedBox(height: WidgetXSpacing.md),

                // Password
                WidgetXTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: '••••••••',
                  obscureText: _obscurePassword,
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
                )
                    .animate()
                    .fadeIn(delay: 340.ms, duration: 300.ms)
                    .slideY(begin: 0.1, end: 0),
                const SizedBox(height: WidgetXSpacing.sm),

                // Remember me + Forgot password
                Row(
                  children: [
                    WidgetXCheckbox(
                      value: _rememberMe,
                      onChanged: (v) =>
                          setState(() => _rememberMe = v ?? false),
                      label: 'Remember me',
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen()),
                      ),
                      child: const Text('Forgot password?'),
                    ),
                  ],
                ).animate().fadeIn(delay: 370.ms, duration: 280.ms),
                const SizedBox(height: WidgetXSpacing.lg),

                // Sign in button
                WidgetXButton(
                  label: 'Sign in',
                  onPressed: () {},
                  variant: WidgetXButtonVariant.primary,
                  isFullWidth: true,
                )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 300.ms)
                    .slideY(begin: 0.1, end: 0),
                const SizedBox(height: WidgetXSpacing.lg),

                // Create account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: tt.bodyMedium),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen()),
                      ),
                      child: const Text('Create one'),
                    ),
                  ],
                ).animate().fadeIn(delay: 440.ms, duration: 280.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton(
      {required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        side: BorderSide(color: cs.outline),
        foregroundColor: cs.onSurface,
      ),
    );
  }
}

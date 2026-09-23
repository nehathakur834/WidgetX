import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../mock/mock_data.dart';
import '../shell/main_shell.dart';
import '../screens/home_screen.dart';
import '../screens/foundations_screen.dart';
import '../screens/buttons_screen.dart';
import '../screens/inputs_screen.dart';
import '../screens/cards_screen.dart';
import '../screens/feedback_screen.dart';
import '../screens/layout_screen.dart';
import '../screens/navigation_screen.dart';
import '../screens/data_display_screen.dart';
import '../screens/dialogs_screen.dart';
import '../screens/accessibility_screen.dart';
import '../screens/charts_screen.dart';
import '../screens/templates_screen.dart';
import '../templates/auth/login_screen.dart';
import '../templates/auth/register_screen.dart';
import '../templates/auth/onboarding_screen.dart';
import '../templates/auth/welcome_screen.dart';
import '../templates/auth/forgot_password_screen.dart';
import '../templates/auth/otp_verification_screen.dart';
import '../templates/dashboard/analytics_dashboard_screen.dart';
import '../templates/ecommerce/ecommerce_home_screen.dart';
import '../templates/ecommerce/product_details_screen.dart';
import '../templates/ecommerce/cart_screen.dart';
import '../templates/finance/finance_dashboard_screen.dart';
import '../templates/realestate/property_home_screen.dart';
import '../templates/realestate/property_details_screen.dart';
import '../templates/social/social_home_screen.dart';
import '../templates/food/food_home_screen.dart';
import '../templates/productivity/task_dashboard_screen.dart';
import '../templates/portfolio/portfolio_screen.dart';
import '../templates/settings/settings_screen.dart';
import '../templates/booking/booking_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (ctx, s) => const HomeScreen()),
          // Components
          GoRoute(
              path: '/foundations',
              builder: (ctx, s) => const FoundationsScreen()),
          GoRoute(
              path: '/buttons',
              builder: (ctx, s) => const ButtonsScreen()),
          GoRoute(
              path: '/inputs',
              builder: (ctx, s) => const InputsScreen()),
          GoRoute(
              path: '/cards',
              builder: (ctx, s) => const CardsScreen()),
          GoRoute(
              path: '/feedback',
              builder: (ctx, s) => const FeedbackScreen()),
          GoRoute(
              path: '/layout',
              builder: (ctx, s) => const LayoutScreen()),
          GoRoute(
              path: '/navigation',
              builder: (ctx, s) => const NavigationScreen()),
          GoRoute(
              path: '/data-display',
              builder: (ctx, s) => const DataDisplayScreen()),
          GoRoute(
              path: '/dialogs',
              builder: (ctx, s) => const DialogsScreen()),
          GoRoute(
              path: '/accessibility',
              builder: (ctx, s) => const AccessibilityScreen()),
          GoRoute(
              path: '/charts',
              builder: (ctx, s) => const ChartsScreen()),
          GoRoute(
              path: '/templates',
              builder: (ctx, s) => const TemplatesScreen()),
          // Templates
          GoRoute(
              path: '/templates/auth/login',
              builder: (ctx, s) => const LoginScreen()),
          GoRoute(
              path: '/templates/auth/register',
              builder: (ctx, s) => const RegisterScreen()),
          GoRoute(
              path: '/templates/auth/onboarding',
              builder: (ctx, s) => const OnboardingScreen()),
          GoRoute(
              path: '/templates/auth/welcome',
              builder: (ctx, s) => const WelcomeScreen()),
          GoRoute(
              path: '/templates/auth/forgot-password',
              builder: (ctx, s) => const ForgotPasswordScreen()),
          GoRoute(
              path: '/templates/auth/otp',
              builder: (ctx, s) => const OtpVerificationScreen()),
          GoRoute(
              path: '/templates/dashboard',
              builder: (ctx, s) => const AnalyticsDashboardScreen()),
          GoRoute(
              path: '/templates/ecommerce',
              builder: (ctx, s) => const EcommerceHomeScreen()),
          GoRoute(
              path: '/templates/ecommerce/product',
              builder: (ctx, s) => ProductDetailsScreen(
                    product: s.extra is MockProduct
                        ? s.extra as MockProduct
                        : null,
                  )),
          GoRoute(
              path: '/templates/ecommerce/cart',
              builder: (ctx, s) => const CartScreen()),
          GoRoute(
              path: '/templates/finance',
              builder: (ctx, s) => const FinanceDashboardScreen()),
          GoRoute(
              path: '/templates/realestate',
              builder: (ctx, s) => const PropertyHomeScreen()),
          GoRoute(
              path: '/templates/realestate/details',
              builder: (ctx, s) => const PropertyDetailsScreen()),
          GoRoute(
              path: '/templates/social',
              builder: (ctx, s) => const SocialHomeScreen()),
          GoRoute(
              path: '/templates/food',
              builder: (ctx, s) => const FoodHomeScreen()),
          GoRoute(
              path: '/templates/productivity',
              builder: (ctx, s) => const TaskDashboardScreen()),
          GoRoute(
              path: '/templates/portfolio',
              builder: (ctx, s) => const PortfolioScreen()),
          GoRoute(
              path: '/templates/settings',
              builder: (ctx, s) => const SettingsScreen()),
          GoRoute(
              path: '/templates/booking',
              builder: (ctx, s) => const BookingScreen()),
        ],
      ),
    ],
  );
});

import 'package:flutter/material.dart';
import 'package:smes/add_new_stock_page.dart';
import 'package:smes/login_page.dart';
import 'package:smes/record_sales_options_page.dart';
import 'package:smes/register_page.dart';
import 'package:smes/forgot_password_page.dart';
import 'package:smes/set_password.dart';
import 'package:smes/otp_page.dart';
import 'package:smes/shop_manager_dashboard.dart';
import 'package:smes/system_admin_dashboard.dart';
import 'package:smes/new_sales_page.dart';
import 'package:smes/profit_page.dart';
import 'package:smes/daily_sales_page.dart';
import 'package:smes/add_product_page.dart';
import 'package:smes/delete_options_page.dart';
import 'package:smes/business_insight_options_page.dart';
import 'package:smes/product_options_page.dart';
import 'package:smes/register_attendant_page.dart';
import 'package:smes/home_page.dart';
import 'package:smes/settings_page.dart';
import 'package:smes/update_profile_page.dart';
import 'package:smes/customer_attendant_dashboard.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Theme management
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: _notifier,
        builder: (_, currentMode, __) {
          return ChangeNotifierProvider<ValueNotifier<ThemeMode>>.value(
            value: _notifier,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SMEs',
              theme: ThemeData(
                // Main theme colors
                primaryColor: Colors.blue,
                scaffoldBackgroundColor: Colors.white,

                // AppBar Theme
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Button Theme
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                // Text Theme
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
                  bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
                  titleLarge:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // Input Field Theme
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  labelStyle: const TextStyle(color: Colors.grey),
                ),

                // Icon Theme
                iconTheme: const IconThemeData(
                  color: Colors.blue,
                  size: 24,
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Colors.blue[700],
                scaffoldBackgroundColor: Colors.grey[850],
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  elevation: 0,
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
                  bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
                  titleLarge:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.grey[700],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[700]!, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[700]!),
                  ),
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
                iconTheme: IconThemeData(
                  color: Colors.blue[700],
                  size: 24,
                ),
              ),
              themeMode: currentMode,
              initialRoute: '/login', // Start with the login page
              routes: {
                '/login': (context) => const LoginPage(),
                '/register': (context) => const RegisterPage(),
                '/forgot-password': (context) => const ForgotPasswordPage(),
                '/set-password': (context) => const SetPasswordPage(),
                '/otp': (context) => const OTPPage(),
                '/shop-manager-dashboard': (context) =>
                const ShopManagerDashboard(),
                '/system-admin-dashboard': (context) =>
                const SystemAdminDashboard(),
                '/record-sales': (context) => const RecordSalesOptionsPage(),
                '/new-sales': (context) => const NewSalesPage(),
                '/profit': (context) => const ProfitPage(),
                '/daily-sales': (context) => const DailySalesPage(),
                '/add-product': (context) => const AddProductPage(),
                '/delete-options': (context) => const DeleteOptionsPage(),
                '/business-insights-options': (context) =>
                const BusinessInsightsOptionsPage(),
                '/product-options': (context) => const ProductOptionsPage(),
                '/register-attendant': (context) =>
                const RegisterAttendantPage(),
                '/home': (context) => HomePage(stock: const []),
                '/add-new-stock': (context) =>
                    AddNewStockPage(onStockItemAdded: (item) {}),
                '/settings': (context) => const SettingsPage(),
                '/update-profile': (context) => const UpdateProfilePage(),
                '/customer-attendant-dashboard': (context) => const CustomerAttendantDashboard(),
              },
            ),
          );
        });
  }
}
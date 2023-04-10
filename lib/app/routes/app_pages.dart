import 'package:get/get.dart';

import '../modules/admin_module/admin_calendar/bindings/admin_calendar_binding.dart';
import '../modules/admin_module/admin_calendar/views/admin_calendar_view.dart';
import '../modules/admin_module/admin_create_employee/bindings/admin_create_employee_binding.dart';
import '../modules/admin_module/admin_create_employee/views/admin_create_employee_view.dart';
import '../modules/admin_module/admin_create_leave/bindings/admin_create_leave_binding.dart';
import '../modules/admin_module/admin_create_leave/views/admin_create_leave_view.dart';
import '../modules/admin_module/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/admin_module/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/admin_module/admin_leave_request/bindings/admin_leave_request_binding.dart';
import '../modules/admin_module/admin_leave_request/views/admin_leave_request_view.dart';
import '../modules/admin_module/admin_login/bindings/admin_login_binding.dart';
import '../modules/admin_module/admin_login/views/admin_login_view.dart';
import '../modules/admin_module/admin_today_atten/bindings/admin_today_atten_binding.dart';
import '../modules/admin_module/admin_today_atten/views/admin_today_atten_view.dart';
import '../modules/loginType/bindings/login_type_binding.dart';
import '../modules/loginType/views/login_type_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/user_module/check_out/bindings/check_out_binding.dart';
import '../modules/user_module/check_out/views/check_out_view.dart';
import '../modules/user_module/dashboard/bindings/dashboard_binding.dart';
import '../modules/user_module/dashboard/views/dashboard_view.dart';
import '../modules/user_module/login/bindings/login_binding.dart';
import '../modules/user_module/login/views/login_view.dart';
import '../modules/user_module/otp/bindings/otp_binding.dart';
import '../modules/user_module/otp/views/otp_view.dart';
import '../modules/user_module/profile/bindings/profile_binding.dart';
import '../modules/user_module/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_OUT,
      page: () => const CheckOutView(),
      binding: CheckOutBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_TYPE,
      page: () => const LoginTypeView(),
      binding: LoginTypeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_LOGIN,
      page: () => AdminLoginView(),
      binding: AdminLoginBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_TODAY_ATTEN,
      page: () => AdminTodayAttenView(),
      binding: AdminTodayAttenBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CREATE_EMPLOYEE,
      page: () => const AdminCreateEmployeeView(),
      binding: AdminCreateEmployeeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CREATE_LEAVE,
      page: () => const AdminCreateLeaveView(),
      binding: AdminCreateLeaveBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_LEAVE_REQUEST,
      page: () => const AdminLeaveRequestView(),
      binding: AdminLeaveRequestBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CALENDAR,
      page: () => const AdminCalendarView(),
      binding: AdminCalendarBinding(),
    ),
  ];
}

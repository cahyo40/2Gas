import 'package:get/get.dart';

import '../features/bottom_navigation_bar/presentation/binding/bottom_navigation_bar_binding.dart';
import '../features/bottom_navigation_bar/presentation/view/bottom_navigation_bar_view.dart';
import '../features/home/presentation/binding/home_binding.dart';
import '../features/home/presentation/view/home_view.dart';
import '../features/login/presentation/binding/login_binding.dart';
import '../features/login/presentation/view/login_view.dart';
import '../features/notifications/presentation/binding/notifications_binding.dart';
import '../features/notifications/presentation/view/notifications_view.dart';
import '../features/search/presentation/binding/search_binding.dart';
import '../features/search/presentation/view/search_view.dart';
import '../features/settings/presentation/binding/settings_binding.dart';
import '../features/settings/presentation/view/settings_view.dart';
import '../features/splash_screen/presentation/binding/splash_screen_binding.dart';
import '../features/splash_screen/presentation/view/splash_screen_view.dart';
import '../features/task/presentation/binding/task_binding.dart';
import '../features/task/presentation/view/task_view.dart';
import '../features/onboard/presentation/binding/onboard_binding.dart';
import '../features/onboard/presentation/view/onboard_view.dart';
import '../features/organization/presentation/binding/organization_binding.dart';
import '../features/organization/presentation/view/organization_view.dart';
import '../features/organization_create_update/presentation/binding/organization_create_update_binding.dart';
import '../features/organization_create_update/presentation/view/organization_create_update_view.dart';
import '../features/project_create/presentation/binding/project_create_binding.dart';
import '../features/project_create/presentation/view/project_create_view.dart';
import '../features/project/presentation/binding/project_binding.dart';
import '../features/project/presentation/view/project_view.dart';
import 'route_names.dart';

class RouteApp {
  static final routes = [
    GetPage(
      name: RouteNames.BOTTOM_NAVIGATION_BAR,
      page: () => const BottomNavigationBarView(),
      bindings: [
        BottomNavigationBarBinding(),
        HomeBinding(),
        TaskBinding(),
        SearchBinding(),
        NotificationsBinding(),
        SettingsBinding(),
      ],
      // middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: RouteNames.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      // middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: RouteNames.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: RouteNames.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteNames.TASK,
      page: () => const TaskView(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: RouteNames.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: RouteNames.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: RouteNames.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
      GetPage(
      name: RouteNames.ONBOARD,
      page: () => const OnboardView(),
      binding: OnboardBinding(),
      
    ),    GetPage(
      name: RouteNames.ORGANIZATION,
      page: () => const OrganizationView(),
      binding: OrganizationBinding(),
      
    ),    GetPage(
      name: RouteNames.ORGANIZATION_CREATE_UPDATE,
      page: () => const OrganizationCreateUpdateView(),
      binding: OrganizationCreateUpdateBinding(),
      
    ),    GetPage(
      name: RouteNames.PROJECT_CREATE,
      page: () => const ProjectCreateView(),
      binding: ProjectCreateBinding(),
      
    ),    GetPage(
      name: RouteNames.PROJECT,
      page: () => const ProjectView(),
      binding: ProjectBinding(),
      
    ),];
}

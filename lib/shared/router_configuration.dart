import 'package:archethic_api_test/routes/home_page/home_page.dart';
import 'package:archethic_api_test/routes/nodes_list/nodes_list.dart';
import 'package:archethic_api_test/routes/token_price/token_price.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
class CustomRouter extends GoRouter {
  CustomRouter()
      : super(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(title: 'Home Page'),
            ),
            GoRoute(
              path: '/uco-price',
              builder: (context, state) =>
                  const TokenPricePage(title: 'UCO Token price page'),
            ),
            GoRoute(
              path: '/nodes-list',
              builder: (context, state) =>
                  const NodesListPage(title: 'Archethics nodes list'),
            ),
          ],
        );
}

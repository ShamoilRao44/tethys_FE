
import 'package:tethys/modules/gatekeeper/gatekeeper_model.dart';

abstract class GateKeepRepo {
  Future<OrdersList> getOrders();
}

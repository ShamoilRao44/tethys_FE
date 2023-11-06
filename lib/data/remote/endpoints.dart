class Endpoints {
  static const login = 'login';
  static const otp = 'otp/send';

  static const owner = 'owner/';
  static const create = 'create';

  static const request = "requests/";
  static const permit = "permit";
  static const delete = "delete";

  static const employee = 'employees/';

  static const getItemsList = 'material/';

  static const sendRequestforItems = 'pmanager/create';
  static const getReqListForPmngr = 'pmanager/id';
  static const returnMaterial = 'pmanager/return/create';

  static const getReqListForSmngr = 'smanager/reqs';
  static const getReturnsList = 'smanager/return/reqs';
  static const sendOrder = 'smanager/orders/create';
  static const issueSlot = 'smanager/reqs/issue/slot';

  static const getOrderList = 'gkeep/';
  static const verifyOrders = 'gkeep/orders/check';
}

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

  static const getPmInventory = 'pmanager/';
  static const sendRequestforItems = 'pmanager/create';
  static const getReqListForPmngr = 'pmanager/id';
  static const returnMaterial = 'pmanager/return/create';
  static const getReturnsForPmngr = 'pmanager/return/id';

  static const getInventory = 'smanager/';
  static const getReqListForSmngr = 'smanager/reqs';
  static const issueSlot = 'smanager/reqs/issue/slot';
  static const denyRequest = 'smanager/reqs/deny/slot';
  static const getReturnsList = 'smanager/return/reqs';
  static const approveReturn = 'smanager/return/reqs/allow';
  static const denyReturns = 'smanager/return/reqs/deny';
  static const sendOrder = 'smanager/orders/create';

  static const getOrderList = 'gkeep/';
  static const verifyOrders = 'gkeep/orders/check';
}

class StaffInfo {
  static String setUpRoleName(int role) {
    var roleName = "";
    switch (role) {
      case 0:
        roleName = "Manager";
        break;
      case 1:
        roleName = "Accountant";
        break;
      case 2:
        roleName = "Receiptist";
        break;
      case 3:
        roleName = "Chef";
        break;
      case 4:
        roleName = "Inventory";
        break;
      case 5:
        roleName = "Waiter";
        break;
      default:
        roleName = "";
    }
    return roleName;
  }
}

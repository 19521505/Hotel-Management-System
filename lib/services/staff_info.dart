class StaffInfo {
  static String setUpRoleName(int role) {
    var roleName = "";
    switch (role) {
      case 1:
        roleName = "Manager";
        break;
      case 2:
        roleName = "Accountant";
        break;
      case 3:
        roleName = "Receptiontist";
        break;
      case 4:
        roleName = "Kitchen";
        break;
      case 5:
        roleName = "Warehouse";
        break;
      case 6:
        roleName = "Waiter";
        break;
      default:
        roleName = "";
    }
    return roleName;
  }
}

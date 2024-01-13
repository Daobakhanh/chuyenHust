class AppFunctionTerm {
  static const device = "Thiết Bị";
  static const reportError = "Báo Hỏng";
  static const department = "Khoa Phòng";
  static const employee = "Nhân Viên";
  static const statistic = "Thống Kê";
  static const inventory = "Kiểm Kê";
}

class AppLoginTerm {
  static const needLoginFirst = 'Cần đăng nhập bằng tài khoản trước';
  static const unavailableBiometrics = 'Thiết bị không hỗ trợ';
  static const emptyFingerPrint = 'Vân tay không tồn tại';
  static const email = "Email";
  static const password = "Mật khẩu";
  static const requireEmail = "Nhập email";
  static const requirePassword = "Nhập mật khẩu";
  static const corectEmail = "Nhập email hợp lệ";
  static const corectPassword = "Mật khẩu phải dài hơn 6 ký tự";
  static const notConnectivityWifi = "Lỗi kết nối mạng";
  static const incorrectEmailAndPassword =
      "Tài khoản hoặc mật khẩu không chính xác";
  static const apiError = "Lỗi đăng nhập";
}

class AppLoadDataTerm {
  static const errorLoad = 'Lỗi tải dữ liệu';
  static const reload = "Tải lại";
  static const clickToShow = 'Ấn vào để xem chi tiết';
}

class DialogTitle {
  static const error = 'Đã xảy ra lỗi';
  static const warning = 'Lưu ý';
  static const success = 'Thành công';
}

class AppLogoutTerm {
  static const logoutError = 'Đăng xuất thất bại';
}

Map<String, String> statusDeviceObject = {
  'all': 'Tất cả',
  'active': "Đang sử dụng",
  'inactive': 'Ngưng sử dụng',
  'corrected': 'Đang sửa chữa',
  'was_broken': 'Đang báo hỏng',
  'liquidated': 'Ngưng sử dụng',
  'not_handed': 'Mới'
};

class AppDepartmentTerm {
  static const allNameDepartment = "Tất cả";
  static const hintTextLookForm = 'Tên khoa phòng';
  static const clickToShow = 'Ấn vào để xem chi tiết';
  static const reload = 'Tải lại';
  static const emptyDepartment = 'Không có khoa phòng nào';
  static const errorDirect = 'Lỗi điều hướng';
}

class AppDeviceTerm {
  static const hintTextLookForm = 'Tên thiết bị,mã thiết bị,..';
  static const clickToShow = 'Ấn vào để xem chi tiết';
  static List listStatus = statusDeviceObject.values.toList();
  static const emptyDevice = "Không có thiết bị nào";
}

class AppDetailDeviceTerm {
  static const historyReportError = 'Lịch sử báo hỏng thiết bị';
  static const showHistoryReportError = 'Xem lịch sử báo hỏng thiết bị';
  static const historyInventory = 'Lịch sử kiểm kê thiết bị';
  static const showHistoryInventory = 'Xem lịch sử kiểm kê thiết bị';
  static const inventory = 'Kiểm Kê';
  static const reportError = 'Báo Hỏng';
  static const dateFailure = 'Ngày báo hỏng:';
  static const statusRepair = 'Trạng thái sửa chữa';
  static const none = 'Không có dữ liệu';
  static const dateInventory = 'Ngày kiểm kê:';
  static const noteInventory = 'Ghi chú:';
  static const noneNote = 'Không có ghi chú';
  static const userInventory = 'Người kiểm kê:';
  static const yearUse = "Năm sử dụng:";
  static const yearManfacture = "Năm sản xuất:";
  static const manufacturer = "Hãng sản xuất:";
  static const origin = "Xuất xứ:";
  static const model = "Model:";
  static const serial = "Serial:";
  static const nameDevice = "Tên thiết bị:";
  static const nameDepartment = "Khoa phòng:";
  static const status = "Trạng thái:";
}

class AppEmployeeTerm {
  static const hintTextLookForm = 'Tên nhân viên,email,SĐT,...';
  static const clickToShow = 'Bấm vào thông tin nhân viên để liên lạc';
  static const emptyEmployee = 'Không có nhân viên nào';
}

class AppReportErrorTerm {
  static const errorFailed = 'Báo hỏng thất bại';
  static const reasonError = 'Nhập lí do báo hỏng tại đây';
  static const hintTextLookForm = 'Tên/mã thiết bị còn hoạt động...';
}

class AppCreateInventoryTerm {
  static const createInventoryFailed = "Kiểm kê thất bại";
  static const note = "Nhập ghi chú kiểm kê";
}

class AppNotificationTerm {
  static const emptyNotification = "Không có thông báo";
}

class AppTitleTerm {
  static const webLink = "https://bvdemo.qltbyt.com";
  static const appName = "Quản Lý Thiết Bị Y Tế";
}

class AppSettingTerm {
  static const fingerPrintSuccess = "Xác thực thành công";
  static const fingerPrintFaild = "Xác thực thất bại";
  static const fingerPrintConfirm = "Bạn có xác nhận tắt xác thực vân tay \n\n"
      "Sau khi tắt xác thực và rời khỏi đây,bạn cần đăng nhập lại để lưu vân tay";
  static const savePasswordSuccess = "Lưu mật khẩu thành công";
  static const savePasswordConfirm = "Bạn có xác nhận tắt lưu mật khẩu \n\n"
      "Sau khi tắt lưu mật khẩu và rời khỏi đây,bạn cần đăng nhập lại để lưu mật khẩu";
}

class AppStatisticTerm {
  static const nameChart = 'Biểu đồ thống kê số lượng thiết bị hỏng';
}

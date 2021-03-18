class FormTextField {
  String hint;
  String validator;

  FormTextField({this.hint, this.validator});
}

final textFieldVaksinasiList = [
  FormTextField(
    hint: 'Vaksinasi Ke-?',
    validator: 'Silahkan input data',
  ),
  FormTextField(
    hint: 'Tanggal Registrasi Vaksinasi',
    validator: 'Silahkan input tanggal',
  ),
  FormTextField(
    hint: 'Tanggal Vaksinasi',
    validator: 'Silahkan input tanggal',
  ),
  FormTextField(
    hint: 'Penyelenggara',
    validator: 'Silahkan input penyelenggara',
  ),
  FormTextField(
    hint: 'Alamat Vaksinasi',
    validator: 'Silahkan input alamat vaksinasi',
  )
];

final textFieldCutiList = [
  FormTextField(
    hint: 'Alasan Cuti',
    validator: 'Silahkan input alasan cuti',
  ),
  FormTextField(
    hint: 'Alamat selama menjalankan cuti',
    validator: 'Silahkan input alamat cuti',
  ),
  FormTextField(
    hint: 'Tanggal mulai cuti',
    validator: 'Silahkan input tanggal',
  ),
  FormTextField(
    hint: 'Tanggal terakhir cuti',
    validator: 'Silahkan input tanggal',
  ),
  FormTextField(
    hint: 'Nomor Telpon',
    validator: 'Silahkan input nomor telpon',
  ),
  FormTextField(
    hint: 'Lama Cuti',
    validator: 'Silahkan input lama cuti',
  )
];

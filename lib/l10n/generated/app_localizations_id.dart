// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get nav_home => 'Beranda';

  @override
  String get nav_task => 'Tugas';

  @override
  String get nav_search => 'Cari';

  @override
  String get nav_notif => 'Notifikasi';

  @override
  String get nav_settings => 'Pengaturan';

  @override
  String get onboarding_page1_title => 'Semua tugasmu, dalam satu tempat.';

  @override
  String get onboarding_page1_subtitle =>
      'Kelola to-do list, proyek, dan ide tanpa ribet. Fokus pada yang penting.';

  @override
  String get onboarding_page1_button => 'Lanjut';

  @override
  String get onboarding_page2_title => 'Kerja bareng, tanpa drama.';

  @override
  String get onboarding_page2_subtitle =>
      'Buat, bagi, dan pantau tugas bersama tim — semua transparan dan efisien.';

  @override
  String get onboarding_page2_button => 'Lanjut';

  @override
  String get onboarding_page3_title => 'Produktif tanpa stres.';

  @override
  String get onboarding_page3_subtitle =>
      'Pantau progres, rayakan pencapaian, dan nikmati hasil kerja yang tertata.';

  @override
  String get onboarding_page3_button => 'Mulai Sekarang';

  @override
  String get login_title => 'Masuk ke 2Gas';

  @override
  String get login_subtitle => 'Kelola tugasmu dengan lebih mudah dan terarah.';

  @override
  String get login_button_google => 'Lanjut dengan Google';

  @override
  String get good_morning => 'Selamat pagi';

  @override
  String get good_afternoon => 'Selamat siang';

  @override
  String get good_evening => 'Selamat sore';

  @override
  String get good_night => 'Selamat malam';

  @override
  String taskCreated(Object project, Object task, Object user) {
    return '$user membuat task $task di project $project';
  }

  @override
  String taskUpdated(Object task, Object user) {
    return '$user memperbarui task $task';
  }

  @override
  String taskDeleted(Object task, Object user) {
    return '$user menghapus task $task';
  }

  @override
  String taskCompleted(Object task, Object user) {
    return '$user menyelesaikan task $task';
  }

  @override
  String taskReopened(Object task, Object user) {
    return '$user membuka kembali task $task';
  }

  @override
  String taskAssigned(Object assignee, Object task, Object user) {
    return '$user menugaskan task $task ke $assignee';
  }

  @override
  String taskUnassigned(Object task, Object user) {
    return '$user melepas penugasan dari task $task';
  }

  @override
  String taskMoved(Object column, Object task, Object user) {
    return '$user memindahkan task $task ke kolom $column';
  }

  @override
  String taskCommented(Object task, Object user) {
    return '$user berkomentar pada task $task';
  }

  @override
  String taskAttachmentAdded(Object task, Object user) {
    return '$user menambahkan lampiran ke task $task';
  }

  @override
  String taskAttachmentRemoved(Object task, Object user) {
    return '$user menghapus lampiran dari task $task';
  }

  @override
  String taskLabelAdded(Object label, Object task, Object user) {
    return '$user menambahkan label $label pada task $task';
  }

  @override
  String taskLabelRemoved(Object label, Object task, Object user) {
    return '$user menghapus label $label dari task $task';
  }

  @override
  String projectCreated(Object project, Object user) {
    return '$user membuat project $project';
  }

  @override
  String projectUpdated(Object project, Object user) {
    return '$user memperbarui project $project';
  }

  @override
  String projectDeleted(Object project, Object user) {
    return '$user menghapus project $project';
  }

  @override
  String projectArchived(Object project, Object user) {
    return '$user mengarsipkan project $project';
  }

  @override
  String projectRestored(Object project, Object user) {
    return '$user memulihkan project $project';
  }

  @override
  String memberInvited(Object org, Object target, Object user) {
    return '$user mengundang $target ke $org';
  }

  @override
  String memberJoined(Object org, Object user) {
    return '$user bergabung ke $org';
  }

  @override
  String memberRemoved(Object org, Object target, Object user) {
    return '$user menghapus $target dari $org';
  }

  @override
  String memberRoleUpdated(Object role, Object target, Object user) {
    return '$user memperbarui peran $target menjadi $role';
  }

  @override
  String organizationCreated(Object org, Object user) {
    return '$user membuat organisasi baru $org';
  }

  @override
  String organizationUpdated(Object org, Object user) {
    return '$user memperbarui profil organisasi $org';
  }

  @override
  String organizationDeleted(Object org, Object user) {
    return '$user menghapus organisasi $org';
  }

  @override
  String organizationJoined(Object org, Object user) {
    return '$user bergabung ke organisasi $org';
  }

  @override
  String organizationLeft(Object org, Object user) {
    return '$user keluar dari organisasi $org';
  }

  @override
  String commentAdded(Object user) {
    return '$user menambahkan komentar';
  }

  @override
  String commentEdited(Object user) {
    return '$user memperbarui komentar';
  }

  @override
  String commentDeleted(Object user) {
    return '$user menghapus komentar';
  }

  @override
  String attachmentAdded(Object file, Object user) {
    return '$user menambahkan lampiran $file';
  }

  @override
  String attachmentRemoved(Object file, Object user) {
    return '$user menghapus lampiran $file';
  }

  @override
  String labelCreated(Object label, Object user) {
    return '$user membuat label baru $label';
  }

  @override
  String labelUpdated(Object label, Object user) {
    return '$user memperbarui label $label';
  }

  @override
  String labelDeleted(Object label, Object user) {
    return '$user menghapus label $label';
  }

  @override
  String get field_title => 'Judul';

  @override
  String get field_title_hint => 'Masukkan judul';

  @override
  String get field_description => 'Deskripsi';

  @override
  String get field_description_hint => 'Masukkan deskripsi';

  @override
  String get field_address => 'Alamat';

  @override
  String get field_address_hint => 'Masukkan alamat';

  @override
  String get field_email_hint => 'Masukkan email Anda';

  @override
  String get field_category => 'Kategori';

  @override
  String get field_category_msg_required => 'Kategori wajib dipilih.';

  @override
  String get field_categoory_delete_title => 'Hapus Kategori';

  @override
  String get field_categoory_delete_message =>
      'Yakin ingin menghapus kategori ini?';

  @override
  String get yes => 'Ya';

  @override
  String get no => 'Tidak';

  @override
  String get cancel => 'Batal';

  @override
  String get close => 'Tutup';

  @override
  String get field_priority => 'Prioritas';

  @override
  String get field_priority_hint => 'Pilih tingkat prioritas';

  @override
  String get field_assigns => 'Penerima Tugas';

  @override
  String get select_members => 'Pilih anggota';

  @override
  String get nav_overview => 'Ikhtisar';

  @override
  String get nav_project => 'Proyek';

  @override
  String get nav_schedule => 'Jadwal';

  @override
  String get nav_activity => 'Aktivitas';

  @override
  String get all_members => 'Semua Anggota';

  @override
  String get active_member => 'Anggota Aktif';

  @override
  String get pending_member => 'Anggota Tertunda';

  @override
  String get dialog_acc_member_title => 'Terima Anggota';

  @override
  String get dialog_acc_member_content => 'Terima anggota ini?';

  @override
  String get accept => 'Terima';

  @override
  String get decline => 'Tolak';

  @override
  String get activity_org => 'Aktivitas Organisasi';

  @override
  String get member => 'Anggota';

  @override
  String get today_schedule => 'Jadwal Hari Ini';

  @override
  String get project_summary => 'Ringkasan Proyek';

  @override
  String get active => 'Aktif';

  @override
  String get completed => 'Selesai';

  @override
  String get overdue => 'Terlambat';

  @override
  String get task_summary => 'Ringkasan Tugas';

  @override
  String get latest_activity => 'Aktivitas Terbaru';

  @override
  String get msg_success_create_project => 'Proyek berhasil dibuat';

  @override
  String get search_project => 'Cari proyek';

  @override
  String get back_to_home => 'Kembali ke Beranda';

  @override
  String get msg_success_create_task => 'Tugas berhasil dibuat';

  @override
  String get setting_project => 'Pengaturan Proyek';

  @override
  String get change_prioriy => 'Ubah Prioritas';

  @override
  String get select_priority => 'Pilih Prioritas';

  @override
  String get change_deadline => 'Ubat Tenggat Waktu';

  @override
  String get delete_project => 'Hapus Proyek';

  @override
  String get assign => 'Tugaskan';

  @override
  String get org_member_list => 'Daftar Anggota Organisasi';

  @override
  String get dialog_list_assign_project_title => 'Tugaskan Proyek';

  @override
  String get dialog_list_assign_project_context =>
      'Pilih anggota untuk ditugaskan pada proyek ini';

  @override
  String get creator => 'Pembuat';

  @override
  String get priority => 'Prioritas';

  @override
  String get deadline => 'Tenggat waktu';

  @override
  String get categories => 'Kategori';

  @override
  String get project_info => 'Info Proyek';

  @override
  String get created_by => 'Dibuat oleh';

  @override
  String get created_at => 'Dibuat pada';

  @override
  String get description => 'Deskripsi';

  @override
  String get task => 'Tugas';

  @override
  String get no_description => 'Tidak ada deskripsi';

  @override
  String get see_all => 'Lihat Semua';

  @override
  String get msg_task_empty => 'Belum ada tugas';

  @override
  String get msg_cannot_change_data => 'Anda tidak bisa mengubah data';

  @override
  String get create_project => 'Buat Proyek';

  @override
  String get submit => 'Kirim';

  @override
  String get select_category => 'Pilih Kategori';

  @override
  String get pending_approval => 'Menunggu Persetujuan';

  @override
  String get category_has_been_added => 'Kategori telah ditambahkan';

  @override
  String overdue_by(Object day) {
    return 'Terlambat $day hari';
  }

  @override
  String overdue_in(Object day) {
    return 'Jatuh tempo dalam $day hari';
  }

  @override
  String get please_wait => 'Mohon tunggu';

  @override
  String get my_org => 'Organisasi Saya';

  @override
  String get create_org => 'Buat Organisasi';

  @override
  String get join_org => 'Gabung Organisasi';

  @override
  String get add_org => 'Tambah Organisasi';

  @override
  String get joined => 'Bergabung';

  @override
  String get join => 'Gabung';

  @override
  String get wait_for_approval => 'Tunggu persetujuan dahulu';

  @override
  String get color_org => 'Warna Organisasi';

  @override
  String get change_color => 'Ubah Warna';

  @override
  String get org => 'Organisasi';

  @override
  String get create_task => 'Buat Tugas';

  @override
  String notif_org_access_request_approved(String orgName) {
    return 'Anda telah disetujui bergabung dengan $orgName.';
  }

  @override
  String notif_org_user_joined(String userName, String orgName) {
    return '$userName telah bergabung dengan organisasi $orgName.';
  }

  @override
  String notif_org_role_changed_to_admin(String orgName) {
    return 'Anda telah dijadikan admin di organisasi $orgName.';
  }

  @override
  String notif_org_user_removed(String orgName) {
    return 'Anda telah dikeluarkan dari organisasi $orgName.';
  }

  @override
  String notif_project_user_added(String projectName) {
    return 'Anda telah ditambahkan ke proyek $projectName.';
  }

  @override
  String notif_project_user_removed(String projectName) {
    return 'Anda telah dikeluarkan dari proyek $projectName.';
  }

  @override
  String notif_project_data_updated(String projectName) {
    return 'Data proyek $projectName telah diperbarui.';
  }

  @override
  String notif_task_assigned(String taskName, String projectName) {
    return 'Anda mendapat tugas baru: $taskName di proyek $projectName.';
  }

  @override
  String notif_task_user_unassigned(String taskName) {
    return 'Anda dikeluarkan dari tugas $taskName.';
  }

  @override
  String notif_task_updated(String taskName) {
    return 'Tugas $taskName telah diperbarui.';
  }

  @override
  String get task_done => 'Selesai';

  @override
  String get task_in_progress => 'Dalam Proses';

  @override
  String get task_not_started => 'Belum Dimulai';

  @override
  String get all => 'Semua';

  @override
  String get logout => 'Keluar';

  @override
  String get msg_logout_title => 'Konfirmasi Keluar';

  @override
  String get msg_logout_content => 'Yakin ingin keluar?';

  @override
  String get owner => 'Pemilik';

  @override
  String get theme => 'Tema';

  @override
  String get dark_mode => 'Mode Gelap';

  @override
  String get light_mode => 'Mode Terang';

  @override
  String get language => 'Bahasa';

  @override
  String overdue_by_day(int day) {
    return 'Terlambat $day hari';
  }

  @override
  String get due_tomorrow => 'Besok deadline';

  @override
  String due_in_days(int day) {
    return '$day hari lagi';
  }
}

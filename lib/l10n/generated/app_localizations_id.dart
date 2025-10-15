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
}

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Akun Pengurus Desa - My Pandak</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/pengurusdesa/formregistrasipengurus_pengurusdesa.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="logo-section">
            <div class="logo-icon">
                <img src="/assets/icons/mypandak.png" alt="Logo My Pandak" width="45" height="45">
            </div>
            <div class="logo-text">
                <h1 class="main-title"><span>My</span> Pandak</h1>
                <p class="subtitle">Sistem Pendataan Warga</p>
            </div>
        </div>
        
        <div class="user-section">
            <div class="user-info">
                <span class="user-name">Indah</span>
                <span class="user-role">Pengurus Desa</span>
            </div>
            <div class="user-avatar">
                <img src="/assets/icons/user-avatar.svg" alt="User Avatar" class="avatar-img">
            </div>
        </div>
    </header>

    <!-- Main Container -->
    <div class="main-wrapper">
        <!-- Sidebar -->
        <aside class="sidebar">
            <nav class="sidebar-nav">
                <a href="dashboard_pengurusdesa" class="nav-item">
                    <img src="/assets/icons/dashboard.svg" alt="Dashboard" class="nav-icon">
                    <span>Dashboard</span>
                </a>
                
                <a href="datawarga_pengurusdesa" class="nav-item">
                    <img src="/assets/icons/data-warga.svg" alt="Data Warga" class="nav-icon">
                    <span>Data Warga</span>
                </a>
                
                <a href="datakeluarga_pengurusdesa" class="nav-item">
                    <img src="/assets/icons/data-keluarga.svg" alt="Data Keluarga" class="nav-icon">
                    <span>Data Keluarga</span>
                </a>
                
                <a href="catatankeluarga_pengurusdesa" class="nav-item">
                    <img src="/assets/icons/catatan-keluarga.svg" alt="Catatan Keluarga" class="nav-icon">
                    <span>Catatan Keluarga</span>
                </a>
                
                <a href="registrasi_pengurusdesa" class="nav-item active">
                    <img src="/assets/icons/registrasi-akun.svg" alt="Registrasi Akun" class="nav-icon">
                    <span>Registrasi Akun</span>
                </a>
                
                <a href="pengaturan_pengurusdesa" class="nav-item">
                    <img src="/assets/icons/pengaturan.svg" alt="Pengaturan" class="nav-icon">
                    <span>Pengaturan</span>
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Page Header with Back Button -->
            <div class="page-header">
                <button class="btn-back" id="backButton" style="background: none; border: none; cursor: pointer; color: #1e293b;">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
                <div class="header-content">
                    <h2 class="page-title">Tambah Akun Pengurus Desa</h2>
                </div>
            </div>

            <!-- Form Container -->
            <div class="form-container">
                <form class="registration-form" id="registrationForm">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="namaLengkap">Nama Lengkap <span class="required">*</span></label>
                            <input type="text" id="namaLengkap" name="namaLengkap" required placeholder="Masukan Nama Lengkap">
                        </div>

                        <div class="form-group">
                            <label for="namaPanggilan">Nama Panggilan (untuk username akun) <span class="required">*</span></label>
                            <input type="text" id="namaPanggilan" name="namaPanggilan" required placeholder="Masukan Nama Panggilan">
                        </div>

                        <div class="form-group">
                            <label for="desaMawar">Desa Mawar <span class="required">*</span></label>
                            <input type="text" id="desaMawar" name="desaMawar" required placeholder="Masukan Desa Mawar">
                        </div>

                        <div class="form-group">
                            <label for="noTelepon">No. Telepon <span class="required">*</span></label>
                            <input type="tel" id="noTelepon" name="noTelepon" required placeholder="Masukan No. Telepon">
                        </div>

                        <div class="form-group">
                            <label for="nik">Nomor Induk Keluarga (NIK) <span class="required">*</span></label>
                            <input type="text" id="nik" name="nik" required placeholder="Masukan NIK" maxlength="16">
                        </div>

                        <div class="form-group">
                            <label for="emailGoogle">Email Google <span class="required">*</span></label>
                            <input type="email" id="emailGoogle" name="emailGoogle" required placeholder="Masukan Email Google">
                        </div>

                        <div class="form-group">
                            <label for="password">Buat Password <span class="required">*</span></label>
                            <div class="password-input-wrapper">
                                <input type="password" id="password" name="password" required placeholder="Masukan Password 8 Karakter">
                                <button type="button" class="toggle-password" id="togglePassword">
                                    <img src="/assets/icons/eye_close.svg" alt="Toggle Password" id="eyeIcon">
                                </button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Konfirmasi Password <span class="required">*</span></label>
                            <div class="password-input-wrapper">
                                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Masukan Kembali Password 8 Karakter">
                                <button type="button" class="toggle-password" id="toggleConfirmPassword">
                                    <img src="/assets/icons/eye_close.svg" alt="Toggle Password" id="eyeIconConfirm">
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-submit">Buat Akun</button>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p class="footer-text">Dikelola oleh<br>Tim Developer My Pandak</p>
        <p class="footer-text copyright">© 2025 My Pandak. Semua hak cipta dilindungi.</p>
    </footer>

    <!-- Success Modal -->
    <div class="modal" id="successModal">
        <div class="modal-content">
            <div class="modal-icon success">
                <svg width="60" height="60" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M22 11.08V12C21.9988 14.1564 21.3005 16.2547 20.0093 17.9818C18.7182 19.7088 16.9033 20.9725 14.8354 21.5839C12.7674 22.1953 10.5573 22.1219 8.53447 21.3746C6.51168 20.6273 4.78465 19.2461 3.61096 17.4371C2.43727 15.628 1.87979 13.4881 2.02168 11.3363C2.16356 9.18455 2.99721 7.13631 4.39828 5.49706C5.79935 3.85781 7.69279 2.71537 9.79619 2.24013C11.8996 1.7649 14.1003 1.98232 16.07 2.85999" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M22 4L12 14.01L9 11.01" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <h3 class="modal-title">Registrasi Berhasil!</h3>
            <p class="modal-message">Akun pengurus desa telah berhasil didaftarkan ke sistem.</p>
            <button class="btn-modal-close" id="closeSuccessModal">Tutup</button>
        </div>
    </div>

    <script src="/js/pengurusdesa/formregistrasipengurus_pengurusdesa.js"></script>
</body>
</html>
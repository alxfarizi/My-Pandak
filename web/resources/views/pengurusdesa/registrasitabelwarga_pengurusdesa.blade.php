<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Akun Warga - My Pandak</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/pengurusdesa/registrasitabelwarga_pengurusdesa.css">
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
                <button class="btn-back" id="backToSelection" style="background: none; border: none; cursor: pointer; color: #1e293b;">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
                <div class="header-content">
                    <h2 class="page-title">Akun Warga</h2>
                    <p class="page-subtitle">Daftar akun warga yang telah terdaftar</p>
                </div>
            </div>

            <!-- Action Bar -->
            <div class="action-bar">
                <button class="btn-add" id="addAccountBtn">
                    <img src="/assets/icons/plus-icon.svg" alt="Tambah" class="btn-icon">
                    Tambah Akun
                </button>
                
                <div class="search-box">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M21 21L15 15M17 10C17 13.866 13.866 17 10 17C6.13401 17 3 13.866 3 10C3 6.13401 6.13401 3 10 3C13.866 3 17 6.13401 17 10Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <input type="text" id="searchInput" placeholder="Cari nama warga atau desa wisma...">
                </div>
            </div>

            <!-- Table Container -->
            <div class="table-container">
                <table class="data-table" id="wargaTable">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Desa Wisma</th>
                            <th>Nama Pengurus</th>
                            <th>No Registrasi</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <!-- Data will be populated by JavaScript -->
                    </tbody>
                </table>
                
                <!-- Empty State -->
                <div class="empty-state" id="emptyState" style="display: none;">
                    <svg width="120" height="120" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M20 21V19C20 17.9391 19.5786 16.9217 18.8284 16.1716C18.0783 15.4214 17.0609 15 16 15H8C6.93913 15 5.92172 15.4214 5.17157 16.1716C4.42143 16.9217 4 17.9391 4 19V21M16 7C16 9.20914 14.2091 11 12 11C9.79086 11 8 9.20914 8 7C8 4.79086 9.79086 3 12 3C14.2091 3 16 4.79086 16 7Z" stroke="#cbd5e1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <p>Belum ada data warga</p>
                    <button class="btn-add-empty" id="addAccountBtnEmpty">Tambah Akun Pertama</button>
                </div>
            </div>

            <!-- Pagination -->
            <div class="pagination" id="pagination">
                <button class="pagination-btn" id="prevBtn" disabled>
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M15 18L9 12L15 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    Sebelumnya
                </button>
                
                <div class="pagination-info" id="paginationInfo">
                    Halaman 1 dari 1
                </div>
                
                <button class="pagination-btn" id="nextBtn" disabled>
                    Selanjutnya
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M9 18L15 12L9 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
            </div>
        </main>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p class="footer-text">Dikelola oleh<br>Tim Developer My Pandak</p>
        <p class="footer-text copyright">© 2025 My Pandak. Semua hak cipta dilindungi.</p>
    </footer>

    <!-- Detail Modal -->
    <div class="modal" id="detailModal">
        <div class="modal-content modal-detail">
            <div class="modal-header">
                <h3 class="modal-title">Detail Warga</h3>
                <button class="modal-close" id="closeDetailModal">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
            </div>
            <div class="modal-body" id="detailModalBody">
                <!-- Details will be populated by JavaScript -->
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal" id="deleteModal">
        <div class="modal-content modal-delete">
            <div class="modal-icon warning">
                <svg width="60" height="60" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 9V13M12 17H12.01M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <h3 class="modal-title">Hapus Akun?</h3>
            <p class="modal-message">Apakah Anda yakin ingin menghapus akun ini? Tindakan ini tidak dapat dibatalkan.</p>
            <div class="modal-actions">
                <button class="btn-cancel" id="cancelDeleteBtn">Batal</button>
                <button class="btn-delete" id="confirmDeleteBtn">Hapus Akun</button>
            </div>
        </div>
    </div>

    <!-- Registration Form Modal -->
    <div class="modal" id="registrationModal">
        <div class="modal-content modal-form">
            <div class="modal-header">
                <h3 class="modal-title">Tambah Akun Warga</h3>
                <button class="modal-close" id="closeRegistrationModal">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
            </div>
            <div class="modal-body">
                <form class="registration-form" id="registrationForm">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="namaLengkap">Nama Lengkap <span class="required">*</span></label>
                            <input type="text" id="namaLengkap" name="namaLengkap" required placeholder="Masukkan nama lengkap">
                        </div>

                        <div class="form-group">
                            <label for="nik">NIK <span class="required">*</span></label>
                            <input type="text" id="nik" name="nik" required placeholder="Masukkan NIK 16 digit" maxlength="16">
                        </div>

                        <div class="form-group">
                            <label for="email">Email <span class="required">*</span></label>
                            <input type="email" id="email" name="email" required placeholder="contoh@email.com">
                        </div>

                        <div class="form-group">
                            <label for="noTelepon">No. Telepon <span class="required">*</span></label>
                            <input type="tel" id="noTelepon" name="noTelepon" required placeholder="08xxxxxxxxxx">
                        </div>

                        <div class="form-group">
                            <label for="desaWisma">Desa Wisma <span class="required">*</span></label>
                            <select id="desaWisma" name="desaWisma" required>
                                <option value="">Pilih Desa Wisma</option>
                                <option value="Mawar 1">Mawar 1</option>
                                <option value="Mawar 2">Mawar 2</option>
                                <option value="Mawar 3">Mawar 3</option>
                            </select>
                        </div>

                        <div class="form-group full-width">
                            <label for="alamat">Alamat Lengkap <span class="required">*</span></label>
                            <textarea id="alamat" name="alamat" rows="3" placeholder="Masukan alamat lengkap" required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="password">Password <span class="required">*</span></label>
                            <div class="password-input-wrapper">
                                <input type="password" id="password" name="password" required placeholder="Minimal 8 karakter">
                                <button type="button" class="toggle-password" id="togglePassword">
                                    <img src="/assets/icons/eye_close.svg" alt="Toggle Password" id="eyeIcon">
                                </button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Konfirmasi Password <span class="required">*</span></label>
                            <div class="password-input-wrapper">
                                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Masukan ulang password">
                                <button type="button" class="toggle-password" id="toggleConfirmPassword">
                                    <img src="/assets/icons/eye_close.svg" alt="Toggle Password" id="eyeIconConfirm">
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn-secondary" id="cancelFormBtn">Batal</button>
                        <button type="submit" class="btn-primary">Daftarkan Akun</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

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
            <p class="modal-message">Akun warga telah berhasil didaftarkan ke sistem.</p>
            <button class="btn-modal-close" id="closeSuccessModal">Tutup</button>
        </div>
    </div>

    <script src="/js/pengurusdesa/registrasitabelwarga_pengurusdesa.js"></script>
</body>
</html>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pengaturan - My Pandak</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/pengurusdesa/dashboard_pengurusdesa.css">
    <style>
        .settings-container {
            /* padding: 40px; - Removed to match Data Warga spacing */
            max-width: 100%;
        }

        /* Profile Card */
        .profile-card {
            background: #1a3669;
            border-radius: 16px;
            padding: 32px;
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 40px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .profile-avatar svg {
            width: 48px;
            height: 48px;
        }

        .profile-info h3 {
            color: #ffffff;
            font-size: 24px;
            font-weight: 600;
            margin: 0 0 8px 0;
        }

        .profile-info p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 16px;
            margin: 0;
        }

        /* Menu List */
        .settings-menu {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .menu-item {
            background: #ffffff;
            border-radius: 16px;
            padding: 24px 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid transparent;
        }

        .menu-item:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
            border-color: #e2e8f0;
        }

        .menu-content {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .menu-icon {
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f1f5f9;
            border-radius: 8px;
            padding: 8px;
        }
        
        .menu-icon svg {
            width: 24px;
            height: 24px;
        }

        .menu-text {
            color: #1e293b;
            font-size: 18px;
            font-weight: 500;
        }

        .menu-arrow svg {
            width: 24px;
            height: 24px;
            color: #94a3b8;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal.show {
            display: flex;
        }

        .modal-content {
            background: white;
            padding: 24px;
            border-radius: 12px;
            width: 90%;
            max-width: 400px;
            animation: slideIn 0.3s ease;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 18px;
            font-weight: 600;
            color: #1e293b;
            margin: 0;
        }

        .close-modal {
            background: none;
            border: none;
            cursor: pointer;
            color: #64748b;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #64748b;
        }

        .form-input {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
        }
        
        .form-input:disabled {
            background-color: #f1f5f9;
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background: #1a3669;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn-submit:hover {
            background: #132a52;
        }

        @keyframes slideIn {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        
        .password-wrapper {
            position: relative;
        }
        
        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            padding: 4px;
        }
    </style>
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
                <span class="user-name">Budi</span>
                <span class="user-role">Warga</span>
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
                <a href="dashboard_warga" class="nav-item">
                    <img src="/assets/icons/dashboard.svg" alt="Dashboard" class="nav-icon">
                    <span>Dashboard</span>
                </a>
                
                <a href="datawarga_warga" class="nav-item">
                    <img src="/assets/icons/data-warga.svg" alt="Data Warga" class="nav-icon">
                    <span>Data Warga</span>
                </a>
                
                <a href="datakeluarga_warga" class="nav-item">
                    <img src="/assets/icons/data-keluarga.svg" alt="Data Keluarga" class="nav-icon">
                    <span>Data Keluarga</span>
                </a>
                
                <a href="catatankeluarga_warga" class="nav-item">
                    <img src="/assets/icons/catatan-keluarga.svg" alt="Catatan Keluarga" class="nav-icon">
                    <span>Catatan Keluarga</span>
                </a>
                
                <a href="pengaturan_warga" class="nav-item active">
                    <img src="/assets/icons/pengaturan.svg" alt="Pengaturan" class="nav-icon">
                    <span>Pengaturan</span>
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="settings-container">
                <h2 style="margin-bottom: 32px; color: #1E293B; font-size: 32px; font-weight: 700;">Pengaturan Akun</h2>

                <!-- Profile Card -->
                <div class="profile-card">
                    <div class="profile-avatar">
                        <!-- Placeholder avatar icon -->
                        <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M20 21V19C20 17.9391 19.5786 16.9217 18.8284 16.1716C18.0783 15.4214 17.0609 15 16 15H8C6.93913 15 5.92172 15.4214 5.17157 16.1716C4.42143 16.9217 4 17.9391 4 19V21M16 7C16 9.20914 14.2091 11 12 11C9.79086 11 8 9.20914 8 7C8 4.79086 9.79086 3 12 3C14.2091 3 16 4.79086 16 7Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <div class="profile-info">
                        <h3>Budi</h3>
                        <p>NIK: 330220807060013</p>
                    </div>
                </div>

                <!-- Menu Items -->
                <div class="settings-menu">

                    <!-- Ubah Akun Google -->
                    <div class="menu-item" onclick="openModal('modalEmail')">
                        <div class="menu-content">
                            <div class="menu-icon">
                                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 4H20C21.1 4 22 4.9 22 6V18C22 19.1 21.1 20 20 20H4C2.9 20 2 19.1 2 18V6C2 4.9 2.9 4 4 4Z" stroke="#1e293b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M22 6L12 13L2 6" stroke="#1e293b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </div>
                            <span class="menu-text">Ubah Akun Google</span>
                        </div>
                        <div class="menu-arrow">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M9 18L15 12L9 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </div>
                    </div>

                    <!-- Ubah Kata Sandi -->
                    <div class="menu-item" onclick="openModal('modalPassword')">
                        <div class="menu-content">
                            <div class="menu-icon">
                                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 15V17M6 21H18C19.1046 21 20 20.1046 20 19V13C20 11.8954 19.1046 11 18 11H6C4.89543 11 4 11.8954 4 13V19C4 20.1046 4.89543 21 6 21ZM16 11V7C16 4.79086 14.2091 3 12 3C9.79086 3 8 4.79086 8 7V11H16Z" stroke="#1e293b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </div>
                            <span class="menu-text">Ubah Kata Sandi</span>
                        </div>
                        <div class="menu-arrow">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M9 18L15 12L9 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </div>
                    </div>

                    <!-- Keluar Akun -->
                    <div class="menu-item" onclick="confirmLogout()">
                        <div class="menu-content">
                            <div class="menu-icon">
                                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M9 21H5C4.44772 21 4 20.5523 4 20V4C4 3.44772 4.44772 3 5 3H9M16 17L21 12M21 12L16 7M21 12H9" stroke="#1e293b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </div>
                            <span class="menu-text">Keluar Akun</span>
                        </div>
                        <div class="menu-arrow">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M9 18L15 12L9 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Modals -->

    <!-- Modal Ubah Email -->
    <div class="modal" id="modalEmail">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Ubah Akun Google</h3>
                <button class="close-modal" onclick="closeModal('modalEmail')">✕</button>
            </div>
            <form id="formEmail">
                <div class="form-group">
                    <label class="form-label">Email Saat Ini</label>
                    <input type="email" class="form-input" value="budi@gmail.com" disabled>
                </div>
                <div class="form-group">
                    <label class="form-label">Email Google Baru</label>
                    <input type="email" class="form-input" id="newEmail" placeholder="Masukan email google baru" required>
                </div>
                <button type="submit" class="btn-submit">Simpan Perubahan</button>
            </form>
        </div>
    </div>

    <!-- Modal Ubah Password -->
    <div class="modal" id="modalPassword">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Ubah Kata Sandi</h3>
                <button class="close-modal" onclick="closeModal('modalPassword')">✕</button>
            </div>
            <form id="formPassword">
                <div class="form-group">
                    <label class="form-label">Password Lama</label>
                    <div class="password-wrapper">
                        <input type="password" class="form-input" id="oldPassword" placeholder="Masukan password lama" required>
                        <button type="button" class="toggle-password" onclick="togglePass('oldPassword')">
                            <img src="/assets/icons/eye_close.svg" alt="Toggle" id="icon-oldPassword">
                        </button>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Password Baru</label>
                    <div class="password-wrapper">
                        <input type="password" class="form-input" id="newPassword" placeholder="Masukan password baru" required>
                        <button type="button" class="toggle-password" onclick="togglePass('newPassword')">
                            <img src="/assets/icons/eye_close.svg" alt="Toggle" id="icon-newPassword">
                        </button>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Konfirmasi Password</label>
                    <div class="password-wrapper">
                        <input type="password" class="form-input" id="confirmNewPassword" placeholder="Konfirmasi password baru" required>
                        <button type="button" class="toggle-password" onclick="togglePass('confirmNewPassword')">
                            <img src="/assets/icons/eye_close.svg" alt="Toggle" id="icon-confirmNewPassword">
                        </button>
                    </div>
                </div>
                <button type="submit" class="btn-submit">Simpan Perubahan</button>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p class="footer-text">Dikelola oleh<br>Tim Developer My Pandak</p>
        <p class="footer-text copyright">© 2025 My Pandak. Semua hak cipta dilindungi.</p>
    </footer>

    <script src="/js/warga/pengaturan_warga.js"></script>
</body>
</html>
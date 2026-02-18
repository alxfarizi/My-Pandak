<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Pandak - Sistem Pendataan Warga</title>
    <!-- Poppins Font dari Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/pengurusdesa/login_pengurusdesa.css">
    <style>
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
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
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
            font-size: 20px;
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
            box-sizing: border-box;
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
    </style>
</head>
<body>
    <!-- Header yang rapi -->
    <header class="header">
        <!-- Ganti bagian ini di header -->
        <div class="logo-section">
            <div class="logo-icon">
                <!-- Ganti SVG dengan gambar lokal -->
                <img src="/assets/icons/mypandak.png" alt="Logo My Pandak" width="45" height="45">
            </div>
            <div class="logo-text">
                <h1 class="main-title"><span>My</span> Pandak</h1>
                <p class="subtitle">Sistem Pendataan Warga</p>
            </div>
        </div>
        
        <div class="help-section">
            <a href="javascript:void(0)" class="help-link" onclick="openModal('modalHelp')">Butuh Bantuan ?</a>
        </div>
    </header>

    <!-- Konten utama -->
    <main class="main-container">
        <!-- Bagian kiri: Branding -->
        <!-- Ganti bagian ini di brand-section -->
        <section class="brand-section">
            <!-- Ganti SVG dengan gambar lokal -->
            <img src="/assets/icons/mypandak.png" alt="Logo My Pandak" class="brand-logo">
            
            <h1 class="brand-title">
                <span class="my">My</span> <span class="pandak">Pandak</span>
            </h1>
            
            <p class="brand-tagline">
                Digitalisasi Desa Mulai dari My Pandak
            </p>
        </section>

        <!-- Bagian kanan: Login -->
        <section class="login-section">
            <div class="login-card">
                <h2 class="login-title">Masuk</h2>
                
                <!-- Tab Admin/Warga -->
                <div class="role-tabs">
                    <button class="role-tab active">Pengurus</button>
                    <button class="role-tab" onclick="window.location.href='/warga/login_warga'">Warga</button>
                </div>

                <!-- Form login -->
                <form id="loginForm">
                    <div class="input-group">
                        <label class="input-label" for="username">Email Admin</label>
                        <input type="text" id="username" class="input-field" placeholder="Email Admin" required>
                    </div>

                    <div class="input-group">
                        <label class="input-label" for="password">Password</label>
                        <div class="password-container">
                            <input type="password" id="password" class="input-field" placeholder="Masukkan password" required>
                            <button type="button" class="toggle-password" id="togglePassword">
                                <img id="eyeIcon" src="/assets/icons/eye_close.svg" alt="Toggle Password" class="eye-icon">
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="login-button">Masuk</button>

                    <a href="javascript:void(0)" class="forgot-password" onclick="openModal('modalForgotPassword')">Lupa Password?</a>

                    <!-- Divider -->
                    <div class="divider">
                        <span>Atau</span>
                    </div>

                    <!-- Tombol Google -->
                    <button type="button" class="google-button" id="googleLogin">
                        <svg class="google-icon" viewBox="0 0 24 24">
                            <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                            <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                            <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                            <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
                        </svg>
                        Masuk dengan Google
                    </button>
                </form>
            </div>
        </section>
    </main>

    <!-- Modal Bantuan -->
    <div class="modal" id="modalHelp">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Pusat Bantuan</h3>
                <button class="close-modal" onclick="closeModal('modalHelp')">✕</button>
            </div>
            <div style="text-align: center; color: #1e293b;">
                <p style="margin-bottom: 20px; line-height: 1.6;">
                    Jika Anda mengalami kendala teknis atau masalah akun pengurus, silakan hubungi tim IT atau Sekretariat Desa.
                </p>
                <div style="background: #f8fafc; padding: 16px; border-radius: 8px; margin-bottom: 20px;">
                    <p style="font-weight: 600; margin-bottom: 8px;">Kontak Dukungan Teknis:</p>
                    <p style="margin-bottom: 4px;">📞 WhatsApp: 0812-xxxx-xxxx</p>
                    <p style="margin-bottom: 4px;">📧 Email: it@pandak.desa.id</p>
                    <p>🏢 Kantor: Ruang IT Balai Desa Pandak</p>
                </div>
                <button class="btn-submit" onclick="closeModal('modalHelp')">Tutup</button>
            </div>
        </div>
    </div>

    <!-- Modal Lupa Password -->
    <div class="modal" id="modalForgotPassword">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Lupa Password</h3>
                <button class="close-modal" onclick="closeModal('modalForgotPassword')">✕</button>
            </div>
            <form id="formForgotPassword">
                <p style="font-size: 14px; color: #64748b; margin-bottom: 16px;">
                    Masukkan alamat email Google Anda yang terdaftar untuk menerima instruksi pengaturan ulang kata sandi.
                </p>
                <div class="form-group">
                    <label class="form-label">Email Google</label>
                    <input type="email" class="form-input" id="forgotEmail" placeholder="contoh: admin@gmail.com" required>
                </div>
                <button type="submit" class="btn-submit">Kirim Instruksi</button>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p class="footer-text">Dikelola oleh<br>Tim Developer My Pandak</p>
        <p class="footer-text copyright">© 2025 My Pandak. Semua hak cipta dilindungi.</p>
    </footer>

    <script src="/js/pengurusdesa/login_pengurusdesa.js"></script>
</body>
</html>
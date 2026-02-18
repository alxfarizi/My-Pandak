<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - My Pandak</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
    <link rel="stylesheet" href="/css/pengurusdesa/dashboard_pengurusdesa.css">
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
                <a href="dashboard_pengurusdesa" class="nav-item active">
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
                
                <a href="registrasi_pengurusdesa" class="nav-item">
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
            <!-- Hero Banner -->
            <div class="hero-banner">
                <img src="/assets/images/653e41bf56708.jpg" alt="Selamat Datang di My Pandak" class="hero-image">
                <div class="hero-overlay">
                    <h2 class="hero-title">Selamat Datang di<br>My Pandak</h2>
                </div>
            </div>

            <!-- Statistics Section -->
            <section class="statistics-section">
                <h2 class="section-title">Statistik Warga</h2>
                
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-content">
                            <span class="stat-label">Total Warga</span>
                            <span class="stat-value">1,234</span>
                        </div>
                        <div class="stat-icon">
                            <img src="/assets/icons/total-warga.svg" alt="Total Warga" class="stat-icon-img">
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-content">
                            <span class="stat-label">Kepala Keluarga</span>
                            <span class="stat-value">342</span>
                        </div>
                        <div class="stat-icon">
                            <img src="/assets/icons/kepala-keluarga.svg" alt="Kepala Keluarga" class="stat-icon-img">
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-content">
                            <span class="stat-label">Belum Menikah</span>
                            <span class="stat-value">234</span>
                        </div>
                        <div class="stat-icon">
                            <img src="/assets/icons/belum-menikah.svg" alt="Belum Menikah" class="stat-icon-img">
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-content">
                            <span class="stat-label">Anak-anak</span>
                            <span class="stat-value">456</span>
                        </div>
                        <div class="stat-icon">
                            <img src="/assets/icons/anak-anak.svg" alt="Anak-anak" class="stat-icon-img">
                        </div>
                    </div>
                </div>
            </section>

            <!-- Map Section -->
            <section class="map-section">
                <h2 class="section-title">Lokasi Desa</h2>
                <div id="map" style="height: 400px; width: 100%; border-radius: 12px; z-index: 1;"></div>
            </section>
        </main>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p class="footer-text">Dikelola oleh<br>Tim Developer My Pandak</p>
        <p class="footer-text copyright">© 2025 My Pandak. Semua hak cipta dilindungi.</p>
    </footer>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    <script src="/js/pengurusdesa/dashboard_pengurusdesa.js"></script>
</body>
</html>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Warga - My Pandak</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/pengurusdesa/datawarga_pengurusdesa.css">
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
                
                <a href="datawarga_warga" class="nav-item active">
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
                
                <a href="pengaturan_warga" class="nav-item">
                    <img src="/assets/icons/pengaturan.svg" alt="Pengaturan" class="nav-icon">
                    <span>Pengaturan</span>
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h2 class="page-title">Data Warga</h2>
            </div>

            <!-- Empty State -->
            <div class="empty-state" id="emptyState" style="display: none; text-align: center; padding: 40px;">
                <img src="/assets/icons/data-warga.svg" alt="No Data" style="width: 100px; height: 100px; margin-bottom: 20px; opacity: 0.5;">
                <h3 style="margin-bottom: 10px; color: #333;">Belum Ada Data Warga</h3>
                <p style="margin-bottom: 20px; color: #666;">Silakan tambahkan data warga terlebih dahulu untuk melihat tabel.</p>
                <a href="adddatawarga_warga" class="btn-add" style="display: inline-block; padding: 10px 20px; background-color: #4361EE; color: white; text-decoration: none; border-radius: 8px; font-weight: 500;">
                    <img src="/assets/icons/plus.svg" alt="Add" style="width: 20px; height: 20px; vertical-align: middle; margin-right: 5px;">
                    Tambah Data Warga
                </a>
            </div>

            <!-- Data Table -->
            <div class="table-container" id="tableContainer" style="display: none;">
                <div class="table-header-actions" style="margin-bottom: 15px; display: flex; justify-content: flex-end;">
                     <a href="adddatawarga_warga" class="btn-add" style="display: inline-block; padding: 10px 20px; background-color: #4361EE; color: white; text-decoration: none; border-radius: 8px; font-weight: 500;">
                        <img src="/assets/icons/plus.svg" alt="Add" style="width: 20px; height: 20px; vertical-align: middle; margin-right: 5px;">
                        Tambah Data
                    </a>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Desa Wisma</th>
                            <th>Nama Kepala Keluarga</th>
                            <th>No Registrasi</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <!-- Data will be populated here -->
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p class="footer-text">Dikelola oleh<br>Tim Developer My Pandak</p>
        <p class="footer-text copyright">© 2025 My Pandak. Semua hak cipta dilindungi.</p>
    </footer>

    <script src="/js/warga/datawarga_warga.js"></script>
</body>
</html>

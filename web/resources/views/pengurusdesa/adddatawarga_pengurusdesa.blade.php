<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Data Warga - My Pandak</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/pengurusdesa/adddatawarga_pengurusdesa.css">
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
                
                <a href="datawarga_pengurusdesa" class="nav-item active">
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
            <!-- Page Header with Back Button -->
            <div class="page-header">
                <button class="btn-back" onclick="goBack()">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
                <h2 class="page-title">Data Warga</h2>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <button class="btn-action btn-save active" id="btnSimpan">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M16.667 5L7.5 14.167L3.333 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    Simpan Data
                </button>
                <button class="btn-action btn-print" id="btnCetak">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M5 7V3h10v4M5 14H3V9h14v5h-2M5 14v4h10v-4H5z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    Cetak Data
                </button>
            </div>

            <!-- Form Container -->
            <div class="form-container">
                <form id="formDataWarga">
                    <!-- Kepala Keluarga Info -->
                    <div class="info-section">
                        <div class="info-row">
                            <label class="info-label">Desa Wisma</label>
                            <span class="info-separator">:</span>
                            <input type="text" class="info-value" id="desaWisma" placeholder="Masukan Desa Wisma">
                        </div>
                        <div class="info-row">
                            <label class="info-label">Nama Kepala</label>
                            <span class="info-separator">:</span>
                            <input type="text" class="info-value bold" id="namaKepala" placeholder="Masukan Nama Kepala Keluarga">
                        </div>
                    </div>

                    <!-- Rumah Tangga Section -->
                    <div class="section-title">Rumah Tangga</div>
                    
                    <div class="form-group">
                        <label class="form-label">1. No. Registrasi</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="noRegistrasi" placeholder="Masukan Nomor Registrasi">
                    </div>

                    <div class="form-group">
                        <label class="form-label">2. No. KTP / NIK</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="noKtp" placeholder="Masukan No. KTP / NIK salah satu anggota keluarga (Hanya angka)">
                    </div>

                    <div class="form-group">
                        <label class="form-label">3. Nama</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="nama" placeholder="Masukan salah satu anggota keluarga">
                    </div>

                    <div class="form-group">
                        <label class="form-label">4. Jabatan</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="jabatan" placeholder="Profesi salah satu anggota keluarga">
                    </div>

                    <div class="form-group">
                        <label class="form-label">5. Jenis Kelamin</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="jenisKelamin" value="Laki-laki" checked>
                                <span>Laki-laki</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="jenisKelamin" value="Perempuan">
                                <span>Perempuan</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">6. Tempat Lahir</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="tempatLahir" placeholder="Cth. Banyumas">
                    </div>

                    <div class="form-group">
                        <label class="form-label">7. Tgl Lahir/Umur</label>
                        <span class="label-separator">:</span>
                        <div class="date-group">
                            <div class="date-input-wrapper">
                                <input type="text" class="form-input date-input" id="tglLahir" placeholder="Tgl / Bln / Thn">
                                <button type="button" class="calendar-icon" id="btnCalendar">
                                    <svg width="18" height="18" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <rect x="3" y="4" width="14" height="14" rx="2" stroke="currentColor" stroke-width="2"/>
                                        <path d="M3 8h14M7 2v4M13 2v4" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                                    </svg>
                                </button>
                            </div>
                            <span class="age-label">Umur :</span>
                            <input type="number" class="form-input age-input" id="umur" value="0">
                            <span class="age-unit">Tahun</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">8. Status Perkawinan</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group multi">
                            <label class="checkbox-label">
                                <input type="checkbox" name="statusKawin" value="Menikah">
                                <span>Menikah</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="statusKawin" value="Lajang">
                                <span>Lajang</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="statusKawin" value="Janda">
                                <span>Janda</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="statusKawin" value="Duda">
                                <span>Duda</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">9. Status Dalam Keluarga</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="statusKeluarga" value="Kepala Rumah Tangga">
                                <span>Kepala Rumah Tangga</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="statusKeluarga" value="Anggota Keluarga">
                                <span>Anggota Keluarga</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">10. Agama</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group multi">
                            <label class="checkbox-label">
                                <input type="checkbox" name="agama" value="Islam">
                                <span>Islam</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="agama" value="Kristen">
                                <span>Kristen</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="agama" value="Katholik">
                                <span>Katholik</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="agama" value="Hindu">
                                <span>Hindu</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="agama" value="Budha">
                                <span>Budha</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="agama" value="Konghucu">
                                <span>Konghucu</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">11. Alamat</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="alamat" placeholder="Masukan alamat tempat tinggal">
                    </div>

                    <div class="form-group sub-group">
                        <label class="form-label">Status tinggal</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="statusTinggal" value="Mukim">
                                <span>Mukim</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="statusTinggal" value="Perantauan">
                                <span>Perantauan</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group sub-group">
                        <label class="form-label">Desa/Kel/Sejenis</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="desa" placeholder="Masukan Desa/Kelurahan">
                    </div>

                    <div class="form-group sub-group">
                        <label class="form-label">Kab/Kota</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="kabKota" placeholder="Masukan Kabupaten/Kota">
                    </div>

                    <div class="form-group">
                        <label class="form-label">12. Pendidikan</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group multi">
                            <label class="checkbox-label">
                                <input type="checkbox" name="pendidikan" value="Tidak Tamat SD">
                                <span>Tidak Tamat SD</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pendidikan" value="SD/MI">
                                <span>SD/MI</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pendidikan" value="SMP/Sederajat">
                                <span>SMP/Sederajat</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pendidikan" value="SMU/SMK/Sederajat">
                                <span>SMU/SMK/Sederajat</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pendidikan" value="Diploma">
                                <span>Diploma</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pendidikan" value="S1">
                                <span>S1</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pendidikan" value="S2">
                                <span>S2</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pendidikan" value="S3">
                                <span>S3</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">13. Pekerjaan</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group multi">
                            <label class="checkbox-label">
                                <input type="checkbox" name="pekerjaan" value="Petani">
                                <span>Petani</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pekerjaan" value="Pedagang">
                                <span>Pedagang</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pekerjaan" value="PNS">
                                <span>PNS</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pekerjaan" value="TNI/Polri">
                                <span>TNI/Polri</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pekerjaan" value="Swasta">
                                <span>Swasta</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pekerjaan" value="Wiraswasta">
                                <span>Wiraswasta</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pekerjaan" value="Lainnya">
                                <span>Lainnya</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">14. Akseptor KB</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="akseptorKB" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="akseptorKB" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group sub-group">
                        <label class="form-label">Jenis Akseptor KB</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="jenisKB" placeholder="Masukan Jenis KB">
                    </div>

                    <div class="form-group">
                        <label class="form-label">15. Aktif dalam posyandu</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="aktifPosyandu" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="aktifPosyandu" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group sub-group">
                        <label class="form-label">Frekuensi/Volume</label>
                        <span class="label-separator">:</span>
                        <div class="frequency-group">
                            <input type="number" class="form-input frequency-input" id="frekuensi" value="0">
                            <span class="frequency-unit">Kali</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">16. Mengikuti Program Bina Keluarga Balita</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="binaBalita" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="binaBalita" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">17. Memiliki Tabungan</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="tabungan" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="tabungan" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">18. Mengikuti Kelompok Belajar</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="kelompokBelajar" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="kelompokBelajar" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group sub-group">
                        <label class="form-label">Jenis</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group multi">
                            <label class="checkbox-label">
                                <input type="checkbox" name="jenisKelompok" value="Paket A">
                                <span>Paket A</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="jenisKelompok" value="Paket B">
                                <span>Paket B</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="jenisKelompok" value="Paket C">
                                <span>Paket C</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="jenisKelompok" value="KF">
                                <span>KF</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">19. Mengikuti PAUD</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="paud" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="paud" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">20. Ikut dalam kegiatan koperasi</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="koperasi" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="koperasi" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">21. Berkebutuhan Khusus</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="berkebutuhanKhusus" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="berkebutuhanKhusus" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
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

    <script src="/js/pengurusdesa/adddatawarga_pengurusdesa.js"></script>
</body>
</html>
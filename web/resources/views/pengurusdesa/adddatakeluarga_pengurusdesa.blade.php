<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Data Keluarga - My Pandak</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/pengurusdesa/adddatakeluarga_pengurusdesa.css">
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
                
                <a href="datakeluarga_pengurusdesa" class="nav-item active">
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
                <h2 class="page-title">Data Keluarga</h2>
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
                <form id="formDataKeluarga">
                    <!-- Informasi Dasar Keluarga -->
                    <div class="info-section">
                        <div class="info-row">
                            <label class="info-label">Desa Wisma</label>
                            <span class="info-separator">:</span>
                            <input type="text" class="info-value" id="desaWisma" placeholder="Masukan Desa Wisma">
                        </div>
                        <div class="info-row">
                            <label class="info-label">RT / RW</label>
                            <span class="info-separator">:</span>
                            <input type="text" class="info-value" id="rtRw" placeholder="RT / RW">
                        </div>
                        <div class="info-row">
                            <label class="info-label">Dusun / Lingk</label>
                            <span class="info-separator">:</span>
                            <input type="text" class="info-value" id="dusunLingk" placeholder="0">
                        </div>
                    </div>

                    <!-- Alamat Section -->
                    <div class="address-section">
                        <div class="info-row">
                            <span class="address-text">Desa Pandak Kec. Baturaden</span>
                        </div>
                        <div class="info-row">
                            <span class="address-text">Kab. Banyumas Prov. Jawa Tengah</span>
                        </div>
                    </div>

                    <!-- Kepala Keluarga Info -->
                    <div class="kepala-section">
                        <div class="info-row">
                            <label class="info-label">Nama Kepala Rumah Tangga</label>
                            <span class="info-separator">:</span>
                            <input type="text" class="info-value bold" id="namaKepala" placeholder="Susilo Indra Prasetio">
                        </div>
                        <div class="info-row">
                            <label class="info-label">Jumlah Anggota Keluarga</label>
                            <span class="info-separator">:</span>
                            <div class="jumlah-full-group">
                                <input type="number" class="info-value number-input" id="jumlahAnggota" value="0">
                                <span class="unit-text">Orang</span>
                                <span class="note-text">(Berpengaruh pada jumlah tabel)</span>
                            </div>
                        </div>
                        <div class="info-row sub-detail-row">
                            <label class="info-label"></label>
                            <span class="info-separator"></span>
                            <div class="detail-inline-group">
                                <div class="detail-item">
                                    <label class="detail-label">Laki-laki</label>
                                    <span class="detail-separator">:</span>
                                    <input type="number" class="detail-input" id="jumlahLaki" value="0">
                                    <span class="detail-unit">Orang</span>
                                </div>
                                <div class="detail-item">
                                    <label class="detail-label">Perempuan</label>
                                    <span class="detail-separator">:</span>
                                    <input type="number" class="detail-input" id="jumlahPerempuan" value="0">
                                    <span class="detail-unit">Orang</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Form Pertanyaan Dasar -->
                    <div class="section-title-aligned">Data Keluarga</div>

                    <div class="form-group">
                        <label class="form-label">1. Jumlah KK</label>
                        <span class="label-separator">:</span>
                        <div class="number-group">
                            <input type="number" class="form-input number-input" id="jumlahKK" value="0">
                            <span class="unit-text">KK</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">2. Jumlah</label>
                        <span class="label-separator">:</span>
                    </div>

                    <div class="jumlah-grid-container">
                        <div class="jumlah-grid-item">
                            <label class="grid-label">a. Balita</label>
                            <span class="grid-separator">:</span>
                            <input type="number" class="grid-input" id="jumlahBalita" value="0">
                            <span class="grid-unit">Anak ;</span>
                        </div>
                        <div class="jumlah-grid-item">
                            <label class="grid-label">b. Plus</label>
                            <span class="grid-separator">:</span>
                            <input type="number" class="grid-input" id="jumlahPlus" value="0">
                            <span class="grid-unit">Pasang ;</span>
                        </div>
                        <div class="jumlah-grid-item">
                            <label class="grid-label">c. Wus</label>
                            <span class="grid-separator">:</span>
                            <input type="number" class="grid-input" id="jumlahWus" value="0">
                            <span class="grid-unit">Orang ;</span>
                        </div>
                        <div class="jumlah-grid-item">
                            <label class="grid-label">d. Buta</label>
                            <span class="grid-separator">:</span>
                            <input type="number" class="grid-input" id="jumlahButa" value="0">
                            <span class="grid-unit">Orang ;</span>
                        </div>
                        <div class="jumlah-grid-item">
                            <label class="grid-label">e. Ibu Hamil</label>
                            <span class="grid-separator">:</span>
                            <input type="number" class="grid-input" id="jumlahHamil" value="0">
                            <span class="grid-unit">Orang ;</span>
                        </div>
                        <div class="jumlah-grid-item">
                            <label class="grid-label">f. Ibu Menyusui</label>
                            <span class="grid-separator">:</span>
                            <input type="number" class="grid-input" id="jumlahMenyusui" value="0">
                            <span class="grid-unit">Orang ;</span>
                        </div>
                        <div class="jumlah-grid-item">
                            <label class="grid-label">g. Lansia</label>
                            <span class="grid-separator">:</span>
                            <input type="number" class="grid-input" id="jumlahLansia" value="0">
                            <span class="grid-unit">Orang ;</span>
                        </div>
                        <div class="jumlah-grid-item checkbox-item">
                            <label class="grid-label">h. Berkebutuhan Khusus</label>
                            <span class="grid-separator">:</span>
                            <div class="checkbox-group inline-checkbox-group">
                                <label class="checkbox-label">
                                    <input type="checkbox" name="berkebutuhanKhusus" value="Fisik">
                                    <span>Fisik</span>
                                </label>
                                <label class="checkbox-label">
                                    <input type="checkbox" name="berkebutuhanKhusus" value="Non Fisik">
                                    <span>Non Fisik</span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Tabel Anggota Keluarga -->
                    <div class="table-section" id="tableSection">
                        <div class="table-header">
                            <h3 class="table-title">Tabel Anggota Keluarga Anggota ke-1</h3>
                        </div>

                        <div class="table-form">
                            <div class="form-group">
                                <label class="form-label">1. No. Registrasi</label>
                                <span class="label-separator">:</span>
                                <input type="text" class="form-input" id="noRegistrasi_1" placeholder="Masukan nomor Kartu Keluarga">
                            </div>

                            <div class="form-group">
                                <label class="form-label">2. Nama Anggota</label>
                                <span class="label-separator">:</span>
                                <input type="text" class="form-input" id="namaAnggota_1" placeholder="Masukan salah satu anggota keluarga">
                            </div>

                            <div class="form-group">
                                <label class="form-label">3. Status Dalam Keluarga</label>
                                <span class="label-separator">:</span>
                                <div class="checkbox-with-input-wrapper">
                                    <div class="checkbox-group multi">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="statusKeluarga_1" value="Suami">
                                            <span>Suami</span>
                                        </label>
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="statusKeluarga_1" value="Istri">
                                            <span>Istri</span>
                                        </label>
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="statusKeluarga_1" value="Anak">
                                            <span>Anak</span>
                                        </label>
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="statusKeluarga_1" value="Menantu">
                                            <span>Menantu</span>
                                        </label>
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="statusKeluarga_1" value="Keluarga">
                                            <span>Keluarga</span>
                                        </label>
                                        <label class="checkbox-label lainnya-checkbox">
                                            <input type="checkbox" name="statusKeluarga_1" value="Lainnya">
                                            <span>Lainnya</span>
                                        </label>
                                    </div>
                                    <input type="text" class="form-input input-below-lainnya" id="lainnyaStatus_1" placeholder="Lainnya">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">4. Status Dalam Perkawinan</label>
                                <span class="label-separator">:</span>
                                <div class="checkbox-group">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="statusKawin_1" value="Kawin">
                                        <span>Kawin</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="statusKawin_1" value="Belum">
                                        <span>Belum</span>
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">5. Jenis Kelamin</label>
                                <span class="label-separator">:</span>
                                <div class="checkbox-group">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="jenisKelamin_1" value="Laki-Laki">
                                        <span>Laki-Laki</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="jenisKelamin_1" value="Perempuan">
                                        <span>Perempuan</span>
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">6. Tgl Lahir / Umur</label>
                                <span class="label-separator">:</span>
                                <div class="date-group">
                                    <div class="date-input-wrapper">
                                        <input type="text" class="form-input date-input" id="tglLahir_1" placeholder="Tgl / Bln / Thn">
                                        <button type="button" class="calendar-icon" id="btnCalendar_1">
                                            <svg width="18" height="18" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <rect x="3" y="4" width="14" height="14" rx="2" stroke="currentColor" stroke-width="2"/>
                                                <path d="M3 8h14M7 2v4M13 2v4" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">7. Pendidikan</label>
                                <span class="label-separator">:</span>
                                <div class="checkbox-group multi">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="pendidikan_1" value="Tidak Tamat SD">
                                        <span>Tidak Tamat SD</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="pendidikan_1" value="SD/MI">
                                        <span>SD/MI</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="pendidikan_1" value="SMP">
                                        <span>SMP</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="pendidikan_1" value="SMU/SMK">
                                        <span>SMU/SMK</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="pendidikan_1" value="S1">
                                        <span>S1</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="pendidikan_1" value="S2">
                                        <span>S2</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="pendidikan_1" value="S3">
                                        <span>S3</span>
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">8. Pekerjaan</label>
                                <span class="label-separator">:</span>
                                <input type="text" class="form-input" id="pekerjaan_1" placeholder="Masukan pekerjaan salah satu anggota keluarga">
                            </div>
                        </div>

                        <!-- Pagination untuk tabel -->
                        <div class="pagination">
                            <button type="button" class="btn-pagination" id="btnPrev">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M15 18l-6-6 6-6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </button>
                            <span class="pagination-info" id="paginationInfo">1 Dari 3 Tabel</span>
                            <button type="button" class="btn-pagination" id="btnNext">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M9 18l6-6-6-6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </button>
                        </div>
                    </div>

                    <!-- Form Lanjutan -->
                    <div class="section-title-aligned">Informasi Tambahan</div>

                    <div class="form-group">
                        <label class="form-label">3. Makanan Pokok Sehari-hari</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="makananPokok" value="Beras">
                                <span>Beras</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="makananPokok" value="Non Beras">
                                <span>Non Beras</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">4. Mempunyai Jamban Keluarga</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="jamban" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="jamban" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                        <span class="inline-label">Jumlah :</span>
                        <input type="number" class="form-input inline-number-input" id="jumlahJamban" value="0">
                        <span class="inline-unit">Buah</span>
                    </div>

                    <div class="form-group">
                        <label class="form-label">5. Sumber Air Keluarga</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="sumberAir" value="PDAM">
                                <span>PDAM</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="sumberAir" value="Sumur">
                                <span>Sumur</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="sumberAir" value="Lainnya">
                                <span>Lainnya</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">6. Memiliki Tempat Pembuangan Sampah</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="tempatSampah" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="tempatSampah" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">7. Mempunyai Saluran Pembuangan Air Limbah</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="saluranLimbah" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="saluranLimbah" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">8. Menempel Stiker P4K</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="stikerP4K" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="stikerP4K" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">9. Kriteria Rumah</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="kriteriaRumah" value="Sehat">
                                <span>Sehat</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="kriteriaRumah" value="Kurang Sehat">
                                <span>Kurang Sehat</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">10. Aktivitas UP2K</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="up2k" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="up2k" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group sub-inline-group">
                        <span class="inline-label">Jenis Usaha :</span>
                        <input type="text" class="form-input inline-text-input" id="jenisUsaha" placeholder="Warung">
                        <label class="checkbox-label inline-checkbox">
                            <input type="checkbox" name="kegiatanKoperasi" value="Kegiatan Koperasi">
                            <span>Kegiatan Koperasi</span>
                        </label>
                    </div>

                    <div class="form-group">
                        <label class="form-label">11. Aktivitas Kegiatan Usaha Kesehatan Lingkungan</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="up2kLayak" value="Layak">
                                <span>Layak</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="up2kLayak" value="Tidak Layak">
                                <span>Tidak Layak</span>
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

    <script src="/js/pengurusdesa/adddatakeluarga_pengurusdesa.js"></script>
</body>
</html>
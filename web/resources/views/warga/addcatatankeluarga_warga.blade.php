<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Catatan Keluarga - My Pandak</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/pengurusdesa/addcatatankeluarga_pengurusdesa.css">
    <style>
        /* Additional style to match Data Warga age input */
        .age-label {
            margin-left: 15px;
            margin-right: 10px;
            font-weight: 500;
            color: #1e293b;
            align-self: center;
        }
        
        .age-input {
            width: 60px !important;
            text-align: center;
            background-color: #f1f5f9;
        }
        
        .age-unit {
            margin-left: 10px;
            color: #64748b;
            align-self: center;
        }
        
        .date-group {
            display: flex;
            align-items: center;
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
                <span class="user-name">Warga</span>
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
                
                <a href="catatankeluarga_warga" class="nav-item active">
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
            <!-- Page Header with Back Button -->
            <div class="page-header">
                <button class="btn-back" onclick="goBack()">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </button>
                <h2 class="page-title">Catatan Keluarga</h2>
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
                <form id="formCatatanKeluarga">
                    <!-- Informasi Dasar -->
                    <div class="info-section">
                        <div class="info-row">
                            <label class="info-label">Catatan Dari Keluarga</label>
                            <span class="info-separator">:</span>
                            <input type="text" class="info-value" id="namaKeluarga" placeholder="Susilo Indra. P">
                        </div>
                        <div class="info-row">
                            <label class="info-label">Anggota Dari Kelompok</label>
                            <span class="info-separator">:</span>
                            <input type="text" class="info-value" id="kelompok" placeholder="Mawar 1">
                        </div>
                        <div class="info-row">
                            <label class="info-label">Tahun</label>
                            <span class="info-separator">:</span>
                            <input type="text" class="info-value" id="tahun" placeholder="2023">
                        </div>
                        <div class="info-row">
                            <label class="info-label">Jumlah Anggota Keluarga</label>
                            <span class="info-separator">:</span>
                            <div class="jumlah-full-group">
                                <input type="number" class="info-value number-input" id="jumlahAnggota" value="0" style="width: 60px; padding: 8px; border: 1px solid #e2e8f0; border-radius: 6px;">
                                <span class="unit-text" style="margin-left: 8px;">Orang</span>
                                <span class="note-text" style="margin-left: 8px; font-size: 12px; color: #64748b;">(Menentukan jumlah tabel anggota)</span>
                            </div>
                        </div>
                        <div class="info-row">
                            <label class="info-label">Kriteria Rumah</label>
                            <span class="info-separator">:</span>
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
                        <div class="info-row">
                            <label class="info-label">Jamban Keluarga</label>
                            <span class="info-separator">:</span>
                            <div class="checkbox-inline-group">
                                <label class="checkbox-label">
                                    <input type="checkbox" name="jambanKeluarga" value="Ada">
                                    <span>Ada</span>
                                </label>
                                <label class="checkbox-label">
                                    <input type="checkbox" name="jambanKeluarga" value="Tidak Ada">
                                    <span>Tidak Ada</span>
                                </label>
                                <div class="inline-input-group">
                                    <span class="inline-label">Jumlah :</span>
                                    <input type="number" class="inline-number-input" id="jumlahJamban" value="0">
                                    <span class="inline-unit">Buah</span>
                                </div>
                            </div>
                        </div>
                        <div class="info-row">
                            <label class="info-label">Tempat Sampah</label>
                            <span class="info-separator">:</span>
                            <div class="checkbox-inline-group">
                                <label class="checkbox-label">
                                    <input type="checkbox" name="tempatSampah" value="Ada">
                                    <span>Ada</span>
                                </label>
                                <span class="inline-spacer"></span>
                                <label class="checkbox-label">
                                    <input type="checkbox" name="tempatSampah" value="Tidak Ada">
                                    <span>Tidak Ada</span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Tabel Anggota Keluarga Section -->
                    <div class="table-section" id="tableSection">
                        <div class="table-header">
                            <h3 class="table-title">Tabel Anggota Keluarga Anggota ke-1</h3>
                        </div>

                        <div class="table-form">
                            <div class="form-group">
                                <label class="form-label">1. Nama Anggota Keluarga</label>
                                <span class="label-separator">:</span>
                                <input type="text" class="form-input" id="namaAnggota_1" placeholder="Masukan salah satu anggota keluarga">
                            </div>

                            <div class="form-group">
                                <label class="form-label">2. Status Perkawinan</label>
                                <span class="label-separator">:</span>
                                <div class="checkbox-group">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="statusPerkawinan_1" value="Kawin">
                                        <span>Kawin</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="statusPerkawinan_1" value="Belum">
                                        <span>Belum</span>
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">3. Jenis Kelamin</label>
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
                                <label class="form-label">4. Tgl Lahir / Umur</label>
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
                                    <span class="age-label">Umur :</span>
                                    <input type="number" class="form-input age-input" id="umur_1" value="0" readonly>
                                    <span class="age-unit">Tahun</span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">5. Agama</label>
                                <span class="label-separator">:</span>
                                <div class="checkbox-group multi">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="agama_1" value="Islam">
                                        <span>Islam</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="agama_1" value="Kristen">
                                        <span>Kristen</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="agama_1" value="Katolik">
                                        <span>Katolik</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="agama_1" value="Hindu">
                                        <span>Hindu</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="agama_1" value="Budha">
                                        <span>Budha</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="agama_1" value="Konghucu">
                                        <span>Konghucu</span>
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">6. Pendidikan</label>
                                <span class="label-separator">:</span>
                                <div class="checkbox-grid">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="pendidikan_1" value="Tidak SD">
                                        <span>Tidak SD</span>
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
                                        <input type="checkbox" name="pendidikan_1" value="Tidak Tamat SD">
                                        <span>Tidak Tamat SD</span>
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
                                <label class="form-label">7. Pekerjaan</label>
                                <span class="label-separator">:</span>
                                <input type="text" class="form-input" id="pekerjaan_1" placeholder="Masukan pekerjaan salah satu anggota keluarga">
                            </div>

                            <div class="form-group">
                                <label class="form-label">8. Berkebutuhan Khusus (Disabilitas)</label>
                                <span class="label-separator">:</span>
                                <div class="checkbox-group">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="berkebutuhanKhusus_1" value="Ya">
                                        <span>Ya</span>
                                    </label>
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="berkebutuhanKhusus_1" value="Tidak">
                                        <span>Tidak</span>
                                    </label>
                                </div>
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

                    <!-- Kegiatan PKK Section -->
                    <div class="section-title-aligned">Kegiatan PKK yang diikuti</div>

                    <div class="form-group">
                        <label class="form-label">Penghayatan dan Pengamalan Pancasila</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="pancasila" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pancasila" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Gotong Royong</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="gotongRoyong" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="gotongRoyong" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Pendidikan dan Ketrampilan</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="pendidikanKetrampilan" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pendidikanKetrampilan" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Pengembangan Kehidupan Berkoperasi</label>
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
                        <label class="form-label">Pangan</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="pangan" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="pangan" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Sandang</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="sandang" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="sandang" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Kesehatan</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="kesehatan" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="kesehatan" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Perencanaan Sehat</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="perencanaanSehat" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="perencanaanSehat" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Kelestarian</label>
                        <span class="label-separator">:</span>
                        <div class="checkbox-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="kelestarian" value="Ya">
                                <span>Ya</span>
                            </label>
                            <label class="checkbox-label">
                                <input type="checkbox" name="kelestarian" value="Tidak">
                                <span>Tidak</span>
                            </label>
                        </div>
                    </div>

                    <!-- Pemeriksaan Tambh Perkembangan Balita/PKK -->
                    <div class="section-title-aligned">Pemeriksaan Tambah Perkembangan Balita/PKK</div>

                    <div class="form-group">
                        <label class="form-label">1. Nama KRT</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="namaKRT" placeholder="Masukan Nama KRT">
                    </div>

                    <div class="form-group">
                        <label class="form-label">2. Peternakan</label>
                        <span class="label-separator">:</span>
                        <div class="sub-group-container">
                            <div class="sub-group-row">
                                <span class="sub-label">Komoditi</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="peternakanKomoditi" placeholder="Masukan komoditi yang di hasilkan (ayam, bebek, dll)">
                            </div>
                            <div class="sub-group-row">
                                <span class="sub-label">Volume</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="peternakanVolume" placeholder="Masukan jumlah komoditi yang dihasilkan">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">3. Pertanian</label>
                        <span class="label-separator">:</span>
                        <div class="sub-group-container">
                            <div class="sub-group-row">
                                <span class="sub-label">Komoditi</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="pertanianKomoditi" placeholder="Masukan komoditi yang di hasilkan (padi, jagung, dll)">
                            </div>
                            <div class="sub-group-row">
                                <span class="sub-label">Volume</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="pertanianVolume" placeholder="Masukan jumlah komoditi yang dihasilkan">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">4. Toga</label>
                        <span class="label-separator">:</span>
                        <div class="sub-group-container">
                            <div class="sub-group-row">
                                <span class="sub-label">Komoditi</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="togaKomoditi" placeholder="Masukan komoditi yang di hasilkan (jahe, kunyit, dll)">
                            </div>
                            <div class="sub-group-row">
                                <span class="sub-label">Volume</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="togaVolume" placeholder="Masukan jumlah komoditi yang dihasilkan">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">5. Lumbung Hidup</label>
                        <span class="label-separator">:</span>
                        <div class="sub-group-container">
                            <div class="sub-group-row">
                                <span class="sub-label">Komoditi</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="lumbungKomoditi" placeholder="Masukan komoditi yang di hasilkan (cabai, tomat, dll)">
                            </div>
                            <div class="sub-group-row">
                                <span class="sub-label">Volume</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="lumbungVolume" placeholder="Masukan jumlah komoditi yang dihasilkan">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">6. Lumbung Hidup</label>
                        <span class="label-separator">:</span>
                        <div class="sub-group-container">
                            <div class="sub-group-row">
                                <span class="sub-label">Komoditi</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="lumbungKomoditi2" placeholder="Masukan komoditi yang di hasilkan (cabai, tomat, dll)">
                            </div>
                            <div class="sub-group-row">
                                <span class="sub-label">Volume</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="lumbungVolume2" placeholder="Masukan jumlah komoditi yang dihasilkan">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">8. Tanaman Keras</label>
                        <span class="label-separator">:</span>
                        <div class="sub-group-container">
                            <div class="sub-group-row">
                                <span class="sub-label">Komoditi</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="tanamanKerasKomoditi" placeholder="Masukan komoditi yang di hasilkan (Jati, mahoni, dll)">
                            </div>
                            <div class="sub-group-row">
                                <span class="sub-label">Volume</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="tanamanKerasVolume" placeholder="Masukan jumlah komoditi yang dihasilkan">
                            </div>
                        </div>
                    </div>

                    <!-- Industri Rumah Tangga -->
                    <div class="section-title-aligned">Industri Rumah Tangga</div>

                    <div class="form-group">
                        <label class="form-label">1. Nama KRT</label>
                        <span class="label-separator">:</span>
                        <input type="text" class="form-input" id="namaKRT2" placeholder="Masukan Nama KRT">
                    </div>

                    <div class="form-group">
                        <label class="form-label">2. Pangan</label>
                        <span class="label-separator">:</span>
                        <div class="sub-group-container">
                            <div class="sub-group-row">
                                <span class="sub-label">Komoditi</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="panganKomoditi" placeholder="Masukan komoditi yang di hasilkan (Roti, kripik, dll)">
                            </div>
                            <div class="sub-group-row">
                                <span class="sub-label">Volume</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="panganVolume" placeholder="Masukan jumlah komoditi yang dihasilkan">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">3. Sandang</label>
                        <span class="label-separator">:</span>
                        <div class="sub-group-container">
                            <div class="sub-group-row">
                                <span class="sub-label">Komoditi</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="sandangKomoditi" placeholder="Masukan komoditi yang di hasilkan (Batik, Bordir, dll)">
                            </div>
                            <div class="sub-group-row">
                                <span class="sub-label">Volume</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="sandangVolume" placeholder="Masukan jumlah komoditi yang dihasilkan">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">4. Jasa</label>
                        <span class="label-separator">:</span>
                        <div class="sub-group-container">
                            <div class="sub-group-row">
                                <span class="sub-label">Komoditi</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="jasaKomoditi" placeholder="Masukan komoditi yang di hasilkan (Salon, pangkas, dll)">
                            </div>
                            <div class="sub-group-row">
                                <span class="sub-label">Volume</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="jasaVolume" placeholder="Masukan jumlah komoditi yang dihasilkan">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">5. Lain- lain</label>
                        <span class="label-separator">:</span>
                        <div class="sub-group-container">
                            <div class="sub-group-row">
                                <span class="sub-label">Komoditi</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="lainLainKomoditi" placeholder="Masukan komoditi yang di hasilkan (Kerajinan, dll)">
                            </div>
                            <div class="sub-group-row">
                                <span class="sub-label">Volume</span>
                                <span class="sub-separator">:</span>
                                <input type="text" class="form-input" id="lainLainVolume" placeholder="Masukan jumlah komoditi yang dihasilkan">
                            </div>
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

    <script src="/js/warga/addcatatankeluarga_warga.js"></script>
</body>
</html>

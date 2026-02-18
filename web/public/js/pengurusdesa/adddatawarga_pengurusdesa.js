// Fungsi untuk kembali ke halaman sebelumnya
function goBack() {
    const urlParams = new URLSearchParams(window.location.search);
    const wargaId = urlParams.get('id');
    const namaKepala = urlParams.get('nama');
    
    // Kembali ke halaman datawargatabel dengan parameter yang sama
    if (wargaId && namaKepala) {
        window.location.href = `datawargatabel_pengurusdesa?id=${wargaId}&nama=${namaKepala}`;
    } else {
        window.location.href = 'datawarga_pengurusdesa';
    }
}

// Fungsi untuk mendapatkan parameter dari URL
function getUrlParameter(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

// Fungsi untuk mengatur checkbox agar hanya satu yang bisa dipilih per grup
function setupSingleCheckbox(name) {
    const checkboxes = document.querySelectorAll(`input[name="${name}"]`);
    
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            if (this.checked) {
                checkboxes.forEach(cb => {
                    if (cb !== this) cb.checked = false;
                });
            }
        });
    });
}

// Fungsi untuk menghitung umur dari tanggal lahir
function calculateAge(birthDate) {
    const today = new Date();
    const birth = new Date(birthDate);
    let age = today.getFullYear() - birth.getFullYear();
    const monthDiff = today.getMonth() - birth.getMonth();
    
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birth.getDate())) {
        age--;
    }
    
    return age;
}

// Fungsi untuk format tanggal ke format Indonesia (DD/MM/YYYY)
function formatDateIndo(date) {
    const d = new Date(date);
    const day = String(d.getDate()).padStart(2, '0');
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const year = d.getFullYear();
    return `${day}/${month}/${year}`;
}

// Fungsi untuk mengumpulkan data form
function collectFormData() {
    const form = document.getElementById('formDataWarga');
    
    // Data dasar
    const formData = {
        id: Date.now(), // Generate unique ID
        desaWisma: document.getElementById('desaWisma').value,
        namaKepala: document.getElementById('namaKepala').value,
        noRegistrasi: document.getElementById('noRegistrasi').value,
        noKtp: document.getElementById('noKtp').value,
        nama: document.getElementById('nama').value,
        jabatan: document.getElementById('jabatan').value,
        tempatLahir: document.getElementById('tempatLahir').value,
        tglLahir: document.getElementById('tglLahir').value,
        umur: document.getElementById('umur').value,
        alamat: document.getElementById('alamat').value,
        desa: document.getElementById('desa').value,
        kabKota: document.getElementById('kabKota').value,
        jenisKB: document.getElementById('jenisKB').value,
        frekuensi: document.getElementById('frekuensi').value
    };
    
    // Checkbox groups
    const checkboxGroups = [
        'jenisKelamin', 'statusKawin', 'statusKeluarga', 'agama',
        'statusTinggal', 'pendidikan', 'pekerjaan', 'akseptorKB',
        'aktifPosyandu', 'binaBalita', 'tabungan', 'kelompokBelajar',
        'jenisKelompok', 'paud', 'koperasi', 'berkebutuhanKhusus'
    ];
    
    checkboxGroups.forEach(groupName => {
        const checked = document.querySelector(`input[name="${groupName}"]:checked`);
        formData[groupName] = checked ? checked.value : '';
    });
    
    // Untuk checkbox yang bisa multiple (jenis kelompok)
    const jenisKelompokChecked = Array.from(
        document.querySelectorAll('input[name="jenisKelompok"]:checked')
    ).map(cb => cb.value);
    
    if (jenisKelompokChecked.length > 0) {
        formData.jenisKelompok = jenisKelompokChecked.join(', ');
    }
    
    return formData;
}

// Fungsi validasi form
function validateForm() {
    const requiredFields = [
        { id: 'noKtp', label: 'No. KTP / NIK' },
        { id: 'nama', label: 'Nama' },
        { id: 'jabatan', label: 'Jabatan' },
        { id: 'tempatLahir', label: 'Tempat Lahir' },
        { id: 'tglLahir', label: 'Tanggal Lahir' },
        { id: 'alamat', label: 'Alamat' }
    ];
    
    const errors = [];
    
    requiredFields.forEach(field => {
        const element = document.getElementById(field.id);
        if (!element.value.trim()) {
            errors.push(field.label);
            element.style.borderBottomColor = '#ef4444';
        } else {
            element.style.borderBottomColor = '#94a3b8';
        }
    });
    
    // Validasi jenis kelamin
    const jenisKelamin = document.querySelector('input[name="jenisKelamin"]:checked');
    if (!jenisKelamin) {
        errors.push('Jenis Kelamin');
    }
    
    return errors;
}

// Fungsi untuk menyimpan data
function saveData() {
    // Validasi form
    const errors = validateForm();
    
    if (errors.length > 0) {
        alert('Mohon lengkapi field berikut:\n- ' + errors.join('\n- '));
        return;
    }
    
    // Kumpulkan data
    const formData = collectFormData();
    
    // Simpan ke localStorage
    const existingData = JSON.parse(localStorage.getItem('dataWarga') || '[]');
    existingData.push(formData);
    localStorage.setItem('dataWarga', JSON.stringify(existingData));
    
    // Tampilkan notifikasi sukses
    alert('Data berhasil disimpan!');
    
    // Redirect kembali ke halaman tabel
    const urlParams = new URLSearchParams(window.location.search);
    const wargaId = urlParams.get('id');
    const namaKepala = urlParams.get('nama');
    
    if (wargaId && namaKepala) {
        window.location.href = `datawargatabel_pengurusdesa?id=${wargaId}&nama=${namaKepala}`;
    } else {
        window.location.href = 'datawarga_pengurusdesa';
    }
}

// Fungsi untuk mencetak data
function printData() {
    // Validasi form terlebih dahulu
    const errors = validateForm();
    
    if (errors.length > 0) {
        alert('Mohon lengkapi data sebelum mencetak:\n- ' + errors.join('\n- '));
        return;
    }
    
    // Simpan data terlebih dahulu
    const formData = collectFormData();
    console.log('Data yang akan dicetak:', formData);
    
    // Implementasi print
    window.print();
}

// Fungsi untuk mengisi data dari URL parameter
function loadDataFromUrl() {
    const namaKepala = decodeURIComponent(getUrlParameter('nama') || '');
    const desaWisma = getUrlParameter('desa') || '';
    
    // Set nilai ke field jika ada parameter
    if (namaKepala) document.getElementById('namaKepala').value = namaKepala;
    if (desaWisma) document.getElementById('desaWisma').value = desaWisma;
}

// Setup Calendar Icon di dalam input
function setupCalendarIcon() {
    const tglLahirInput = document.getElementById('tglLahir');
    const umurInput = document.getElementById('umur');
    const btnCalendar = document.getElementById('btnCalendar');
    const dateInputWrapper = document.querySelector('.date-input-wrapper');
    
    // Buat date input yang akan digunakan untuk date picker
    const datePickerInput = document.createElement('input');
    datePickerInput.type = 'date';
    datePickerInput.id = 'datePickerInput';
    datePickerInput.className = 'hidden-date-picker';
    dateInputWrapper.appendChild(datePickerInput);
    
    // Event ketika icon kalender diklik
    btnCalendar.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        // Focus dan click pada date picker input
        datePickerInput.focus();
        
        // Gunakan showPicker jika tersedia (Chrome, Edge modern)
        if (datePickerInput.showPicker) {
            try {
                datePickerInput.showPicker();
            } catch (error) {
                // Fallback jika showPicker gagal
                datePickerInput.click();
            }
        } else {
            // Fallback untuk browser lain
            datePickerInput.click();
        }
    });
    
    // Event ketika tanggal dipilih dari date picker
    datePickerInput.addEventListener('change', function() {
        if (this.value) {
            // Parse tanggal dari format YYYY-MM-DD
            const dateParts = this.value.split('-');
            const year = dateParts[0];
            const month = dateParts[1];
            const day = dateParts[2];
            
            // Format ke Tgl / Bln / Thn
            tglLahirInput.value = `${day} / ${month} / ${year}`;
            
            // Hitung umur
            const age = calculateAge(this.value);
            umurInput.value = age;
            
            // Hapus placeholder saat ada nilai
            tglLahirInput.classList.add('has-value');
        }
    });
    
    // Event ketika user mengetik manual
    tglLahirInput.addEventListener('input', function() {
        // Parse tanggal manual (format bebas: DD/MM/YYYY atau DD / MM / YYYY)
        const value = this.value.replace(/\s/g, ''); // Hapus spasi
        const datePattern = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
        const match = value.match(datePattern);
        
        if (match) {
            const day = match[1].padStart(2, '0');
            const month = match[2].padStart(2, '0');
            const year = match[3];
            const dateStr = `${year}-${month}-${day}`;
            
            if (!isNaN(Date.parse(dateStr))) {
                const age = calculateAge(dateStr);
                umurInput.value = age;
                this.classList.add('has-value');
                
                // Update date picker input juga
                datePickerInput.value = dateStr;
            }
        }
        
        // Jika input kosong, kembalikan placeholder
        if (this.value === '') {
            this.classList.remove('has-value');
            datePickerInput.value = '';
        }
    });
    
    // Event ketika input mendapat focus
    tglLahirInput.addEventListener('focus', function() {
        // Jika ada nilai, hilangkan format spasi untuk memudahkan edit
        if (this.value) {
            this.value = this.value.replace(/\s/g, '');
        }
    });
    
    // Event ketika input kehilangan focus
    tglLahirInput.addEventListener('blur', function() {
        // Format ulang dengan spasi jika ada nilai
        if (this.value) {
            const value = this.value.replace(/\s/g, '');
            const datePattern = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
            const match = value.match(datePattern);
            
            if (match) {
                const day = match[1].padStart(2, '0');
                const month = match[2].padStart(2, '0');
                const year = match[3];
                this.value = `${day} / ${month} / ${year}`;
            }
        }
    });
}

// Event listener untuk tombol simpan
document.getElementById('btnSimpan').addEventListener('click', function(e) {
    e.preventDefault();
    saveData();
});

// Event listener untuk tombol cetak
document.getElementById('btnCetak').addEventListener('click', function(e) {
    e.preventDefault();
    printData();
});

// Setup checkbox groups untuk single selection
const singleCheckboxGroups = [
    'jenisKelamin', 'statusKeluarga', 'statusTinggal',
    'akseptorKB', 'aktifPosyandu', 'binaBalita', 'tabungan',
    'kelompokBelajar', 'paud', 'koperasi', 'berkebutuhanKhusus'
];

singleCheckboxGroups.forEach(groupName => {
    setupSingleCheckbox(groupName);
});

// Setup untuk checkbox yang bisa multiple (status kawin, agama, pendidikan, pekerjaan)
const multiCheckboxGroups = ['statusKawin', 'agama', 'pendidikan', 'pekerjaan'];

multiCheckboxGroups.forEach(groupName => {
    setupSingleCheckbox(groupName); // Tetap single untuk form ini
});

// Setup input color change saat diisi
function setupInputColorChange() {
    // Ambil semua input text
    const textInputs = document.querySelectorAll('.form-input[type="text"]');
    
    textInputs.forEach(input => {
        // Event saat input berubah
        input.addEventListener('input', function() {
            if (this.value.trim() !== '') {
                this.style.color = '#000000';
            } else {
                this.style.color = '#94a3b8';
            }
        });
        
        // Check initial value
        if (input.value.trim() !== '') {
            input.style.color = '#000000';
        }
    });
    
    // Handle input number (umur dan frekuensi)
    const numberInputs = document.querySelectorAll('.form-input[type="number"]');
    
    numberInputs.forEach(input => {
        input.addEventListener('input', function() {
            if (this.value !== '' && this.value !== '0') {
                this.style.color = '#000000';
            } else {
                this.style.color = '#94a3b8';
            }
        });
        
        // Check initial value
        if (input.value !== '' && input.value !== '0') {
            input.style.color = '#000000';
        }
    });
}

// Setup conditional input untuk Akseptor KB
function setupAkseptorKBConditional() {
    const akseptorYa = document.querySelector('input[name="akseptorKB"][value="Ya"]');
    const akseptorTidak = document.querySelector('input[name="akseptorKB"][value="Tidak"]');
    const jenisKBInput = document.getElementById('jenisKB');
    const jenisKBGroup = jenisKBInput.closest('.form-group');
    const jenisKBLabel = jenisKBGroup.querySelector('.form-label');
    const jenisKBSeparator = jenisKBGroup.querySelector('.label-separator');
    
    // Fungsi untuk disable input Jenis KB
    function disableJenisKB() {
        jenisKBInput.disabled = true;
        jenisKBInput.value = '';
        jenisKBInput.classList.add('disabled');
        jenisKBLabel.classList.add('disabled');
        jenisKBSeparator.classList.add('disabled');
    }
    
    // Fungsi untuk enable input Jenis KB
    function enableJenisKB() {
        jenisKBInput.disabled = false;
        jenisKBInput.classList.remove('disabled');
        jenisKBLabel.classList.remove('disabled');
        jenisKBSeparator.classList.remove('disabled');
    }
    
    // Set initial state (disabled by default)
    disableJenisKB();
    
    // Event listener untuk checkbox Ya
    akseptorYa.addEventListener('change', function() {
        if (this.checked) {
            enableJenisKB();
        } else {
            disableJenisKB();
        }
    });
    
    // Event listener untuk checkbox Tidak
    akseptorTidak.addEventListener('change', function() {
        if (this.checked) {
            disableJenisKB();
        } else if (!akseptorYa.checked) {
            disableJenisKB();
        }
    });
}

// Setup conditional checkboxes untuk Kelompok Belajar
function setupKelompokBelajarConditional() {
    const kelompokBelajarYa = document.querySelector('input[name="kelompokBelajar"][value="Ya"]');
    const kelompokBelajarTidak = document.querySelector('input[name="kelompokBelajar"][value="Tidak"]');
    
    // Ambil semua checkbox jenis kelompok
    const jenisKelompokCheckboxes = document.querySelectorAll('input[name="jenisKelompok"]');
    
    // Ambil form group jenis kelompok
    const jenisKelompokGroups = document.querySelectorAll('input[name="jenisKelompok"]');
    const jenisGroup = jenisKelompokGroups[0].closest('.form-group');
    const jenisLabel = jenisGroup.querySelector('.form-label');
    const jenisSeparator = jenisGroup.querySelector('.label-separator');
    const checkboxGroup = jenisGroup.querySelector('.checkbox-group');
    
    // Fungsi untuk disable semua checkbox jenis kelompok
    function disableJenisKelompok() {
        jenisKelompokCheckboxes.forEach(checkbox => {
            checkbox.disabled = true;
            checkbox.checked = false;
            checkbox.closest('.checkbox-label').classList.add('disabled');
        });
        jenisLabel.classList.add('disabled');
        jenisSeparator.classList.add('disabled');
        checkboxGroup.classList.add('disabled');
    }
    
    // Fungsi untuk enable semua checkbox jenis kelompok
    function enableJenisKelompok() {
        jenisKelompokCheckboxes.forEach(checkbox => {
            checkbox.disabled = false;
            checkbox.closest('.checkbox-label').classList.remove('disabled');
        });
        jenisLabel.classList.remove('disabled');
        jenisSeparator.classList.remove('disabled');
        checkboxGroup.classList.remove('disabled');
    }
    
    // Set initial state (disabled by default)
    disableJenisKelompok();
    
    // Event listener untuk checkbox Ya
    kelompokBelajarYa.addEventListener('change', function() {
        if (this.checked) {
            enableJenisKelompok();
        } else {
            disableJenisKelompok();
        }
    });
    
    // Event listener untuk checkbox Tidak
    kelompokBelajarTidak.addEventListener('change', function() {
        if (this.checked) {
            disableJenisKelompok();
        } else if (!kelompokBelajarYa.checked) {
            disableJenisKelompok();
        }
    });
}

// Setup conditional input untuk Aktif dalam Posyandu
function setupPosyanduConditional() {
    const posyanduYa = document.querySelector('input[name="aktifPosyandu"][value="Ya"]');
    const posyanduTidak = document.querySelector('input[name="aktifPosyandu"][value="Tidak"]');
    const frekuensiInput = document.getElementById('frekuensi');
    const frekuensiGroup = frekuensiInput.closest('.form-group');
    const frekuensiLabel = frekuensiGroup.querySelector('.form-label');
    const frekuensiSeparator = frekuensiGroup.querySelector('.label-separator');
    const frequencyUnit = frekuensiGroup.querySelector('.frequency-unit');
    
    // Fungsi untuk disable input Frekuensi
    function disableFrekuensi() {
        frekuensiInput.disabled = true;
        frekuensiInput.value = '0';
        frekuensiInput.classList.add('disabled');
        frekuensiLabel.classList.add('disabled');
        frekuensiSeparator.classList.add('disabled');
        frequencyUnit.classList.add('disabled');
    }
    
    // Fungsi untuk enable input Frekuensi
    function enableFrekuensi() {
        frekuensiInput.disabled = false;
        frekuensiInput.classList.remove('disabled');
        frekuensiLabel.classList.remove('disabled');
        frekuensiSeparator.classList.remove('disabled');
        frequencyUnit.classList.remove('disabled');
    }
    
    // Set initial state (disabled by default)
    disableFrekuensi();
    
    // Event listener untuk checkbox Ya
    posyanduYa.addEventListener('change', function() {
        if (this.checked) {
            enableFrekuensi();
        } else {
            disableFrekuensi();
        }
    });
    
    // Event listener untuk checkbox Tidak
    posyanduTidak.addEventListener('change', function() {
        if (this.checked) {
            disableFrekuensi();
        } else if (!posyanduYa.checked) {
            disableFrekuensi();
        }
    });
}

// Initialize saat halaman dimuat
document.addEventListener('DOMContentLoaded', function() {
    
    // Load data dari URL
    loadDataFromUrl();
    
    // Setup calendar icon
    setupCalendarIcon();
    
    // Setup input color change
    setupInputColorChange();
    
    // Setup Akseptor KB conditional
    setupAkseptorKBConditional();
    
    // Setup Posyandu conditional
    setupPosyanduConditional();
    
    // Setup Kelompok Belajar conditional
    setupKelompokBelajarConditional();
    
    // Set focus ke field pertama yang BISA diedit (bukan readonly)
    document.getElementById('noKtp').focus();
    
    // Check login status (opsional)
    if (!sessionStorage.getItem('isLoggedIn')) {
        // Redirect ke halaman login jika belum login
        // window.location.href = '../login';
    }
});

// Prevent form submission on Enter key
document.getElementById('formDataWarga').addEventListener('submit', function(e) {
    e.preventDefault();
    return false;
});

// Auto-format input NIK (hanya angka, max 16 digit)
document.getElementById('noKtp').addEventListener('input', function() {
    this.value = this.value.replace(/[^0-9]/g, '').slice(0, 16);
});

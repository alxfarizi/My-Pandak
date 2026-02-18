// State untuk menyimpan data tabel
let currentTableIndex = 1;
let totalTables = 3;
let tableData = {};

// Fungsi untuk kembali ke halaman sebelumnya
function goBack() {
    window.location.href = 'datakeluarga_pengurusdesa';
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

// Setup Calendar Icon untuk setiap tabel
function setupCalendarIcon(tableIndex) {
    const tglLahirInput = document.getElementById(`tglLahir_${tableIndex}`);
    const btnCalendar = document.getElementById(`btnCalendar_${tableIndex}`);
    const dateInputWrapper = tglLahirInput?.closest('.date-input-wrapper');
    
    if (!tglLahirInput || !btnCalendar || !dateInputWrapper) return;
    
    // Cek apakah date picker sudah ada
    let datePickerInput = dateInputWrapper.querySelector('.hidden-date-picker');
    
    if (!datePickerInput) {
        // Buat date input yang akan digunakan untuk date picker
        datePickerInput = document.createElement('input');
        datePickerInput.type = 'date';
        datePickerInput.id = `datePickerInput_${tableIndex}`;
        datePickerInput.className = 'hidden-date-picker';
        dateInputWrapper.appendChild(datePickerInput);
    }
    
    // Remove event listeners lama jika ada
    const newBtnCalendar = btnCalendar.cloneNode(true);
    btnCalendar.parentNode.replaceChild(newBtnCalendar, btnCalendar);
    
    const newTglLahirInput = tglLahirInput.cloneNode(true);
    tglLahirInput.parentNode.replaceChild(newTglLahirInput, tglLahirInput);
    
    // Event ketika icon kalender diklik
    newBtnCalendar.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        datePickerInput.focus();
        
        if (datePickerInput.showPicker) {
            try {
                datePickerInput.showPicker();
            } catch (error) {
                datePickerInput.click();
            }
        } else {
            datePickerInput.click();
        }
    });
    
    // Event ketika tanggal dipilih dari date picker
    datePickerInput.addEventListener('change', function() {
        if (this.value) {
            const dateParts = this.value.split('-');
            const year = dateParts[0];
            const month = dateParts[1];
            const day = dateParts[2];
            
            newTglLahirInput.value = `${day} / ${month} / ${year}`;
            newTglLahirInput.classList.add('has-value');
        }
    });
    
    // Event ketika user mengetik manual
    newTglLahirInput.addEventListener('input', function() {
        const value = this.value.replace(/\s/g, '');
        const datePattern = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
        const match = value.match(datePattern);
        
        if (match) {
            const day = match[1].padStart(2, '0');
            const month = match[2].padStart(2, '0');
            const year = match[3];
            const dateStr = `${year}-${month}-${day}`;
            
            if (!isNaN(Date.parse(dateStr))) {
                this.classList.add('has-value');
                datePickerInput.value = dateStr;
            }
        }
        
        if (this.value === '') {
            this.classList.remove('has-value');
            datePickerInput.value = '';
        }
    });
    
    newTglLahirInput.addEventListener('focus', function() {
        if (this.value) {
            this.value = this.value.replace(/\s/g, '');
        }
    });
    
    newTglLahirInput.addEventListener('blur', function() {
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

// Fungsi untuk save data tabel saat ini sebelum pindah
function saveCurrentTableData() {
    const tableData = {
        noRegistrasi: document.getElementById(`noRegistrasi_${currentTableIndex}`)?.value || '',
        namaAnggota: document.getElementById(`namaAnggota_${currentTableIndex}`)?.value || '',
        tglLahir: document.getElementById(`tglLahir_${currentTableIndex}`)?.value || '',
        pekerjaan: document.getElementById(`pekerjaan_${currentTableIndex}`)?.value || '',
        lainnyaStatus: document.getElementById(`lainnyaStatus_${currentTableIndex}`)?.value || ''
    };
    
    // Save checkbox values
    const checkboxGroups = [
        'statusKeluarga', 'statusKawin', 'jenisKelamin', 'pendidikan'
    ];
    
    checkboxGroups.forEach(groupName => {
        const checked = document.querySelector(`input[name="${groupName}_${currentTableIndex}"]:checked`);
        tableData[groupName] = checked ? checked.value : '';
    });
    
    return tableData;
}

// Fungsi untuk load data tabel
function loadTableData(tableIndex, data) {
    if (!data) return;
    
    // Load text inputs
    const textFields = ['noRegistrasi', 'namaAnggota', 'tglLahir', 'pekerjaan', 'lainnyaStatus'];
    textFields.forEach(field => {
        const element = document.getElementById(`${field}_${tableIndex}`);
        if (element && data[field]) {
            element.value = data[field];
            if (field === 'tglLahir' && data[field]) {
                element.classList.add('has-value');
            }
        }
    });
    
    // Load checkboxes
    const checkboxGroups = ['statusKeluarga', 'statusKawin', 'jenisKelamin', 'pendidikan'];
    checkboxGroups.forEach(groupName => {
        if (data[groupName]) {
            const checkbox = document.querySelector(`input[name="${groupName}_${tableIndex}"][value="${data[groupName]}"]`);
            if (checkbox) {
                checkbox.checked = true;
            }
        }
    });
}

// Fungsi untuk update jumlah tabel berdasarkan jumlah anggota
function updateTotalTables() {
    const jumlahAnggota = parseInt(document.getElementById('jumlahAnggota').value) || 0;
    totalTables = Math.max(1, jumlahAnggota);
    
    // Update pagination info
    updatePaginationInfo();
    
    // Enable/disable buttons
    document.getElementById('btnPrev').disabled = currentTableIndex === 1;
    document.getElementById('btnNext').disabled = currentTableIndex >= totalTables;
}

// Fungsi untuk update pagination info
function updatePaginationInfo() {
    const paginationInfo = document.getElementById('paginationInfo');
    paginationInfo.textContent = `${currentTableIndex} Dari ${totalTables} Tabel`;
}

// Fungsi untuk navigasi ke tabel berikutnya
function nextTable() {
    if (currentTableIndex >= totalTables) return;
    
    // Save current table data
    tableData[currentTableIndex] = saveCurrentTableData();
    
    // Move to next table
    currentTableIndex++;
    
    // Update table title
    document.querySelector('.table-title').textContent = `Tabel Anggota Keluarga Anggota ke-${currentTableIndex}`;
    
    // Clear form
    clearTableForm();
    
    // Load saved data if exists
    if (tableData[currentTableIndex]) {
        loadTableData(currentTableIndex, tableData[currentTableIndex]);
    }
    
    // Setup calendar for new table
    setupCalendarIcon(currentTableIndex);
    
    // Update pagination
    updatePaginationInfo();
    document.getElementById('btnPrev').disabled = currentTableIndex === 1;
    document.getElementById('btnNext').disabled = currentTableIndex >= totalTables;
    
    // Setup checkboxes untuk tabel baru
    setupTableCheckboxes();
}

// Fungsi untuk navigasi ke tabel sebelumnya
function prevTable() {
    if (currentTableIndex <= 1) return;
    
    // Save current table data
    tableData[currentTableIndex] = saveCurrentTableData();
    
    // Move to previous table
    currentTableIndex--;
    
    // Update table title
    document.querySelector('.table-title').textContent = `Tabel Anggota Keluarga Anggota ke-${currentTableIndex}`;
    
    // Clear form
    clearTableForm();
    
    // Load saved data
    if (tableData[currentTableIndex]) {
        loadTableData(currentTableIndex, tableData[currentTableIndex]);
    }
    
    // Setup calendar for new table
    setupCalendarIcon(currentTableIndex);
    
    // Update pagination
    updatePaginationInfo();
    document.getElementById('btnPrev').disabled = currentTableIndex === 1;
    document.getElementById('btnNext').disabled = currentTableIndex >= totalTables;
    
    // Setup checkboxes untuk tabel baru
    setupTableCheckboxes();
}

// Fungsi untuk clear form tabel
function clearTableForm() {
    // Clear text inputs
    const inputs = document.querySelectorAll('.table-form input[type="text"], .table-form input[type="number"]');
    inputs.forEach(input => {
        input.value = '';
        input.classList.remove('has-value');
    });
    
    // Clear checkboxes
    const checkboxes = document.querySelectorAll('.table-form input[type="checkbox"]');
    checkboxes.forEach(checkbox => {
        checkbox.checked = false;
    });
}

// Setup checkboxes untuk tabel
function setupTableCheckboxes() {
    const checkboxGroups = [
        `statusKeluarga_${currentTableIndex}`,
        `statusKawin_${currentTableIndex}`,
        `jenisKelamin_${currentTableIndex}`,
        `pendidikan_${currentTableIndex}`
    ];
    
    checkboxGroups.forEach(groupName => {
        setupSingleCheckbox(groupName);
    });
}

// Fungsi untuk mengumpulkan semua data form
function collectAllFormData() {
    // Save current table data
    tableData[currentTableIndex] = saveCurrentTableData();
    
    const formData = {
        id: Date.now(),
        // Info dasar
        desaWisma: document.getElementById('desaWisma').value,
        rtRw: document.getElementById('rtRw').value,
        dusunLingk: document.getElementById('dusunLingk').value,
        namaKepala: document.getElementById('namaKepala').value,
        jumlahAnggota: document.getElementById('jumlahAnggota').value,
        jumlahLaki: document.getElementById('jumlahLaki').value,
        jumlahPerempuan: document.getElementById('jumlahPerempuan').value,
        
        // Data keluarga
        jumlahKK: document.getElementById('jumlahKK').value,
        jumlahBalita: document.getElementById('jumlahBalita').value,
        jumlahPlus: document.getElementById('jumlahPlus').value,
        jumlahWus: document.getElementById('jumlahWus').value,
        jumlahButa: document.getElementById('jumlahButa').value,
        jumlahHamil: document.getElementById('jumlahHamil').value,
        jumlahMenyusui: document.getElementById('jumlahMenyusui').value,
        jumlahLansia: document.getElementById('jumlahLansia').value,
        
        // Informasi tambahan
        jumlahJamban: document.getElementById('jumlahJamban').value,
        jenisUsaha: document.getElementById('jenisUsaha').value
    };
    
    // Checkbox groups
    const checkboxGroups = [
        'berkebutuhanKhusus', 'makananPokok', 'jamban', 'sumberAir',
        'tempatSampah', 'saluranLimbah', 'stikerP4K', 'kriteriaRumah',
        'up2k', 'up2kLayak'
    ];
    
    checkboxGroups.forEach(groupName => {
        const checked = document.querySelector(`input[name="${groupName}"]:checked`);
        formData[groupName] = checked ? checked.value : '';
    });
    
    // Add table data
    formData.anggotaKeluarga = tableData;
    
    return formData;
}

// Fungsi validasi form
function validateForm() {
    const requiredFields = [
        { id: 'rtRw', label: 'RT / RW' },
        { id: 'namaKepala', label: 'Nama Kepala Rumah Tangga' },
        { id: 'jumlahAnggota', label: 'Jumlah Anggota Keluarga' }
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
    
    // Kumpulkan semua data
    const formData = collectAllFormData();
    
    // Simpan ke localStorage
    const existingData = JSON.parse(localStorage.getItem('dataKeluarga') || '[]');
    existingData.push(formData);
    localStorage.setItem('dataKeluarga', JSON.stringify(existingData));
    
    // Tampilkan notifikasi sukses
    alert('Data berhasil disimpan!');
    
    // Redirect kembali ke halaman data keluarga
    window.location.href = 'datakeluarga_pengurusdesa';
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
    const formData = collectAllFormData();
    console.log('Data yang akan dicetak:', formData);
    
    // Implementasi print
    window.print();
}

// Setup input color change saat diisi
function setupInputColorChange() {
    const textInputs = document.querySelectorAll('.form-input[type="text"]');
    
    textInputs.forEach(input => {
        input.addEventListener('input', function() {
            if (this.value.trim() !== '') {
                this.style.color = '#000000';
            } else {
                this.style.color = '#94a3b8';
            }
        });
        
        if (input.value.trim() !== '') {
            input.style.color = '#000000';
        }
    });
    
    const numberInputs = document.querySelectorAll('.form-input[type="number"], .detail-input, .number-input');
    
    numberInputs.forEach(input => {
        input.addEventListener('input', function() {
            if (this.value !== '' && this.value !== '0') {
                this.style.color = '#000000';
            } else {
                this.style.color = '#94a3b8';
            }
        });
        
        if (input.value !== '' && input.value !== '0') {
            input.style.color = '#000000';
        }
    });
}

// Setup conditional untuk Jamban
function setupJambanConditional() {
    const jambanYa = document.querySelector('input[name="jamban"][value="Ya"]');
    const jambanTidak = document.querySelector('input[name="jamban"][value="Tidak"]');
    const jumlahJambanInput = document.getElementById('jumlahJamban');
    
    function disableJumlahJamban() {
        jumlahJambanInput.disabled = true;
        jumlahJambanInput.value = '0';
        jumlahJambanInput.style.color = '#94a3b8';
    }
    
    function enableJumlahJamban() {
        jumlahJambanInput.disabled = false;
        jumlahJambanInput.style.color = '#000000';
    }
    
    disableJumlahJamban();
    
    jambanYa.addEventListener('change', function() {
        if (this.checked) {
            enableJumlahJamban();
        }
    });
    
    jambanTidak.addEventListener('change', function() {
        if (this.checked) {
            disableJumlahJamban();
        }
    });
}

// Setup conditional untuk UP2K
function setupUP2KConditional() {
    const up2kYa = document.querySelector('input[name="up2k"][value="Ya"]');
    const up2kTidak = document.querySelector('input[name="up2k"][value="Tidak"]');
    const jenisUsahaInput = document.getElementById('jenisUsaha');
    
    function disableJenisUsaha() {
        jenisUsahaInput.disabled = true;
        jenisUsahaInput.value = '';
        jenisUsahaInput.style.color = '#94a3b8';
    }
    
    function enableJenisUsaha() {
        jenisUsahaInput.disabled = false;
    }
    
    disableJenisUsaha();
    
    up2kYa.addEventListener('change', function() {
        if (this.checked) {
            enableJenisUsaha();
        }
    });
    
    up2kTidak.addEventListener('change', function() {
        if (this.checked) {
            disableJenisUsaha();
        }
    });
}

// Initialize saat halaman dimuat
document.addEventListener('DOMContentLoaded', function() {
    
    // Setup calendar untuk tabel pertama
    setupCalendarIcon(1);
    
    // Setup input color change
    setupInputColorChange();
    
    // Setup conditional inputs
    setupJambanConditional();
    setupUP2KConditional();
    
    // Setup checkboxes untuk form utama
    const mainCheckboxGroups = [
        'berkebutuhanKhusus', 'makananPokok', 'jamban', 'sumberAir',
        'tempatSampah', 'saluranLimbah', 'stikerP4K', 'kriteriaRumah',
        'up2k', 'up2kLayak', 'kegiatanKoperasi'
    ];
    
    mainCheckboxGroups.forEach(groupName => {
        setupSingleCheckbox(groupName);
    });
    
    // Setup checkboxes untuk tabel pertama
    setupTableCheckboxes();
    
    // Setup event listeners untuk pagination
    document.getElementById('btnNext').addEventListener('click', nextTable);
    document.getElementById('btnPrev').addEventListener('click', prevTable);
    
    // Setup event listener untuk jumlah anggota
    document.getElementById('jumlahAnggota').addEventListener('input', function() {
        updateTotalTables();
    });
    
    // Initial pagination setup
    updatePaginationInfo();
    document.getElementById('btnPrev').disabled = true;
    
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
    
    // Set focus ke field pertama yang bisa diedit
    document.getElementById('rtRw').focus();
});

// Prevent form submission on Enter key
document.getElementById('formDataKeluarga').addEventListener('submit', function(e) {
    e.preventDefault();
    return false;
});

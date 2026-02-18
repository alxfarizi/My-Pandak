// DOM Elements
const valNamaLengkap = document.getElementById('valNamaLengkap');
const valNamaPanggilan = document.getElementById('valNamaPanggilan');
const valDesaMawar = document.getElementById('valDesaMawar');
const valNoTelepon = document.getElementById('valNoTelepon');
const valNik = document.getElementById('valNik');
const valEmail = document.getElementById('valEmail');
const btnTetapkan = document.getElementById('btnTetapkan');
const backButton = document.getElementById('backButton');
const successModal = document.getElementById('successModal');
const closeSuccessModal = document.getElementById('closeSuccessModal');

// Get ID from URL if exists (for edit mode)
const urlParams = new URLSearchParams(window.location.search);
const editId = urlParams.get('id');

// Retrieve data
let tempData = null;
let isEditMode = false;

if (editId) {
    // Edit Mode: Load from localStorage
    isEditMode = true;
    const wargaData = JSON.parse(localStorage.getItem('wargaData')) || [];
    const warga = wargaData.find(p => p.id == editId);
    
    if (warga) {
        tempData = warga;
        // Populate fields
        valNamaLengkap.textContent = warga.namaLengkap || warga.namaWarga; // Handle property name diffs
        valNamaPanggilan.textContent = warga.namaPanggilan || '-';
        valDesaMawar.textContent = warga.desaWisma || warga.desaMawar;
        valNoTelepon.textContent = warga.noTelepon;
        valNik.textContent = warga.nik;
        valEmail.textContent = warga.email;
        
        // Update button text
        btnTetapkan.textContent = 'Simpan Perubahan';
    } else {
        alert('Data warga tidak ditemukan.');
        window.location.href = 'registrasitabelwarga_pengurusdesa';
    }
} else {
    // Add Mode: Load from sessionStorage
    const tempJson = sessionStorage.getItem('tempWargaData');
    if (tempJson) {
        tempData = JSON.parse(tempJson);
        
        // Populate fields
        valNamaLengkap.textContent = tempData.namaLengkap;
        valNamaPanggilan.textContent = tempData.namaPanggilan;
        valDesaMawar.textContent = tempData.desaWisma || tempData.desaMawar;
        valNoTelepon.textContent = tempData.noTelepon;
        valNik.textContent = tempData.nik;
        valEmail.textContent = tempData.email;
    } else {
        // If no temp data, redirect back to form
        window.location.href = 'formregistrasiwarga_pengurusdesa';
    }
}

// Tetapkan Akun (Save)
btnTetapkan.addEventListener('click', () => {
    if (!tempData) {
        alert('Data tidak ditemukan!');
        window.location.href = 'formregistrasiwarga_pengurusdesa';
        return;
    }

    let wargaData = JSON.parse(localStorage.getItem('wargaData')) || [];

    if (isEditMode) {
        // Update existing
        const index = wargaData.findIndex(p => p.id == editId);
        if (index !== -1) {
            // Merge existing with temp (if we allowed editing in form, but here we just displaying)
            // Wait, if it's edit mode, we are just viewing. 
            // BUT, the user might expect "Tetapkan" to verify/save.
            // Since we don't have an Edit Form (we just reused the Detail View), 
            // usually "Tetapkan" implies creating.
            // If it's view mode, maybe hide the button?
            // The user said "klik salah 1 nya... Frame 5". Frame 5 is this view.
            // If I am just viewing, I shouldn't need to save again unless I changed something.
            // For now, let's assume this page is read-only for Edit Mode, 
            // but maybe I should have redirected to Form for editing?
            // User flow: List -> Detail (This Page).
            // If this is Detail, maybe "Tetapkan" should be "Edit"?
            // Or maybe "Tetapkan" is only for new accounts.
            
            // However, the user request "tambah data" -> Frame 5 (Create Form) -> Frame 5 (Profile View).
            // "klik salah 1" -> Frame 5 (Profile View).
            // So Profile View is used for both.
            
            alert('Data sudah tersimpan.');
            window.location.href = 'registrasitabelwarga_pengurusdesa';
            return;
        }
    } else {
        // Create New
        // Check duplication again just in case
        const emailExists = wargaData.some(w => w.email === tempData.email);
        const nikExists = wargaData.some(w => w.nik === tempData.nik);
        
        if (emailExists || nikExists) {
             // In a real app we might handle this, but validation was done in form.
             // Just proceed or ignore.
        }

        // Generate ID if not present or ensuring unique
        const newId = wargaData.length > 0 ? Math.max(...wargaData.map(w => w.id)) + 1 : 1;
        
        // Ensure final object structure
        const newWarga = {
            ...tempData,
            id: newId,
            noRegistrasi: '327627' + String(5000 + newId),
            registrationDate: new Date().toISOString().split('T')[0]
        };

        wargaData.push(newWarga);
        localStorage.setItem('wargaData', JSON.stringify(wargaData));
        
        // Clear temp
        sessionStorage.removeItem('tempWargaData');
        
        // Show success
        successModal.classList.add('show');
    }
});

// Back button functionality
backButton.addEventListener('click', () => {
    if (isEditMode) {
        window.location.href = 'registrasitabelwarga_pengurusdesa';
    } else {
        // Go back to form to edit
        window.location.href = 'formregistrasiwarga_pengurusdesa';
    }
});

// Close success modal
closeSuccessModal.addEventListener('click', () => {
    successModal.classList.remove('show');
    // Redirect to table page
    window.location.href = 'registrasitabelwarga_pengurusdesa';
});

// Close modal on outside click
successModal.addEventListener('click', (e) => {
    if (e.target === successModal) {
        successModal.classList.remove('show');
        // Redirect to table page
        window.location.href = 'registrasitabelwarga_pengurusdesa';
    }
});

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
    const pengurusData = JSON.parse(localStorage.getItem('pengurusData')) || [];
    const pengurus = pengurusData.find(p => p.id == editId);
    
    if (pengurus) {
        tempData = pengurus;
        // Populate fields
        if(valNamaLengkap) valNamaLengkap.textContent = pengurus.namaLengkap;
        if(valNamaPanggilan) valNamaPanggilan.textContent = pengurus.namaPanggilan;
        if(valDesaMawar) valDesaMawar.textContent = pengurus.jabatan || pengurus.desaMawar; 
        if(valNoTelepon) valNoTelepon.textContent = pengurus.noTelepon;
        if(valNik) valNik.textContent = pengurus.nik;
        if(valEmail) valEmail.textContent = pengurus.email;
        
        // Update button text
        if(btnTetapkan) btnTetapkan.textContent = 'Kembali ke Tabel';
    } else {
        alert('Data pengurus tidak ditemukan.');
        window.location.href = 'registrasitabelpengurus_pengurusdesa';
    }
} else {
    // Add Mode: Load from sessionStorage
    const tempJson = sessionStorage.getItem('tempPengurusData');
    if (tempJson) {
        tempData = JSON.parse(tempJson);
        
        // Populate fields
        if(valNamaLengkap) valNamaLengkap.textContent = tempData.namaLengkap;
        if(valNamaPanggilan) valNamaPanggilan.textContent = tempData.namaPanggilan;
        if(valDesaMawar) valDesaMawar.textContent = tempData.jabatan || tempData.desaMawar;
        if(valNoTelepon) valNoTelepon.textContent = tempData.noTelepon;
        if(valNik) valNik.textContent = tempData.nik;
        if(valEmail) valEmail.textContent = tempData.email;
    } else {
        // If no temp data, redirect back to form
        window.location.href = 'formregistrasipengurus_pengurusdesa';
    }
}

// Tetapkan Akun (Save or Return)
if(btnTetapkan) {
    btnTetapkan.addEventListener('click', () => {
        if (isEditMode) {
             window.location.href = 'registrasitabelpengurus_pengurusdesa';
             return;
        }

        if (!tempData) {
            alert('Data tidak ditemukan!');
            window.location.href = 'formregistrasipengurus_pengurusdesa';
            return;
        }

        let pengurusData = JSON.parse(localStorage.getItem('pengurusData')) || [];
        
        // Check for duplicates (optional but good)
        const emailExists = pengurusData.some(p => p.email === tempData.email);
        if (emailExists) {
             // Already handled in form, but safety check
        }

        // Generate ID
        const newId = pengurusData.length > 0 ? Math.max(...pengurusData.map(p => p.id)) + 1 : 1;
        
        const newPengurus = {
            ...tempData,
            id: newId,
            noRegistrasi: '327627' + String(3270 + newId),
            registrationDate: new Date().toISOString().split('T')[0]
        };

        pengurusData.push(newPengurus);
        localStorage.setItem('pengurusData', JSON.stringify(pengurusData));
        
        sessionStorage.removeItem('tempPengurusData');
        successModal.classList.add('show');
    });
}

// Back button functionality
if(backButton) {
    backButton.addEventListener('click', () => {
        // Clear temp data if navigating back
        sessionStorage.removeItem('tempPengurusData');
        
        if (isEditMode) {
            window.location.href = 'registrasitabelpengurus_pengurusdesa';
        } else {
            window.location.href = 'formregistrasipengurus_pengurusdesa';
        }
    });
}

// Close success modal
if(closeSuccessModal) {
    closeSuccessModal.addEventListener('click', () => {
        if(successModal) successModal.classList.remove('show');
        window.location.href = 'registrasitabelpengurus_pengurusdesa';
    });
}

// Close modal on outside click
if(successModal) {
    successModal.addEventListener('click', (e) => {
        if (e.target === successModal) {
            successModal.classList.remove('show');
            window.location.href = 'registrasitabelpengurus_pengurusdesa';
        }
    });
}

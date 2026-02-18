// Initialize data from localStorage
let pengurusData = JSON.parse(localStorage.getItem('pengurusDesaData')) || [];

// Initial Data for Indah (Requested by User)
const initialIndahData = {
    id: 1,
    namaPengurus: "Indah",
    nik: "3302014506880001",
    email: "indah.pengurus@gmail.com",
    noTelepon: "081234567890",
    jabatan: "kepala_desa",
    desaWisma: "Mawar 1",
    noRegistrasi: "3276273271",
    registrationDate: new Date().toISOString().split('T')[0]
};

// Check if data is empty, if so add Indah
if (pengurusData.length === 0) {
    pengurusData.push(initialIndahData);
    localStorage.setItem('pengurusDesaData', JSON.stringify(pengurusData));
}

// Ensure Indah exists (in case data was cleared or initialized differently)
const indahExists = pengurusData.some(p => p.namaPengurus.toLowerCase() === 'indah');
if (!indahExists && pengurusData.length > 0) {
    // Optional: Add Indah if missing but other data exists? 
    // User said "udah ada 1 list yaitu indah", implying it should be the default.
    // I'll stick to populating if empty for now to avoid duplicates if name varies slightly.
}


// Save to localStorage
function savePengurusData() {
    localStorage.setItem('pengurusDesaData', JSON.stringify(pengurusData));
}

// Save initial data if not exists (Removed for production/empty state requirement)
// if (!localStorage.getItem('pengurusDesaData')) {
//     savePengurusData();
// }

// Pagination variables
let currentPage = 1;
const itemsPerPage = 10;
let filteredData = [...pengurusData];

// DOM Elements
const tableBody = document.getElementById('tableBody');
const emptyState = document.getElementById('emptyState');
const searchInput = document.getElementById('searchInput');
const addAccountBtn = document.getElementById('addAccountBtn');
const addAccountBtnEmpty = document.getElementById('addAccountBtnEmpty');
const backToSelection = document.getElementById('backToSelection');
const prevBtn = document.getElementById('prevBtn');
const nextBtn = document.getElementById('nextBtn');
const paginationInfo = document.getElementById('paginationInfo');

// Modals
const detailModal = document.getElementById('detailModal');
const deleteModal = document.getElementById('deleteModal');
const registrationModal = document.getElementById('registrationModal');
const successModal = document.getElementById('successModal');

const closeDetailModal = document.getElementById('closeDetailModal');
const closeRegistrationModal = document.getElementById('closeRegistrationModal');
const closeSuccessModal = document.getElementById('closeSuccessModal');
const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

// Form elements
const registrationForm = document.getElementById('registrationForm');
const cancelFormBtn = document.getElementById('cancelFormBtn');
const togglePassword = document.getElementById('togglePassword');
const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
const eyeIcon = document.getElementById('eyeIcon');
const eyeIconConfirm = document.getElementById('eyeIconConfirm');
const passwordInput = document.getElementById('password');
const confirmPasswordInput = document.getElementById('confirmPassword');

// Variable to store ID for deletion
let deleteTargetId = null;

// Function to format jabatan
function formatJabatan(jabatan) {
    const jabatanMap = {
        'kepala_desa': 'Kepala Desa',
        'sekretaris': 'Sekretaris Desa',
        'kaur_keuangan': 'Kaur Keuangan',
        'kaur_umum': 'Kaur Umum',
        'kaur_pembangunan': 'Kaur Pembangunan',
        'staf': 'Staf'
    };
    return jabatanMap[jabatan] || jabatan;
}

// Function to render table
function renderTable() {
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const pageData = filteredData.slice(startIndex, endIndex);
    
    if (filteredData.length === 0) {
        tableBody.innerHTML = '';
        document.querySelector('.data-table').style.display = 'none';
        document.querySelector('.action-bar').style.display = 'none'; // Hide action bar when empty
        emptyState.style.display = 'block';
        document.getElementById('pagination').style.display = 'none';
        return;
    }
    
    document.querySelector('.data-table').style.display = 'table';
    document.querySelector('.action-bar').style.display = 'flex'; // Show action bar when data exists
    emptyState.style.display = 'none';
    document.getElementById('pagination').style.display = 'flex';
    
    tableBody.innerHTML = pageData.map((pengurus, index) => `
        <tr onclick="window.location.href='validasiregistrasiakunpengurus_pengurusdesa?id=${pengurus.id}'" style="cursor: pointer;">
            <td>${startIndex + index + 1}</td>
            <td>${pengurus.desaWisma}</td>
            <td>${pengurus.namaPengurus}</td>
            <td>${pengurus.noRegistrasi}</td>
            <td>
                <div class="action-buttons">
                    <button class="btn-action btn-delete" onclick="event.stopPropagation(); confirmDelete(${pengurus.id})">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M19 7L18.1327 19.1425C18.0579 20.1891 17.187 21 16.1378 21H7.86224C6.81296 21 5.94208 20.1891 5.86732 19.1425L5 7M10 11V17M14 11V17M15 7V4C15 3.44772 14.5523 3 14 3H10C9.44772 3 9 3.44772 9 4V7M4 7H20" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        Hapus
                    </button>
                </div>
            </td>
        </tr>
    `).join('');
    
    updatePagination();
}

// Function to update pagination
function updatePagination() {
    const totalPages = Math.ceil(filteredData.length / itemsPerPage);
    
    prevBtn.disabled = currentPage === 1;
    nextBtn.disabled = currentPage === totalPages || totalPages === 0;
    
    paginationInfo.textContent = `Halaman ${currentPage} dari ${totalPages || 1}`;
}

// Search functionality
searchInput.addEventListener('input', (e) => {
    const searchTerm = e.target.value.toLowerCase();
    filteredData = pengurusData.filter(pengurus => 
        pengurus.namaPengurus.toLowerCase().includes(searchTerm) ||
        pengurus.desaWisma.toLowerCase().includes(searchTerm) ||
        formatJabatan(pengurus.jabatan).toLowerCase().includes(searchTerm)
    );
    currentPage = 1;
    renderTable();
});

// Pagination buttons
prevBtn.addEventListener('click', () => {
    if (currentPage > 1) {
        currentPage--;
        renderTable();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
});

nextBtn.addEventListener('click', () => {
    const totalPages = Math.ceil(filteredData.length / itemsPerPage);
    if (currentPage < totalPages) {
        currentPage++;
        renderTable();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
});

// Show detail modal
function showDetail(id) {
    const pengurus = pengurusData.find(p => p.id === id);
    if (!pengurus) return;
    
    const detailBody = document.getElementById('detailModalBody');
    detailBody.innerHTML = `
        <div class="detail-grid">
            <div class="detail-item">
                <span class="detail-label">Nama Lengkap</span>
                <span class="detail-value">${pengurus.namaPengurus}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">NIK</span>
                <span class="detail-value">${pengurus.nik}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Email</span>
                <span class="detail-value">${pengurus.email}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">No. Telepon</span>
                <span class="detail-value">${pengurus.noTelepon}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Jabatan</span>
                <span class="detail-value">${formatJabatan(pengurus.jabatan)}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Desa Wisma</span>
                <span class="detail-value">${pengurus.desaWisma}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">No. Registrasi</span>
                <span class="detail-value">${pengurus.noRegistrasi}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Tanggal Registrasi</span>
                <span class="detail-value">${new Date(pengurus.registrationDate).toLocaleDateString('id-ID', { 
                    day: 'numeric', 
                    month: 'long', 
                    year: 'numeric' 
                })}</span>
            </div>
        </div>
    `;
    
    detailModal.classList.add('show');
}

// Confirm delete
function confirmDelete(id) {
    deleteTargetId = id;
    deleteModal.classList.add('show');
}

// Delete pengurus
confirmDeleteBtn.addEventListener('click', () => {
    if (deleteTargetId) {
        pengurusData = pengurusData.filter(p => p.id !== deleteTargetId);
        filteredData = filteredData.filter(p => p.id !== deleteTargetId);
        savePengurusData();
        renderTable();
        deleteModal.classList.remove('show');
        deleteTargetId = null;
    }
});

// Cancel delete
cancelDeleteBtn.addEventListener('click', () => {
    deleteModal.classList.remove('show');
    deleteTargetId = null;
});

// Close modals
closeDetailModal.addEventListener('click', () => {
    detailModal.classList.remove('show');
});

closeRegistrationModal.addEventListener('click', () => {
    registrationModal.classList.remove('show');
    registrationForm.reset();
});

closeSuccessModal.addEventListener('click', () => {
    successModal.classList.remove('show');
});

// Close modal on outside click
[detailModal, deleteModal, registrationModal, successModal].forEach(modal => {
    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            modal.classList.remove('show');
        }
    });
});

// Redirect to registration form page
addAccountBtn.addEventListener('click', () => {
    window.location.href = 'formregistrasipengurus_pengurusdesa';
});

addAccountBtnEmpty.addEventListener('click', () => {
    window.location.href = 'formregistrasipengurus_pengurusdesa';
});

// Cancel form
cancelFormBtn.addEventListener('click', () => {
    registrationModal.classList.remove('show');
    registrationForm.reset();
});

// Toggle password visibility
togglePassword.addEventListener('click', () => {
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        eyeIcon.src = '../assets/icons/eye_open.svg';
    } else {
        passwordInput.type = 'password';
        eyeIcon.src = '../assets/icons/eye_close.svg';
    }
});

toggleConfirmPassword.addEventListener('click', () => {
    if (confirmPasswordInput.type === 'password') {
        confirmPasswordInput.type = 'text';
        eyeIconConfirm.src = '../assets/icons/eye_open.svg';
    } else {
        confirmPasswordInput.type = 'password';
        eyeIconConfirm.src = '../assets/icons/eye_close.svg';
    }
});

// NIK Input Validation
const nikInput = document.getElementById('nik');
nikInput.addEventListener('input', (e) => {
    e.target.value = e.target.value.replace(/[^0-9]/g, '').slice(0, 16);
});

// Phone Number Input Validation
const noTeleponInput = document.getElementById('noTelepon');
noTeleponInput.addEventListener('input', (e) => {
    e.target.value = e.target.value.replace(/[^0-9]/g, '');
});

// Form submission
registrationForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    // Get form values
    const namaLengkap = document.getElementById('namaLengkap').value.trim();
    const nik = document.getElementById('nik').value.trim();
    const email = document.getElementById('email').value.trim();
    const noTelepon = document.getElementById('noTelepon').value.trim();
    const password = passwordInput.value;
    const confirmPassword = confirmPasswordInput.value;
    const jabatan = document.getElementById('jabatan').value;
    const desaWisma = document.getElementById('desaWisma').value;
    
    // Validation
    if (!namaLengkap || !nik || !email || !noTelepon || !password || !confirmPassword || !jabatan || !desaWisma) {
        alert('Mohon lengkapi semua field yang wajib diisi!');
        return;
    }
    
    // Validate NIK
    if (nik.length !== 16) {
        alert('NIK harus 16 digit!');
        return;
    }
    
    // Validate phone number
    if (!noTelepon.startsWith('08')) {
        alert('No. Telepon harus diawali dengan 08!');
        return;
    }
    
    if (noTelepon.length < 10 || noTelepon.length > 13) {
        alert('No. Telepon tidak valid! (10-13 digit)');
        return;
    }
    
    // Validate password length
    if (password.length < 8) {
        alert('Password minimal 8 karakter!');
        return;
    }
    
    // Validate password match
    if (password !== confirmPassword) {
        alert('Password dan Konfirmasi Password tidak sama!');
        return;
    }
    
    // Check if email already exists
    const emailExists = pengurusData.some(p => p.email === email);
    if (emailExists) {
        alert('Email sudah terdaftar! Gunakan email lain.');
        return;
    }
    
    // Check if NIK already exists
    const nikExists = pengurusData.some(p => p.nik === nik);
    if (nikExists) {
        alert('NIK sudah terdaftar! Gunakan NIK lain.');
        return;
    }
    
    // Generate new ID and registration number
    const newId = pengurusData.length > 0 ? Math.max(...pengurusData.map(p => p.id)) + 1 : 1;
    const noRegistrasi = '327627' + String(3270 + newId);
    
    // Create new pengurus object
    const newPengurus = {
        id: newId,
        namaPengurus: namaLengkap,
        nik,
        email,
        noTelepon,
        jabatan,
        desaWisma,
        noRegistrasi,
        registrationDate: new Date().toISOString().split('T')[0]
    };
    
    // Add to data
    pengurusData.push(newPengurus);
    filteredData = [...pengurusData];
    savePengurusData();
    
    // Close registration modal and show success modal
    registrationModal.classList.remove('show');
    successModal.classList.add('show');
    
    // Reset form
    registrationForm.reset();
    
    // Render table
    renderTable();
});

// Email validation
const emailInput = document.getElementById('email');
emailInput.addEventListener('blur', (e) => {
    const email = e.target.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    if (email && !emailRegex.test(email)) {
        alert('Format email tidak valid!');
        emailInput.focus();
    }
});

// Back to selection
backToSelection.addEventListener('click', () => {
    window.location.href = 'registrasi_pengurusdesa';
});

// Check login status on page load
window.addEventListener('DOMContentLoaded', () => {
    const isLoggedIn = sessionStorage.getItem('isLoggedIn');
    const userRole = sessionStorage.getItem('userRole');
    
    if (!isLoggedIn || userRole !== 'pengurus') {
        // Redirect to login if not logged in as pengurus
        // Uncomment this in production
        // window.location.href = '../index.html';
    }
    
    // Initial render
    renderTable();
});

// Make functions globally accessible
window.showDetail = showDetail;
window.confirmDelete = confirmDelete;
// Navigate to validation page for an existing pengurus
function goToValidation(id) {
    window.location.href = `validasiregistrasiakunpengurus_pengurusdesa?id=${id}`;
}
window.goToValidation = goToValidation;
// Sample Data
const sampleData = [
    { id: 1, desaWisma: 'Mawar 1', namaWarga: 'Farhan', noRegistrasi: '3276273271', nik: '3276271234567890', email: 'farhan@email.com', noTelepon: '081234567890', alamat: 'Jl. Mawar No. 10, RT 01/RW 02', registrationDate: '2025-01-15' },
    { id: 2, desaWisma: 'Mawar 2', namaWarga: 'Kurniawan', noRegistrasi: '3276273272', nik: '3276271234567891', email: 'kurniawan@email.com', noTelepon: '081234567891', alamat: 'Jl. Melati No. 15, RT 02/RW 03', registrationDate: '2025-01-16' },
    { id: 3, desaWisma: 'Mawar 2', namaWarga: 'Agus', noRegistrasi: '3276273273', nik: '3276271234567892', email: 'agus@email.com', noTelepon: '081234567892', alamat: 'Jl. Anggrek No. 20, RT 03/RW 04', registrationDate: '2025-01-17' }
];

// Initialize data from localStorage (Using a new key to ensure empty start for user)
let wargaData = JSON.parse(localStorage.getItem('wargaData_fixed')) || [];

// Initial Data for Budi (Requested by User)
const initialBudiData = {
    id: 1,
    namaWarga: "Budi",
    nik: "3276271234560001",
    email: "budi.warga@gmail.com",
    noTelepon: "081234567899",
    desaWisma: "Mawar 1",
    alamat: "Jl. Kenanga No. 5, RT 01/RW 01",
    noRegistrasi: "3276273275",
    registrationDate: new Date().toISOString().split('T')[0]
};

// Check if data is empty, if so add Budi
if (wargaData.length === 0) {
    wargaData.push(initialBudiData);
    localStorage.setItem('wargaData_fixed', JSON.stringify(wargaData));
}

// Ensure Budi exists (in case data was cleared or initialized differently)
const budiExists = wargaData.some(w => w.namaWarga.toLowerCase() === 'budi');
if (!budiExists && wargaData.length > 0) {
    // Optional: Add Budi if missing but other data exists
}

// Save to localStorage
function saveWargaData() {
    localStorage.setItem('wargaData_fixed', JSON.stringify(wargaData));
}

// Check old data key and clear it if exists (optional cleanup)
if (localStorage.getItem('wargaData')) {
    localStorage.removeItem('wargaData');
}

// Pagination variables
let currentPage = 1;
const itemsPerPage = 10;
let filteredData = [...wargaData];

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
    
    tableBody.innerHTML = pageData.map((warga, index) => `
        <tr onclick="window.location.href='validasiregistrasiakunwarga_pengurusdesa?id=${warga.id}'" style="cursor: pointer;">
            <td>${startIndex + index + 1}</td>
            <td>${warga.desaWisma}</td>
            <td>${warga.namaWarga}</td>
            <td>${warga.noRegistrasi}</td>
            <td>
                <div class="action-buttons">
                    <button class="btn-action btn-delete" onclick="event.stopPropagation(); confirmDelete(${warga.id})">
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
    filteredData = wargaData.filter(warga => 
        warga.namaWarga.toLowerCase().includes(searchTerm) ||
        warga.desaWisma.toLowerCase().includes(searchTerm)
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
    const warga = wargaData.find(w => w.id === id);
    if (!warga) return;
    
    const detailBody = document.getElementById('detailModalBody');
    detailBody.innerHTML = `
        <div class="detail-grid">
            <div class="detail-item">
                <span class="detail-label">Nama Lengkap</span>
                <span class="detail-value">${warga.namaWarga}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">NIK</span>
                <span class="detail-value">${warga.nik}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Email</span>
                <span class="detail-value">${warga.email}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">No. Telepon</span>
                <span class="detail-value">${warga.noTelepon}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Desa Wisma</span>
                <span class="detail-value">${warga.desaWisma}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Alamat Lengkap</span>
                <span class="detail-value">${warga.alamat}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">No. Registrasi</span>
                <span class="detail-value">${warga.noRegistrasi}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Tanggal Registrasi</span>
                <span class="detail-value">${new Date(warga.registrationDate).toLocaleDateString('id-ID', { 
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

// Delete warga
confirmDeleteBtn.addEventListener('click', () => {
    if (deleteTargetId) {
        wargaData = wargaData.filter(w => w.id !== deleteTargetId);
        filteredData = filteredData.filter(w => w.id !== deleteTargetId);
        saveWargaData();
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

// Redirect to warga registration form page
addAccountBtn.addEventListener('click', () => {
    window.location.href = 'formregistrasiwarga_pengurusdesa';
});

addAccountBtnEmpty.addEventListener('click', () => {
    window.location.href = 'formregistrasiwarga_pengurusdesa';
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
    const desaWisma = document.getElementById('desaWisma').value;
    const alamat = document.getElementById('alamat').value.trim();
    
    // Validation
    if (!namaLengkap || !nik || !email || !noTelepon || !password || !confirmPassword || !desaWisma || !alamat) {
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
    const emailExists = wargaData.some(w => w.email === email);
    if (emailExists) {
        alert('Email sudah terdaftar! Gunakan email lain.');
        return;
    }
    
    // Check if NIK already exists
    const nikExists = wargaData.some(w => w.nik === nik);
    if (nikExists) {
        alert('NIK sudah terdaftar! Gunakan NIK lain.');
        return;
    }
    
    // Generate new ID and registration number
    const newId = wargaData.length > 0 ? Math.max(...wargaData.map(w => w.id)) + 1 : 1;
    const noRegistrasi = '327627' + String(3270 + newId);
    
    // Create new warga object
    const newWarga = {
        id: newId,
        namaWarga: namaLengkap,
        nik,
        email,
        noTelepon,
        desaWisma,
        alamat,
        noRegistrasi,
        registrationDate: new Date().toISOString().split('T')[0]
    };
    
    // Add to data
    wargaData.push(newWarga);
    filteredData = [...wargaData];
    saveWargaData();
    
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
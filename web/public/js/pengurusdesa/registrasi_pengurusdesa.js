// DOM Elements
const pengurusCard = document.getElementById('pengurusCard');
const wargaCard = document.getElementById('wargaCard');
const accountTypeContainer = document.querySelector('.account-type-container');
const registrationFormContainer = document.getElementById('registrationFormContainer');
const registrationForm = document.getElementById('registrationForm');
const backButton = document.getElementById('backButton');
const cancelButton = document.getElementById('cancelButton');
const formTitle = document.getElementById('formTitle');
const jabatanGroup = document.getElementById('jabatanGroup');
const alamatGroup = document.getElementById('alamatGroup');
const togglePassword = document.getElementById('togglePassword');
const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
const eyeIcon = document.getElementById('eyeIcon');
const eyeIconConfirm = document.getElementById('eyeIconConfirm');
const passwordInput = document.getElementById('password');
const confirmPasswordInput = document.getElementById('confirmPassword');
const successModal = document.getElementById('successModal');
const closeModal = document.getElementById('closeModal');

// Variable to store selected account type
let selectedAccountType = '';

// Event Listeners for Account Type Selection
pengurusCard.addEventListener('click', () => {
    window.location.href = 'registrasitabelpengurus_pengurusdesa';
});

wargaCard.addEventListener('click', () => {
    window.location.href = 'registrasitabelwarga_pengurusdesa';
});

// Show Registration Form
function showRegistrationForm() {
    accountTypeContainer.style.display = 'none';
    registrationFormContainer.style.display = 'block';
    
    // Update form title and fields based on account type
    if (selectedAccountType === 'pengurus') {
        formTitle.textContent = 'Registrasi Akun Pengurus Desa';
        jabatanGroup.style.display = 'block';
        alamatGroup.style.display = 'none';
        document.getElementById('jabatan').required = true;
        document.getElementById('alamat').required = false;
    } else {
        formTitle.textContent = 'Registrasi Akun Warga';
        jabatanGroup.style.display = 'none';
        alamatGroup.style.display = 'block';
        document.getElementById('jabatan').required = false;
        document.getElementById('alamat').required = true;
    }
    
    // Scroll to top
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

// Hide Registration Form
function hideRegistrationForm() {
    registrationFormContainer.style.display = 'none';
    accountTypeContainer.style.display = 'grid';
    registrationForm.reset();
    selectedAccountType = '';
    
    // Scroll to top
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

// Back Button
backButton.addEventListener('click', hideRegistrationForm);

// Cancel Button
cancelButton.addEventListener('click', hideRegistrationForm);

// Toggle Password Visibility
togglePassword.addEventListener('click', () => {
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        eyeIcon.src = '/assets/icons/eye_open.svg';
    } else {
        passwordInput.type = 'password';
        eyeIcon.src = '/assets/icons/eye_close.svg';
    }
});

toggleConfirmPassword.addEventListener('click', () => {
    if (confirmPasswordInput.type === 'password') {
        confirmPasswordInput.type = 'text';
        eyeIconConfirm.src = '/assets/icons/eye_open.svg';
    } else {
        confirmPasswordInput.type = 'password';
        eyeIconConfirm.src = '/assets/icons/eye_close.svg';
    }
});

// NIK Input Validation (only numbers, max 16 digits)
const nikInput = document.getElementById('nik');
nikInput.addEventListener('input', (e) => {
    e.target.value = e.target.value.replace(/[^0-9]/g, '').slice(0, 16);
});

// Phone Number Input Validation (only numbers)
const noTeleponInput = document.getElementById('noTelepon');
noTeleponInput.addEventListener('input', (e) => {
    e.target.value = e.target.value.replace(/[^0-9]/g, '');
});

// Form Submission
registrationForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    // Get form values
    const namaLengkap = document.getElementById('namaLengkap').value.trim();
    const nik = document.getElementById('nik').value.trim();
    const email = document.getElementById('email').value.trim();
    const noTelepon = document.getElementById('noTelepon').value.trim();
    const password = passwordInput.value;
    const confirmPassword = confirmPasswordInput.value;
    
    // Validation
    if (!namaLengkap || !nik || !email || !noTelepon || !password || !confirmPassword) {
        alert('Mohon lengkapi semua field yang wajib diisi!');
        return;
    }
    
    // Validate NIK (must be 16 digits)
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
    
    // Additional validation based on account type
    if (selectedAccountType === 'pengurus') {
        const jabatan = document.getElementById('jabatan').value;
        if (!jabatan) {
            alert('Mohon pilih jabatan!');
            return;
        }
    } else {
        const alamat = document.getElementById('alamat').value.trim();
        if (!alamat) {
            alert('Mohon isi alamat lengkap!');
            return;
        }
    }
    
    // Create user data object
    const userData = {
        namaLengkap,
        nik,
        email,
        noTelepon,
        password,
        accountType: selectedAccountType,
        registrationDate: new Date().toISOString()
    };
    
    if (selectedAccountType === 'pengurus') {
        userData.jabatan = document.getElementById('jabatan').value;
    } else {
        userData.alamat = document.getElementById('alamat').value.trim();
    }
    
    // Store in localStorage (in real app, this would be sent to backend)
    const existingUsers = JSON.parse(localStorage.getItem('registeredUsers') || '[]');
    
    // Check if email already exists
    const emailExists = existingUsers.some(user => user.email === email);
    if (emailExists) {
        alert('Email sudah terdaftar! Gunakan email lain.');
        return;
    }
    
    // Check if NIK already exists
    const nikExists = existingUsers.some(user => user.nik === nik);
    if (nikExists) {
        alert('NIK sudah terdaftar! Gunakan NIK lain.');
        return;
    }
    
    // Add new user
    existingUsers.push(userData);
    localStorage.setItem('registeredUsers', JSON.stringify(existingUsers));
    
    // Show success modal
    showSuccessModal();
    
    // Reset form
    registrationForm.reset();
});

// Show Success Modal
function showSuccessModal() {
    successModal.classList.add('show');
}

// Close Modal
closeModal.addEventListener('click', () => {
    successModal.classList.remove('show');
    hideRegistrationForm();
});

// Close modal when clicking outside
successModal.addEventListener('click', (e) => {
    if (e.target === successModal) {
        successModal.classList.remove('show');
        hideRegistrationForm();
    }
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

// Check login status on page load
window.addEventListener('DOMContentLoaded', () => {
    const isLoggedIn = sessionStorage.getItem('isLoggedIn');
    const userRole = sessionStorage.getItem('userRole');
    
    if (!isLoggedIn || userRole !== 'pengurus') {
        // Redirect to login if not logged in as pengurus
        // Uncomment this in production
        // window.location.href = '../index.html';
    }
});

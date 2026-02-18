// DOM Elements
const registrationForm = document.getElementById('registrationForm');
const backButton = document.getElementById('backButton');
const successModal = document.getElementById('successModal');
const closeSuccessModal = document.getElementById('closeSuccessModal');

// Password toggle elements
const togglePassword = document.getElementById('togglePassword');
const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
const eyeIcon = document.getElementById('eyeIcon');
const eyeIconConfirm = document.getElementById('eyeIconConfirm');
const passwordInput = document.getElementById('password');
const confirmPasswordInput = document.getElementById('confirmPassword');

// Form input elements
const namaLengkapInput = document.getElementById('namaLengkap');
const namaPanggilanInput = document.getElementById('namaPanggilan');
const desaMawarInput = document.getElementById('desaMawar');
const noTeleponInput = document.getElementById('noTelepon');
const nikInput = document.getElementById('nik');
const emailGoogleInput = document.getElementById('emailGoogle');

// Back button functionality
backButton.addEventListener('click', () => {
    window.location.href = 'registrasitabelpengurus_pengurusdesa';
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

// NIK Input Validation - only numbers, max 16 digits
nikInput.addEventListener('input', (e) => {
    e.target.value = e.target.value.replace(/[^0-9]/g, '').slice(0, 16);
});

// Phone Number Input Validation - only numbers
noTeleponInput.addEventListener('input', (e) => {
    e.target.value = e.target.value.replace(/[^0-9]/g, '');
});

// Email validation on blur
emailGoogleInput.addEventListener('blur', (e) => {
    const email = e.target.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    if (email && !emailRegex.test(email)) {
        alert('Format email tidak valid!');
        emailGoogleInput.focus();
    }
});

// Form submission
registrationForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    // Get form values
    const namaLengkap = namaLengkapInput.value.trim();
    const namaPanggilan = namaPanggilanInput.value.trim();
    const desaMawar = desaMawarInput.value.trim();
    const noTelepon = noTeleponInput.value.trim();
    const nik = nikInput.value.trim();
    const emailGoogle = emailGoogleInput.value.trim();
    const password = passwordInput.value;
    const confirmPassword = confirmPasswordInput.value;
    
    // Validation - check all fields are filled
    if (!namaLengkap || !namaPanggilan || !desaMawar || !noTelepon || !nik || !emailGoogle || !password || !confirmPassword) {
        alert('Mohon lengkapi semua field yang wajib diisi!');
        return;
    }
    
    // Validate NIK - must be exactly 16 digits
    if (nik.length !== 16) {
        alert('NIK harus 16 digit!');
        nikInput.focus();
        return;
    }
    
    // Validate phone number - must start with 08 and be 10-13 digits
    if (!noTelepon.startsWith('08')) {
        alert('No. Telepon harus diawali dengan 08!');
        noTeleponInput.focus();
        return;
    }
    
    if (noTelepon.length < 10 || noTelepon.length > 13) {
        alert('No. Telepon tidak valid! (10-13 digit)');
        noTeleponInput.focus();
        return;
    }
    
    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(emailGoogle)) {
        alert('Format email tidak valid!');
        emailGoogleInput.focus();
        return;
    }
    
    // Validate password length - minimum 8 characters
    if (password.length < 8) {
        alert('Password minimal 8 karakter!');
        passwordInput.focus();
        return;
    }
    
    // Validate password match
    if (password !== confirmPassword) {
        alert('Password dan Konfirmasi Password tidak sama!');
        confirmPasswordInput.focus();
        return;
    }
    
    // Get existing data from localStorage for validation
    let pengurusData = JSON.parse(localStorage.getItem('pengurusDesaData')) || [];
    
    // Check if email already exists
    const emailExists = pengurusData.some(p => p.email === emailGoogle);
    if (emailExists) {
        alert('Email sudah terdaftar! Gunakan email lain.');
        emailGoogleInput.focus();
        return;
    }
    
    // Check if NIK already exists
    const nikExists = pengurusData.some(p => p.nik === nik);
    if (nikExists) {
        alert('NIK sudah terdaftar! Gunakan NIK lain.');
        nikInput.focus();
        return;
    }
    
    // Store data temporarily in sessionStorage
    const tempData = {
        namaLengkap: namaLengkap,
        namaPanggilan: namaPanggilan,
        desaMawar: desaMawar,
        noTelepon: noTelepon,
        nik: nik,
        emailGoogle: emailGoogle,
        password: password,
        confirmPassword: confirmPassword
    };
    
    sessionStorage.setItem('tempPengurusData', JSON.stringify(tempData));
    
    // Redirect to validation page
    window.location.href = 'validasiregistrasiakunpengurus_pengurusdesa';
});

// Close success modal
closeSuccessModal.addEventListener('click', () => {
    successModal.classList.remove('show');
});

// Close modal on outside click
successModal.addEventListener('click', (e) => {
    if (e.target === successModal) {
        successModal.classList.remove('show');
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
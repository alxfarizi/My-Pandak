// Fungsi untuk tab Admin/Warga
const usernameInput = document.getElementById('username');
const passwordInput = document.getElementById('password');
const togglePassword = document.getElementById('togglePassword');
const loginForm = document.getElementById('loginForm');
const googleLogin = document.getElementById('googleLogin');

// Toggle password visibility
togglePassword.addEventListener('click', () => {
    const eyeIcon = document.getElementById('eyeIcon');

    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        eyeIcon.src = '/assets/icons/eye_open.svg';
    } else {
        passwordInput.type = 'password';
        eyeIcon.src = '/assets/icons/eye_close.svg';
    }
});

// Submit form
loginForm.addEventListener('submit', (e) => {
    e.preventDefault();
    // Bypass authentication as requested
    window.location.href = '/pengurusdesa/dashboard_pengurusdesa';
});

// Login dengan Google
googleLogin.addEventListener('click', () => {
    alert('Login dengan Google dipilih. Redirect ke halaman autentikasi Google...');
});

// Modal Functions
window.openModal = function(modalId) {
    document.getElementById(modalId).classList.add('show');
};

window.closeModal = function(modalId) {
    document.getElementById(modalId).classList.remove('show');
};

// Close modal on outside click
window.onclick = function(event) {
    if (event.target.classList.contains('modal')) {
        event.target.classList.remove('show');
    }
};

// Handle Forgot Password Form
const formForgotPassword = document.getElementById('formForgotPassword');
if (formForgotPassword) {
    formForgotPassword.addEventListener('submit', function(e) {
        e.preventDefault();
        const email = document.getElementById('forgotEmail').value;

        if (!email.includes('@') || !email.includes('gmail.com')) {
            alert('Mohon gunakan email Google (gmail.com) yang valid!');
            return;
        }

        // Simulate sending OTP/Reset Link
        alert(`Instruksi reset password telah dikirim ke ${email}. Silakan cek kotak masuk email Anda.`);
        closeModal('modalForgotPassword');
        document.getElementById('forgotEmail').value = '';
    });
}

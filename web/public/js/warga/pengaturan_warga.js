document.addEventListener('DOMContentLoaded', function() {
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

    // Toggle Password Visibility
    window.togglePass = function(inputId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById('icon-' + inputId);
        
        if (input.type === 'password') {
            input.type = 'text';
            icon.src = '/assets/icons/eye_open.svg';
        } else {
            input.type = 'password';
            icon.src = '/assets/icons/eye_close.svg';
        }
    };

    // Logout Function
    window.confirmLogout = function() {
        if(confirm('Apakah Anda yakin ingin keluar dari akun?')) {
            sessionStorage.clear();
            window.location.href = 'login_warga';
        }
    };

    // Form Ubah Password
    const formPassword = document.getElementById('formPassword');
    if (formPassword) {
        formPassword.addEventListener('submit', function(e) {
            e.preventDefault();
            const oldPass = document.getElementById('oldPassword').value;
            const newPass = document.getElementById('newPassword').value;
            const confirmPass = document.getElementById('confirmNewPassword').value;

            if (newPass.length < 8) {
                alert('Password baru minimal 8 karakter!');
                return;
            }

            if (newPass !== confirmPass) {
                alert('Konfirmasi password tidak sesuai!');
                return;
            }

            alert('Password berhasil diubah!');
            formPassword.reset();
            closeModal('modalPassword');
        });
    }

    // Form Ubah NIK
    const formNIK = document.getElementById('formNIK');
    const inputNIK = document.getElementById('newNIK');

    if (formNIK) {
        // NIK validation (numbers only)
        inputNIK.addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/[^0-9]/g, '');
        });

        formNIK.addEventListener('submit', function(e) {
            e.preventDefault();
            const nik = inputNIK.value;

            if (nik.length !== 16) {
                alert('NIK harus 16 digit!');
                return;
            }

            alert('Permintaan ubah NIK berhasil dikirim!');
            inputNIK.value = '';
            closeModal('modalNIK');
        });
    }

    // Form Ubah Email
    const formEmail = document.getElementById('formEmail');
    if (formEmail) {
        formEmail.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = document.getElementById('newEmail').value;

            if (!email.includes('@') || !email.includes('gmail.com')) {
                alert('Mohon gunakan email Google (gmail.com) yang valid!');
                return;
            }

            alert('Email berhasil diperbarui!');
            document.getElementById('newEmail').value = '';
            closeModal('modalEmail');
        });
    }
});

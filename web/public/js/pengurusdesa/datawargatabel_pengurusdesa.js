// Simulasi data rumah tangga berdasarkan kepala keluarga
const dataRumahTangga = {
    1: [ // ID Kepala Keluarga: Susilo Indra Prasetio
        { 
            no: 1, 
            desaWisma: 'Mawar 1', 
            namaRumahTangga: 'Reni Budi Utami', 
            noRegistrasi: '3302225010840003' 
        }
    ]
};

// DOM Elements
const tableBody = document.getElementById('tableBody');
const kepalaKeluargaElement = document.getElementById('kepalaKeluarga');

// Fungsi untuk mendapatkan parameter dari URL
function getUrlParameter(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

// Fungsi untuk kembali ke halaman sebelumnya
function goBack() {
    window.location.href = 'datawarga_pengurusdesa';
}

// Fungsi untuk render tabel rumah tangga
function renderTable() {
    // Ambil parameter dari URL
    const wargaId = getUrlParameter('id');
    const namaKepala = decodeURIComponent(getUrlParameter('nama') || '-');
    
    // Set nama kepala keluarga di info card
    kepalaKeluargaElement.textContent = namaKepala;
    
    // Kosongkan tabel
    tableBody.innerHTML = '';
    
    // Ambil data rumah tangga berdasarkan ID
    const rumahTanggaList = dataRumahTangga[wargaId] || [];
    
    // Jika tidak ada data
    if (rumahTanggaList.length === 0) {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td colspan="4" style="text-align: center; padding: 40px; color: #94a3b8;">
                Tidak ada data rumah tangga untuk kepala keluarga ini
            </td>
        `;
        tableBody.appendChild(row);
        return;
    }
    
    // Render data rumah tangga
    rumahTanggaList.forEach((rumahTangga, index) => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${index + 1}</td>
            <td>${rumahTangga.desaWisma}</td>
            <td>${rumahTangga.namaRumahTangga}</td>
            <td>${rumahTangga.noRegistrasi}</td>
        `;
        tableBody.appendChild(row);
    });
}

// Fungsi untuk menambah data - redirect ke halaman form
document.querySelector('.btn-add').addEventListener('click', () => {
    // Ambil parameter dari URL
    const wargaId = getUrlParameter('id');
    const namaKepala = getUrlParameter('nama');
    const desaWisma = getUrlParameter('desa') || 'Mawar 1';
    
    // Redirect ke halaman tambah data dengan membawa parameter
    if (wargaId && namaKepala) {
        window.location.href = `adddatawarga_pengurusdesa?id=${wargaId}&nama=${namaKepala}&desa=${desaWisma}`;
    } else {
        // Jika tidak ada parameter, tetap redirect tapi tanpa parameter
        window.location.href = 'adddatawarga_pengurusdesa';
    }
});

// Render tabel saat halaman dimuat
document.addEventListener('DOMContentLoaded', () => {
    renderTable();
});

// Check login status (opsional)
if (!sessionStorage.getItem('isLoggedIn')) {
    // Redirect ke halaman login jika belum login
    // window.location.href = '../login';
}
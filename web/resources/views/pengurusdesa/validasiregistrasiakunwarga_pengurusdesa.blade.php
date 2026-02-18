@extends('layouts.layout')

@section('content')
<div class="registrasi-akun-container">
    <div class="frame-5">
        <div class="profile-header">
            <h2 class="page-title">Akun Profil Warga</h2>
            <div class="profile-image-container">
                <div class="profile-image-placeholder">
                    <img src="{{ asset('image/mjsp707h-7y80sqq.svg') }}" alt="Profile Placeholder" class="profile-svg">
                </div>
                <p class="add-photo-text">Tambah Foto</p>
            </div>
        </div>

        <div class="profile-details">
            <div class="detail-row">
                <div class="detail-group">
                    <label>Nama Lengkap</label>
                    <div class="detail-value" id="valNamaLengkap">-</div>
                </div>
                <div class="detail-group">
                    <label>Nama Panggilan</label>
                    <div class="detail-value" id="valNamaPanggilan">-</div>
                </div>
            </div>

            <div class="detail-row">
                <div class="detail-group">
                    <label>Desa Mawar</label>
                    <div class="detail-value" id="valDesaMawar">-</div>
                </div>
                <div class="detail-group">
                    <label>No. Telepon</label>
                    <div class="detail-value" id="valNoTelepon">-</div>
                </div>
            </div>

            <div class="detail-row">
                <div class="detail-group">
                    <label>Nomor Induk Keluarga (NIK)</label>
                    <div class="detail-value" id="valNik">-</div>
                </div>
                <div class="detail-group">
                    <label>Email Google</label>
                    <div class="detail-value" id="valEmail">-</div>
                </div>
            </div>

            <div class="detail-row">
                <div class="detail-group">
                    <label>Password</label>
                    <div class="detail-value password-field">
                        <span id="valPassword">********</span>
                        <img src="{{ asset('image/mjsp707h-l91k980.svg') }}" class="visibility-icon" alt="Toggle Visibility">
                    </div>
                </div>
                <div class="detail-group">
                    <label>Konfirmasi Password</label>
                    <div class="detail-value password-field">
                        <span id="valConfirmPassword">********</span>
                        <img src="{{ asset('image/mjsp707h-l91k980.svg') }}" class="visibility-icon" alt="Toggle Visibility">
                    </div>
                </div>
            </div>
        </div>

        <div class="action-section">
            <button class="btn-tetapkan" id="btnTetapkan">Tetapkan Akun</button>
            <button class="btn-kembali" id="backButton" style="background-color: transparent; color: #1a3669; border: 1px solid #1a3669; margin-top: 10px;">Kembali</button>
        </div>
    </div>
</div>

<!-- Success Modal -->
<div class="modal" id="successModal">
    <div class="modal-content">
        <div class="modal-icon success">
            <svg width="60" height="60" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M22 11.08V12C21.9988 14.1564 21.3005 16.2547 20.0093 17.9818C18.7182 19.7088 16.9033 20.9725 14.8354 21.5839C12.7674 22.1953 10.5573 22.1219 8.53447 21.3746C6.51168 20.6273 4.78465 19.2461 3.61096 17.4371C2.43727 15.628 1.87979 13.4881 2.02168 11.3363C2.16356 9.18455 2.99721 7.13631 4.39828 5.49706C5.79935 3.85781 7.69279 2.71537 9.79619 2.24013C11.8996 1.7649 14.1003 1.98232 16.07 2.85999" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M22 4L12 14.01L9 11.01" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>
        <h3 class="modal-title">Berhasil!</h3>
        <p class="modal-message">Akun warga telah berhasil ditetapkan.</p>
        <button class="btn-modal-close" id="closeSuccessModal">Tutup</button>
    </div>
</div>

<link rel="stylesheet" href="{{ asset('css/pengurusdesa/validasiregistrasiakunpengurus_pengurusdesa.css') }}">
<script src="{{ asset('js/pengurusdesa/validasiregistrasiakunwarga_pengurusdesa.js') }}"></script>
@endsection

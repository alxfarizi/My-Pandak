<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('splash');
});

// Pengurus Desa Routes
Route::prefix('pengurusdesa')->group(function () {
    Route::get('/addcatatankeluarga_pengurusdesa', function () { return view('pengurusdesa.addcatatankeluarga_pengurusdesa'); });
    Route::get('/adddatakeluarga_pengurusdesa', function () { return view('pengurusdesa.adddatakeluarga_pengurusdesa'); });
    Route::get('/adddatawarga_pengurusdesa', function () { return view('pengurusdesa.adddatawarga_pengurusdesa'); });
    Route::get('/catatankeluarga_pengurusdesa', function () { return view('pengurusdesa.catatankeluarga_pengurusdesa'); });
    Route::get('/dashboard_pengurusdesa', function () { return view('pengurusdesa.dashboard_pengurusdesa'); });
    Route::get('/datakeluarga_pengurusdesa', function () { return view('pengurusdesa.datakeluarga_pengurusdesa'); });
    Route::get('/datawarga_pengurusdesa', function () { return view('pengurusdesa.datawarga_pengurusdesa'); });
    Route::get('/datawargatabel_pengurusdesa', function () { return view('pengurusdesa.datawargatabel_pengurusdesa'); });
    Route::get('/formregistrasipengurus_pengurusdesa', function () { return view('pengurusdesa.formregistrasipengurus_pengurusdesa'); });
    Route::get('/formregistrasiwarga_pengurusdesa', function () { return view('pengurusdesa.formregistrasiwarga_pengurusdesa'); });
    Route::get('/login_pengurusdesa', function () { return view('pengurusdesa.login_pengurusdesa'); });
    Route::get('/registrasi_pengurusdesa', function () { return view('pengurusdesa.registrasi_pengurusdesa'); });
    Route::get('/registrasitabelpengurus_pengurusdesa', function () { return view('pengurusdesa.registrasitabelpengurus_pengurusdesa'); });
    Route::get('/registrasitabelwarga_pengurusdesa', function () { return view('pengurusdesa.registrasitabelwarga_pengurusdesa'); });
    Route::get('/validasiregistrasiakunpengurus_pengurusdesa', function () { return view('pengurusdesa.validasiregistrasiakunpengurus_pengurusdesa'); });
    Route::get('/validasiregistrasiakunwarga_pengurusdesa', function () { return view('pengurusdesa.validasiregistrasiakunwarga_pengurusdesa'); });
    Route::get('/pengaturan_pengurusdesa', function () { return view('pengurusdesa.pengaturan_pengurusdesa'); });
});

// Warga Routes
Route::prefix('warga')->group(function () {
    Route::get('/login_warga', function () { return view('warga.login_warga'); });
    Route::get('/dashboard_warga', function () { return view('warga.dashboard_warga'); });
    Route::get('/datawarga_warga', function () { return view('warga.datawarga_warga'); });
    Route::get('/adddatawarga_warga', function () { return view('warga.adddatawarga_warga'); });
    Route::get('/datakeluarga_warga', function () { return view('warga.datakeluarga_warga'); });
    Route::get('/adddatakeluarga_warga', function () { return view('warga.adddatakeluarga_warga'); });
    Route::get('/catatankeluarga_warga', function () { return view('warga.catatankeluarga_warga'); });
    Route::get('/addcatatankeluarga_warga', function () { return view('warga.addcatatankeluarga_warga'); });
    Route::get('/pengaturan_warga', function () { return view('warga.pengaturan_warga'); });
});

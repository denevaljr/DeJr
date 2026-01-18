\
@echo off
setlocal EnableExtensions

REM --- One-click build (online) ---
REM Requer: Python instalado (py launcher recomendado). Nao exige pip/pyinstaller no PATH.

cd /d "%~dp0"

echo [1/5] Checando Python...
where py >nul 2>nul
if %errorlevel%==0 (
  set "PY=py"
) else (
  where python >nul 2>nul
  if %errorlevel%==0 (
    set "PY=python"
  ) else (
    echo ERRO: Python nao encontrado. Instale o Python (Windows) e tente de novo.
    pause
    exit /b 1
  )
)

echo [2/5] Criando venv...
%PY% -m venv .venv
if %errorlevel% neq 0 (
  echo ERRO criando venv.
  pause
  exit /b 1
)

set "VENV_PY=%cd%\.venv\Scripts\python.exe"

echo [3/5] Atualizando pip...
"%VENV_PY%" -m pip install --upgrade pip

echo [4/5] Instalando dependencias (online)...
"%VENV_PY%" -m pip install -r requirements.txt
"%VENV_PY%" -m pip install pyinstaller

echo [5/5] Gerando EXE...
"%VENV_PY%" -m PyInstaller --noconfirm --clean --name PsycheVoiceAssistant --windowed main.py

echo.
echo OK! EXE em: dist\PsycheVoiceAssistant\PsycheVoiceAssistant.exe
echo.
pause

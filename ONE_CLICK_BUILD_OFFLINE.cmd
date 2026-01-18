\
@echo off
setlocal EnableExtensions

REM --- One-click build (offline) ---
REM Precisa que a pasta wheelhouse\ ja exista (gerada pelo PREPARE_OFFLINE_WHEELHOUSE.cmd)

cd /d "%~dp0"

if not exist wheelhouse (
  echo ERRO: pasta wheelhouse\ nao existe.
  echo Rode builder\PREPARE_OFFLINE_WHEELHOUSE.cmd em um PC com internet (uma vez).
  pause
  exit /b 1
)

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
set "VENV_PY=%cd%\.venv\Scripts\python.exe"

echo [3/5] Atualizando pip (usando wheelhouse quando possivel)...
"%VENV_PY%" -m pip install --no-index --find-links wheelhouse pip || "%VENV_PY%" -m pip install --upgrade pip

echo [4/5] Instalando dependencias (offline)...
"%VENV_PY%" -m pip install --no-index --find-links wheelhouse -r requirements.txt
"%VENV_PY%" -m pip install --no-index --find-links wheelhouse pyinstaller

echo [5/5] Gerando EXE...
"%VENV_PY%" -m PyInstaller --noconfirm --clean --name PsycheVoiceAssistant --windowed main.py

echo.
echo OK! EXE em: dist\PsycheVoiceAssistant\PsycheVoiceAssistant.exe
echo.
pause

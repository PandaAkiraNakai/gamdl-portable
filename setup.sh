#!/usr/bin/env bash
# Setup de gamdl (descargador AAC de Apple Music) en un PC nuevo.
# Linux Debian/Ubuntu. Uso:
#     git clone <este-repo> && cd gamdl-portable && bash setup.sh
set -e

SUDO=""
[ "$(id -u)" -ne 0 ] && SUDO="sudo"
HERE="$(cd "$(dirname "$0")" && pwd)"

echo ">>> 1/4 Instalando dependencias del sistema (pipx, ffmpeg)..."
$SUDO apt-get update
$SUDO apt-get install -y pipx ffmpeg

echo ">>> 2/4 Instalando gamdl..."
pipx install gamdl 2>/dev/null || pipx upgrade gamdl
pipx ensurepath

echo ">>> 3/4 Generando carpetas y config con las rutas de este usuario..."
mkdir -p "$HOME/gamdl" "$HOME/Música" "$HOME/.gamdl"
sed "s|__HOME__|$HOME|g" "$HERE/config.ini" > "$HOME/.gamdl/config.ini"

echo ">>> 4/4 Verificando cookies..."
if [ -f "$HERE/cookies.txt" ]; then
  cp "$HERE/cookies.txt" "$HOME/gamdl/cookies.txt"
  echo "    OK: cookies.txt copiado a $HOME/gamdl/cookies.txt"
elif [ -f "$HOME/gamdl/cookies.txt" ]; then
  echo "    OK: ya existen cookies en $HOME/gamdl/cookies.txt"
else
  echo
  echo "    ##############################################################"
  echo "    ##  FALTAN LAS COOKIES (necesarias para descargar).         ##"
  echo "    ##  Exporta tu cookies.txt y ponlo en:                      ##"
  echo "    ##      $HOME/gamdl/cookies.txt"
  echo "    ##  Cómo hacerlo: mira la sección 'Cookies' del README.md   ##"
  echo "    ##############################################################"
fi

echo
echo ">>> Dependencias listas. Abre una terminal NUEVA (para el PATH)."
echo ">>> Cuando tengas el cookies.txt en su sitio, prueba:"
echo '       gamdl "https://music.apple.com/us/album/..."'
echo ">>> Las descargas van a: $HOME/Música"

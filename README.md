<div align="center">

# 🎵 gamdl-portable

**Setup portable de [gamdl](https://github.com/glomatico/gamdl) para descargar tu música de Apple Music en AAC 256 kbps.**
Un solo script lo deja todo listo en otro PC Linux Debian/Ubuntu.

![Shell](https://img.shields.io/badge/-Bash-1f1f1f?style=flat-square&logo=gnubash&logoColor=ffff00)
![Apple Music](https://img.shields.io/badge/-Apple%20Music-1f1f1f?style=flat-square&logo=applemusic&logoColor=fa243c)
![FFmpeg](https://img.shields.io/badge/-FFmpeg-1f1f1f?style=flat-square&logo=ffmpeg&logoColor=5cb85c)
![Python](https://img.shields.io/badge/-Python%203.10+-1f1f1f?style=flat-square&logo=python&logoColor=ffff00)

</div>

> [!IMPORTANT]
> **Este repo NO incluye las cookies.** Son tu sesión de Apple Music (≈ credenciales) y no
> deben subirse a GitHub. Las pones tú a mano en el PC nuevo — ver la sección [Cookies](#-cookies-obligatorio).

---

## Contenido

- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [🍪 Cookies (obligatorio)](#-cookies-obligatorio)
- [Uso](#uso)
- [Dónde quedan las descargas](#dónde-quedan-las-descargas)
- [Mantenimiento](#mantenimiento)
- [Notas](#notas)

---

## Requisitos

- Linux Debian/Ubuntu (el script usa `apt`)
- Suscripción activa de Apple Music
- Python 3.10+

## Instalación

```bash
git clone https://github.com/PandaAkiraNakai/gamdl-portable.git
cd gamdl-portable
bash setup.sh
```

El script `setup.sh` es idempotente y hace cuatro cosas:

1. Instala las dependencias del sistema (`pipx`, `ffmpeg`).
2. Instala (o actualiza) `gamdl` vía `pipx`.
3. Crea las carpetas y genera `~/.gamdl/config.ini` con las rutas de tu usuario
   (descargas → `~/Música`).
4. Verifica las cookies y te avisa si faltan (paso siguiente).

Al terminar, **abre una terminal nueva** para que el `PATH` de `pipx` quede activo.

## 🍪 Cookies (obligatorio)

gamdl se autentica con las cookies de tu navegador. Para obtenerlas:

1. En el PC nuevo, abre el navegador e **inicia sesión en https://music.apple.com**.
   Verifica que puedas reproducir una canción **completa**, no solo los 30 s de preview.
2. Instala una extensión que exporte cookies en formato **Netscape**:
   - **Chrome / Brave / Edge:** «Get cookies.txt LOCALLY»
   - **Firefox:** «cookies.txt»
3. Con la pestaña de `music.apple.com` **activa**, abre la extensión y
   **Exporta / Descarga** → obtienes un archivo `cookies.txt`.
4. **Colócalo exactamente en `~/gamdl/cookies.txt`** (es decir,
   `/home/TU_USUARIO/gamdl/cookies.txt`):

   ```bash
   mkdir -p ~/gamdl
   mv ~/Descargas/*cookies*.txt ~/gamdl/cookies.txt
   ```

> [!TIP]
> Si prefieres, copia el `cookies.txt` (≈ 2 KB) desde el PC viejo por USB o `scp`.
> En el PC viejo ya está en `~/gamdl/cookies.txt`.
>
> También puedes dejar el `cookies.txt` en la raíz del repo **antes** de correr
> `setup.sh`: el script lo copiará solo a su sitio. (El `.gitignore` impide subirlo
> por accidente.)

## Uso

```bash
# Catálogo (álbum, canción, artista o playlist):
gamdl "https://music.apple.com/us/album/nombre/1234567890"

# Tu biblioteca personal también funciona (con tus cookies):
gamdl "https://music.apple.com/library/playlist/p.xxxxxxxx"
gamdl "https://music.apple.com/library/albums/l.xxxxxxx"

# Carpeta puntual / sobrescribir lo ya descargado:
gamdl -o "/otra/ruta" "URL"
gamdl --overwrite "URL"
```

## Dónde quedan las descargas

Por defecto, en `~/Música/{artista}/{álbum}/`, con tags y carátula incrustados.
Puedes cambiar la ruta editando `output_path` en `~/.gamdl/config.ini`.

## Mantenimiento

- **Cookies vencidas** (empieza a fallar la descarga): repite la sección
  [🍪 Cookies](#-cookies-obligatorio) y reemplaza `~/gamdl/cookies.txt`.
- **Actualizar gamdl:** `pipx upgrade gamdl`

## Notas

- **Calidad:** AAC 256 kbps (lossy). El lossless ALAC requiere un *wrapper* cuyo login
  Apple bloquea desde máquinas normales — por eso este setup usa AAC.
- **Uso personal:** descarga solo música a la que tienes acceso con tu propia
  suscripción, para tu uso personal. Respeta los términos de servicio de Apple Music.
- Proyecto upstream: [glomatico/gamdl](https://github.com/glomatico/gamdl).

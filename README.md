# gamdl-portable

Setup portable de **gamdl** para descargar música de Apple Music en **AAC** (256 kbps).
Pensado para montarlo rápido en otro PC Linux (Debian/Ubuntu).

> 🔐 **Este repo NO incluye las cookies** (son tu sesión de Apple Music ≈ credenciales y no
> deben subirse a GitHub). Las pones tú a mano en el PC nuevo — ver la sección **Cookies** abajo.

## Requisitos
- Linux Debian/Ubuntu (usa `apt`)
- Suscripción activa de Apple Music
- Python 3.10+

## Instalación en el PC nuevo
```bash
git clone https://github.com/PandaAkiraNakai/gamdl-portable.git
cd gamdl-portable
bash setup.sh
```
El script instala `pipx`, `ffmpeg` y `gamdl`, crea las carpetas y genera
`~/.gamdl/config.ini` con tus rutas (descargas → `~/Música`).
Avisará si faltan las cookies (paso siguiente).

## 🍪 Cookies (OBLIGATORIO — hazlo en el PC nuevo)

gamdl se autentica con las cookies de tu navegador. Para obtenerlas:

1. En el PC nuevo, abre el navegador e **inicia sesión en https://music.apple.com**
   (verifica que puedas reproducir una canción **completa**, no solo 30s).
2. Instala una extensión para exportar cookies en formato **Netscape**:
   - **Chrome / Brave / Edge:** "Get cookies.txt LOCALLY"
   - **Firefox:** "cookies.txt"
3. Con la pestaña de `music.apple.com` **activa**, abre la extensión y
   **Exporta / Descarga** → te da un archivo `cookies.txt`.
4. **Colócalo exactamente en:**
   ```
   ~/gamdl/cookies.txt
   ```
   (es decir `/home/TU_USUARIO/gamdl/cookies.txt`). Crea la carpeta si no existe:
   ```bash
   mkdir -p ~/gamdl
   mv ~/Descargas/*cookies*.txt ~/gamdl/cookies.txt
   ```

> Atajo: si prefieres, copia el `cookies.txt` (2 KB) desde el PC viejo por USB/scp.
> En el PC viejo está en `~/gamdl/cookies.txt`.

## Uso
```bash
# Catálogo (álbum, canción, artista, playlist):
gamdl "https://music.apple.com/us/album/nombre/1234567890"

# Tu biblioteca personal también funciona (con tus cookies):
gamdl "https://music.apple.com/library/playlist/p.xxxxxxxx"
gamdl "https://music.apple.com/library/albums/l.xxxxxxx"

# Carpeta puntual / sobrescribir:
gamdl -o "/otra/ruta" "URL"
gamdl --overwrite "URL"
```
Las descargas quedan en `~/Música/{artista}/{álbum}/`.

## Mantenimiento
- **Cookies vencidas** (empieza a fallar): repite la sección 🍪 Cookies y reemplaza
  `~/gamdl/cookies.txt`.
- **Actualizar gamdl:** `pipx upgrade gamdl`

## Notas
- Calidad: **AAC 256 kbps** (lossy). El lossless ALAC requiere un "wrapper" cuyo login
  Apple bloquea desde máquinas normales — por eso este setup usa AAC.
- Proyecto gamdl: https://github.com/glomatico/gamdl

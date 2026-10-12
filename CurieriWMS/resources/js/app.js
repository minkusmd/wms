// Alpine vine din Livewire (nu se incarca a doua oara); aici doar componentele locale.

/** Fotografia se micsoreaza in telefon (max 1600 px, JPEG) inainte de trimitere: pe internet mobil conteaza. */
async function compressPhoto(file, maxSide = 1600, quality = 0.82) {
    let source = null;
    try {
        source = await createImageBitmap(file, { imageOrientation: 'from-image' });
    } catch {
        source = await new Promise((resolve, reject) => {
            const img = new Image();
            img.onload = () => resolve(img);
            img.onerror = reject;
            img.src = URL.createObjectURL(file);
        });
    }
    const scale = Math.min(1, maxSide / Math.max(source.width, source.height));
    const canvas = document.createElement('canvas');
    canvas.width = Math.round(source.width * scale);
    canvas.height = Math.round(source.height * scale);
    canvas.getContext('2d').drawImage(source, 0, 0, canvas.width, canvas.height);
    const blob = await new Promise((resolve) => canvas.toBlob(resolve, 'image/jpeg', quality));

    return new File([blob], 'foto.jpg', { type: 'image/jpeg' });
}

/** UUID v4 si pe http (crypto.randomUUID cere context securizat). */
function actionUid() {
    const b = crypto.getRandomValues(new Uint8Array(16));
    b[6] = (b[6] & 0x0f) | 0x40;
    b[8] = (b[8] & 0x3f) | 0x80;
    const h = [...b].map((x) => x.toString(16).padStart(2, '0')).join('');

    return `${h.slice(0, 8)}-${h.slice(8, 12)}-${h.slice(12, 16)}-${h.slice(16, 20)}-${h.slice(20)}`;
}

document.addEventListener('alpine:init', () => {
    // un loc de fotografie (unitate/partida): Trimitere in curs -> Salvata (miniatura) / Eroare
    window.Alpine.data('photoSlot', (itemId, unitNo) => ({
        busy: false,
        progress: 0,
        error: null,
        uid: null,

        async take(event) {
            const file = event.target.files[0];
            event.target.value = '';
            if (!file) return;
            if (!navigator.onLine) {
                this.error = 'Fără internet: fotografia nu poate fi trimisă acum.';
                return;
            }
            this.busy = true;
            this.error = null;
            this.progress = 0;
            // acelasi identificator pana la succes: o reincercare nu dubleaza fotografia
            this.uid ??= actionUid();
            try {
                const jpeg = await compressPhoto(file);
                await new Promise((resolve, reject) => {
                    this.$wire.upload('photo', jpeg, resolve, () => reject(new Error('upload')), (e) => {
                        this.progress = e.detail.progress;
                    });
                });
                const saved = await this.$wire.savePhoto(itemId, unitNo, this.uid);
                if (saved) this.uid = null;
            } catch {
                this.error = 'Fotografia nu s-a trimis. Încearcă din nou.';
            } finally {
                this.busy = false;
            }
        },
    }));
});

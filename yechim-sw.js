// Yechim service worker: sahifa va ikonkalarni keshda saqlaydi,
// internet bo'lmasa keshdan beradi (formulalar bo'limi offlayn ishlaydi).
const KESH = "yechim-v1";
const FAYLLAR = [
  "./",
  "yechim.webmanifest",
  "icons/yechim-192.png",
  "icons/yechim-512.png",
  "icons/yechim-maskable.png"
];

self.addEventListener("install", (e) => {
  e.waitUntil(
    caches.open(KESH).then((k) => k.addAll(FAYLLAR)).then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys()
      .then((nomlar) => Promise.all(nomlar.filter((n) => n !== KESH).map((n) => caches.delete(n))))
      .then(() => self.clients.claim())
  );
});

// Tarmoq-birinchi: yangilanishlar darhol yetib boradi, offlaynda kesh ishlaydi.
// API so'rovlari (boshqa origin, POST) ushlanmaydi.
self.addEventListener("fetch", (e) => {
  const url = new URL(e.request.url);
  if (e.request.method !== "GET" || url.origin !== self.location.origin) return;
  e.respondWith(
    fetch(e.request)
      .then((javob) => {
        const nusxa = javob.clone();
        caches.open(KESH).then((k) => k.put(e.request, nusxa));
        return javob;
      })
      .catch(() => caches.match(e.request, { ignoreSearch: true }))
  );
});

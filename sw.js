const VERSION = "gdad-s-river-static-v1",
	staticCacheName = "gdad-s-river";

console.log("installing service worker");

const filesToCache = [
	"/",
	"/assets/images",
	"css/main.css",
	"/about/",
	"/index.html"
]

self.addEventListener("install", function(e){
	e.waitUntil(
		caches.open(cacheName).then(function(cache) {
			return cache.addAll(filesToCache);
		});
	)
});

self.addEventListener("activate", function(e){
	e.waitUntil(
		caches.keys().then(function(cacheNames) {
			return Promise.all(
				cacheNames.filter(function(cacheName){
					return cacheName.startsWith("gdad-s-river-")
						&& cacheName != staticCacheName;
				}).map(function(cacheName){
					return cache.delete(cacheName);
				})
			)
		});
	)
});

self.addEventListener("fetch", function(e){
	e.respondWith(
		caches.match(event.request).then(function(response){
			return response || fetch(e.request);
		})
	)
});
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { VitePWA } from "vite-plugin-pwa";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: "autoUpdate",
      manifest: {
        name: "Unoprix",
        short_name: "Unoprix",
        description: "A simple price per unit measurement calculator.",
        theme_color: "#10b981",
        background_color: "#ffffff",
        display: "standalone",
        scope: "/",
        start_url: "/",
        icons: [
          {
            src: "/icons/icon-192x192.png",
            sizes: "192x192",
            type: "image/png",
          },
          {
            src: "/icons/icon-512x512.png",
            sizes: "512x512",
            type: "image/png",
          },
          {
            src: "/icons/maskable-icon-512x512.png",
            sizes: "512x512",
            type: "image/png",
            purpose: "maskable",
          },
          {
            src: "/icons/apple-touch-icon.png",
            sizes: "180x180",
            type: "image/png",
            purpose: "apple touch icon",
          },
        ],
      },

      // Configuration for the service worker (Workbox)
      workbox: {
        // Ensures that all assets output by the Vite build process are precached
        globPatterns: ["**/*.{js,css,html,woff2,mjs}"], // Adjust if you have other asset types like fonts
        // Optional: Runtime caching for assets not included in the build (e.g., API calls, external images)
        // runtimeCaching: [
        //   {
        //     urlPattern: /^https:\/\/fonts\.googleapis\.com\/.*/i,
        //     handler: 'CacheFirst',
        //     options: {
        //       cacheName: 'google-fonts-cache',
        //       expiration: {
        //         maxEntries: 10,
        //         maxAgeSeconds: 60 * 60 * 24 * 365 // <== 365 days
        //       },
        //       cacheableResponse: {
        //         statuses: [0, 200]
        //       }
        //     }
        //   },
        // ]
      },
    }),
  ],
});

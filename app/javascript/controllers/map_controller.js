import { Controller } from "@hotwired/stimulus";
import L from "leaflet";
import "leaflet.markercluster";

export default class extends Controller {
  static targets = ["mapContainer"];

  connect() {
    this.initializeMap();
    this.loadMarkersWithinBounds();
    this.setupEventListeners();
  }

  initializeMap() {
    this.map = L.map(this.mapContainerTarget, {
      center: [-3.71722, -38.5433], // Coordenadas para Fortaleza
      zoom: 12,
      maxBounds: [
        [-90, -180],
        [90, 180],
      ],
      maxBoundsViscosity: 1.0,
    });

    L.tileLayer(
      "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
      {
        maxZoom: 19,
        minZoom: 2,
        attribution: '© <a href="https://carto.com/attributions">CARTO</a>',
        opacity: 1.0,
      },
    ).addTo(this.map);

    // Inicialize a camada de clustering
    this.markersLayer = L.markerClusterGroup({
      // Defina um estilo para o cluster
      iconCreateFunction: function (cluster) {
        const markers = cluster.getAllChildMarkers();
        const count = markers.length;
        const size = Math.min(40, Math.max(20, count)); // Ajustar o tamanho dependendo da quantidade de marcadores
        return L.divIcon({
          html: `<div style="background-color: rgba(0, 123, 255, 0.7); border-radius: 50%; width: ${size}px; height: ${size}px; line-height: ${size}px; text-align: center; color: white; font-weight: bold;">${count}</div>`,
          className: "leaflet-marker-cluster",
          iconSize: [size, size],
        });
      },
    }).addTo(this.map);
  }

  setupEventListeners() {
    this.map.on("moveend", () => this.loadMarkersWithinBounds());
    this.map.on("zoomend", () => this.loadMarkersWithinBounds());
  }

  loadMarkersWithinBounds() {
    const bounds = this.map.getBounds();
    const zoom = this.map.getZoom();

    if (zoom < 10) return;

    const northEast = bounds.getNorthEast();
    const southWest = bounds.getSouthWest();

    fetch(
      `/api/v1/places?ne_lat=${northEast.lat}&ne_lng=${northEast.lng}&sw_lat=${southWest.lat}&sw_lng=${southWest.lng}`,
    )
      .then((response) => response.json())
      .then((places) => {
        this.clearMarkers(); // Limpar apenas os marcadores
        this.addMarkers(places); // Adicionar novos marcadores
      })
      .catch((error) => console.error("Erro ao carregar os locais:", error));
  }

  clearMarkers() {
    // Limpar apenas os marcadores da camada de clustering
    if (this.markersLayer) {
      this.markersLayer.clearLayers();
    }
  }

  addMarkers(places) {
    places.forEach((place) => {
      const marker = L.marker([place.latitude, place.longitude]);

      // Adicionar o marcador à camada de clustering
      marker.addTo(this.markersLayer);

      const popupContent = `
      <pre>${JSON.stringify(place, null, 2)}</pre>
    `;
      marker.bindPopup(popupContent);
    });
  }
}

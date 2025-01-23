// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus";
import L from "leaflet";

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
        [90, 180]
      ],
      maxBoundsViscosity: 1.0
    });

    L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
      maxZoom: 19,
      minZoom: 2,
      attribution: '© <a href="https://carto.com/attributions">CARTO</a>'
    }).addTo(this.map);
  }

  setupEventListeners() {
    this.map.on('moveend', () => this.loadMarkersWithinBounds());
    this.map.on('zoomend', () => this.loadMarkersWithinBounds());
  }

  loadMarkersWithinBounds() {
    const bounds = this.map.getBounds();
    const northEast = bounds.getNorthEast();
    const southWest = bounds.getSouthWest();

    fetch(`/api/v1/places?ne_lat=${northEast.lat}&ne_lng=${northEast.lng}&sw_lat=${southWest.lat}&sw_lng=${southWest.lng}`)
      .then(response => response.json())
      .then(places => {
        this.clearMarkers();
        this.addMarkers(places);
      })
      .catch(error => console.error('Erro ao carregar os locais:', error));
  }

  clearMarkers() {
    if (this.markersLayer) {
      this.map.removeLayer(this.markersLayer);
    }
    this.markersLayer = L.layerGroup().addTo(this.map);
  }

  
  addMarkers(places) {
    places.forEach((place) => {
      const marker = L.marker([place.latitude, place.longitude]).addTo(this.markersLayer);
      const popupContent = `
        <strong>${place.name}</strong><br>
        <strong>Descrição:</strong> ${place.description}<br>
        <strong>Tipo:</strong> ${place.type}<br>
        <strong>Status:</strong> ${place.status}<br>
        <strong>Endereço:</strong> ${place.info.street_name}, ${place.info.city} - ${place.info.state}, ${place.info.country}<br>
        <strong>CEP:</strong> ${place.info.zip_code}<br>
        <strong>Coordenadas:</strong> ${place.latitude}, ${place.longitude}<br>
        <strong>Criado em:</strong> ${new Date(place.created_at).toLocaleString()}<br>
        <strong>Atualizado em:</strong> ${new Date(place.updated_at).toLocaleString()}
      `;
      marker.bindPopup(popupContent);
    });
  }
}

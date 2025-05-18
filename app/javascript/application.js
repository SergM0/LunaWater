// app/javascript/application.js
import "@hotwired/turbo-rails"
import "controllers"

// Tooltip para las leyendas del gráfico
document.addEventListener("DOMContentLoaded", () => {
    const tooltip = document.getElementById("chart-tooltip");
    const segments = document.querySelectorAll(".chart-segment");

    segments.forEach(segment => {
        segment.addEventListener("mousemove", (event) => {
            tooltip.textContent = segment.getAttribute("data-label");
            tooltip.style.top = `${event.clientY + 15}px`;
            tooltip.style.left = `${event.clientX + 15}px`;
            tooltip.style.display = "block";
        });

        segment.addEventListener("mouseleave", () => {
            tooltip.style.display = "none";
        });
    });
});


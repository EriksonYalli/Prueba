document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form'); // Asegúrate de que tu formulario tenga una etiqueta <form>

    form.addEventListener('submit', function(event) {
        let valid = true;
        let messages = [];

        // Validar nombre comercial
        const comercialName = form['txtComercialName'].value.trim();
        if (!comercialName) {
            valid = false;
            messages.push("El nombre comercial es obligatorio.");
        }

        // Validar nombre genérico
        const genericName = form['txtGenericName'].value.trim();
        if (!genericName) {
            valid = false;
            messages.push("El nombre genérico es obligatorio.");
        }

        // Validar precio de venta
        const psale = form['txtPsale'].value.trim();
        if (!psale || isNaN(psale) || parseFloat(psale) <= 0) {
            valid = false;
            messages.push("El precio de venta debe ser un número positivo.");
        }

        // Validar concentración
        const concentration = form['txtConcentration'].value.trim();
        if (!concentration || isNaN(concentration) || parseFloat(concentration) <= 0) {
            valid = false;
            messages.push("La concentración debe ser un número positivo.");
        }

        // Validar selección de categoría
        const category = form['txtCategory'].value;
        if (!category) {
            valid = false;
            messages.push("Debe seleccionar una categoría.");
        }

        // Validar selección de marca
        const brand = form['txtBrand'].value;
        if (!brand) {
            valid = false;
            messages.push("Debe seleccionar una marca.");
        }

        // Mostrar mensajes de error si hay validaciones fallidas
        if (!valid) {
            event.preventDefault(); // Evita el envío del formulario
            alert(messages.join("\n")); // Muestra los mensajes de error
        }
    });
});
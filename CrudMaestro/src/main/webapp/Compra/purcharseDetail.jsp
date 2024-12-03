<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registrar Compra</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    /* Estilos del menú */
    /* Estilo del menú */
    .menu {
      min-height: 100vh;
      width: 300px;
      background-color: #2D2F36; /* Fondo oscuro */
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      border-right: 1px solid #4A4D57; /* Divisor */
    }

    .menu h5 {
      font-size: 1.25rem;
      font-weight: 600;
      color: #FFFFFF; /* Texto claro */
      padding: 15px;
    }

    .nav-item {
      margin-bottom: 10px;
    }

    .nav-link {
      display: flex;
      align-items: center;
      font-size: 1.1rem;
      color: #8E9098; /* Gris claro */
      padding: 12px 15px;
      border-radius: 5px;
      transition: all 0.3s ease-in-out;
    }

    .nav-link:hover,
    .nav-link.active {
      background-color: #F04E30; /* Fondo hover */
      color: #FFFFFF; /* Texto en hover */
      font-weight: 500;
      text-decoration: none;
    }

    .nav-link i {
      font-size: 1.5rem;
      margin-right: 10px;
      color: #F7A440; /* Icono naranja cálido */
      transition: color 0.3s ease-in-out;
    }

    .nav-link:hover i,
    .nav-link.active i {
      color: #FFFFFF; /* Icono blanco en hover */
    }

    /* Estilo de contenido */
    .content {
      padding: 20px;
      flex-grow: 1;
    }


  </style>
</head>
<body>
<div class="d-flex">
  <!-- Menú vertical -->
  <div class="menu">
    <h5 class="pb-3 border-bottom">K&G Electronic</h5>
    <ul class="nav flex-column">
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center" href="/Compra/WelcomeCompra.jsp">
          <i class="fas fa-home me-2"></i> Inicio
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center" href="/listarCompras">
          <i class="fas fa-tools me-2"></i> Repuestos
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center" href="/ComprasAlmacen">
          <i class="fas fa-shopping-cart me-2"></i> Compra
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center" href="/logout">
          <i class="fas fa-sign-out-alt me-2"></i> Cerrar sesión
        </a>
      </li>
    </ul>
  </div>

  <!-- Contenido principal -->
  <div class="p-4 flex-grow-1 content">
    <div class="container py-5">
      <h2 class="mb-4 text-center">Registrar Compra</h2>
      <form id="purchaseForm">
        <div class="row g-3">
          <form id="purchaseForm">
            <div class="row g-3">
              <!-- Proveedor -->
              <div class="col-md-6">
                <div class="form-floating">
                  <select id="supplier" name="supplierId" class="form-select" required>
                    <option value="" selected>Seleccione un proveedor</option>
                    <c:forEach var="supplier" items="${suppliers}">
                      <option value="${supplier.id}">${supplier.company}</option>
                    </c:forEach>
                  </select>
                  <label for="supplier">Proveedor</label>
                </div>
              </div>

              <!-- Método de Pago -->
              <div class="col-md-6">
                <div class="form-floating">
                  <select id="paymentMethod" name="paymentMethod" class="form-select" required>
                    <option value="Efectivo">Efectivo</option>
                    <option value="Tarjeta">Tarjeta</option>
                    <option value="Transferencia">Transferencia</option>
                  </select>
                  <label for="paymentMethod">Método de Pago</label>
                </div>
              </div>

              <!-- Producto -->
              <div class="col-md-6">
                <div class="form-floating">
                  <select id="product" class="form-select">
                    <option value="" selected>Seleccione un producto</option>
                    <c:forEach var="sparePart" items="${spareParts}">
                      <option value="${sparePart.id}" data-name="${sparePart.name}">
                          ${sparePart.name} - ${sparePart.brandName} - ${sparePart.compatibilityType}
                      </option>
                    </c:forEach>
                  </select>
                  <label for="product">Producto</label>
                </div>
              </div>

              <!-- Precio Unitario -->
              <div class="col-md-3">
                <div class="form-floating">
                  <input type="number" id="priceUnit" class="form-control"
                         min="0" step="0.01" placeholder="Precio Unitario"
                         oninput="validatePrice(this)">
                  <label for="priceUnit">Precio Unitario</label>
                </div>
              </div>

              <!-- Cantidad -->
              <div class="col-md-3">
                <div class="form-floating">
                  <input type="number" id="quantity" class="form-control"
                         min="1" step="1" placeholder="Cantidad"
                         oninput="validateQuantity(this)">
                  <label for="quantity">Cantidad</label>
                </div>
              </div>

              <!-- Botón Agregar Producto -->
              <div class="col-12 text-end">
                <button type="button" class="btn btn-primary" onclick="addProduct()">Agregar Producto</button>
              </div>
            </div>
          </form>
        </div>
      </form>

      <!-- Tabla de Detalles -->
      <div class="mt-5">
        <h4>Detalle de Compra</h4>
        <table class="table table-striped table-hover text-center" id="purchaseDetailsTable">
          <thead class="table-secondary">
          <tr>
            <th>Producto</th>
            <th>Precio Unitario</th>
            <th>Cantidad</th>
            <th>Subtotal</th>
            <th>Acciones</th>
          </tr>
          </thead>
          <tbody></tbody>
        </table>
        <h5 class="text-end">Total: S/. <span id="totalAmount">0</span></h5>
      </div>

      <!-- Botón Registrar Compra -->
      <div class="mt-3 text-end">
        <button type="button" class="btn btn-success" onclick="submitForm()">Registrar Compra</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal para editar producto -->
<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editProductModalLabel">Editar Producto</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="editProductForm">
          <div class="mb-3">
            <label for="editPriceUnit" class="form-label">Precio Unitario</label>
            <input type="number" class="form-control" id="editPriceUnit" step="0.01" min="0">
          </div>
          <div class="mb-3">
            <label for="editQuantity" class="form-label">Cantidad</label>
            <input type="number" class="form-control" id="editQuantity" min="0">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary" id="saveEdit">Guardar Cambios</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

  // Validación para Precio Unitario: Limitar a 2 decimales
  function validatePrice(input) {
    let value = input.value;
    if (value.includes(".")) {
      let decimalPart = value.split(".")[1];
      if (decimalPart.length > 2) {
        // Limita a 2 decimales
        input.value = parseFloat(value).toFixed(2);
      }
    }
  }

  // Validación para Cantidad: Solo permitir números enteros
  function validateQuantity(input) {
    let value = input.value;
    // Reemplazar cualquier carácter no numérico o signo
    input.value = value.replace(/[^0-9]/g, '');
  }

  let totalAmount = 0;
  const selectedProducts = [];

  const swalWithBootstrapButtons = Swal.mixin({
    customClass: {
      confirmButton: "btn btn-success",
      cancelButton: "btn btn-danger"
    },
    buttonsStyling: false,
    didOpen: () => {
      // Agregar margen entre los botones
      const buttons = document.querySelectorAll('.swal2-confirm, .swal2-cancel');
      buttons.forEach(button => {
        button.style.margin = "0 10px"; // Esto agrega margen horizontal
      });
    }
  });

  let currentEditRow = null; // Almacena la fila actual que se está editando

  function addProduct() {
    const productSelect = document.getElementById("product");
    const priceInput = document.getElementById("priceUnit");
    const quantityInput = document.getElementById("quantity");

    const productId = productSelect.value;
    const selectedOption = productSelect.options[productSelect.selectedIndex];
    const productName = selectedOption?.getAttribute("data-name");
    const priceUnit = parseFloat(priceInput.value);
    const quantity = parseInt(quantityInput.value);

    if (!productId || isNaN(priceUnit) || priceUnit <= 0 || isNaN(quantity) || quantity <= 0) {
      Swal.fire("Debe seleccionar un producto y llenar los campos de precio y cantidad correctamente.");
      return;
    }

    if (selectedProducts.some(detail => detail.productId === productId)) {
      Swal.fire({
        icon: "warning",
        title: "Producto duplicado",
        text: "Este producto ya ha sido agregado a la orden.",
        confirmButtonText: "Entendido"
      });
      return;
    }

    Swal.fire({
      title: "¿Está seguro de agregar este producto?",
      icon: "question",
      showCancelButton: true,
      confirmButtonText: "Sí, agregar",
      cancelButtonText: "Cancelar",
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        const subtotal = priceUnit * quantity;

        const tableBody = document.getElementById("purchaseDetailsTable").querySelector("tbody");
        const row = document.createElement("tr");

        const nameCell = document.createElement("td");
        nameCell.textContent = productName;

        const priceCell = document.createElement("td");
        priceCell.textContent = "S/. " + priceUnit.toFixed(2);

        const quantityCell = document.createElement("td");
        quantityCell.textContent = quantity;

        const subtotalCell = document.createElement("td");
        subtotalCell.textContent = "S/. " + subtotal.toFixed(2);

        const actionCell = document.createElement("td");
        const editButton = document.createElement("button");
        editButton.type = "button";
        editButton.className = "btn btn-primary btn-sm me-2";
        editButton.textContent = "Editar";

        // Al abrir el modal para editar
        editButton.onclick = function () {
          openEditModal(row, priceUnit, quantity);
        };

        const deleteButton = document.createElement("button");
        deleteButton.type = "button";
        deleteButton.className = "btn btn-danger btn-sm";
        deleteButton.textContent = "Eliminar";

        deleteButton.onclick = function () {
          removeProduct(row, subtotal);
        };

        actionCell.appendChild(editButton);
        actionCell.appendChild(deleteButton);

        row.appendChild(nameCell);
        row.appendChild(priceCell);
        row.appendChild(quantityCell);
        row.appendChild(subtotalCell);
        row.appendChild(actionCell);

        tableBody.appendChild(row);

        selectedProducts.push({ productId, productName, priceUnit, quantity, subtotal, row });
        totalAmount += subtotal;
        updateTotals();

        // Limpiar campos
        productSelect.value = "";
        priceInput.value = "";
        quantityInput.value = "";

        // Deshabilitar los selectores
        const supplierSelect = document.getElementById("supplier");
        const paymentMethodSelect = document.getElementById("paymentMethod");
        supplierSelect.disabled = true;
        paymentMethodSelect.disabled = true;
      }
    });
  }

  function openEditModal(row) {
    // Obtener la fila y los valores actuales
    currentEditRow = row;
    const priceCell = row.querySelector("td:nth-child(2)");
    const quantityCell = row.querySelector("td:nth-child(3)");

    const currentPrice = parseFloat(priceCell.textContent.replace("S/. ", ""));
    const currentQuantity = parseInt(quantityCell.textContent);

    // Configurar los valores actuales en los inputs del modal
    const editPriceInput = document.getElementById("editPriceUnit");
    const editQuantityInput = document.getElementById("editQuantity");

    editPriceInput.value = currentPrice.toFixed(2);
    editQuantityInput.value = currentQuantity;

    // Mostrar el modal
    const editModal = new bootstrap.Modal(document.getElementById("editProductModal"));
    editModal.show();
  }

  document.getElementById("saveEdit").addEventListener("click", () => {
    // Recuperar los nuevos valores del modal
    const editPriceInput = document.getElementById("editPriceUnit");
    const editQuantityInput = document.getElementById("editQuantity");

    // Ejecutar las validaciones antes de continuar
    validatePrice(editPriceInput);  // Validación para precio
    validateQuantity(editQuantityInput);  // Validación para cantidad

    const newPrice = parseFloat(editPriceInput.value);
    const newQuantity = parseInt(editQuantityInput.value);

    // Validar si los valores son válidos (mayores que 0 y no NaN)
    if (isNaN(newPrice) || newPrice <= 0 || isNaN(newQuantity) || newQuantity <= 0) {
      // Mostrar mensaje de error si los datos no son correctos
      Swal.fire("Precio y cantidad deben ser válidos. Asegúrate de ingresar un precio positivo con hasta dos decimales y una cantidad válida.");
      return; // No continuar si los datos son incorrectos
    }

    // Actualizar la fila correspondiente
    const priceCell = currentEditRow.querySelector("td:nth-child(2)");
    const quantityCell = currentEditRow.querySelector("td:nth-child(3)");
    const subtotalCell = currentEditRow.querySelector("td:nth-child(4)");

    const oldSubtotal = parseFloat(subtotalCell.textContent.replace("S/. ", ""));
    const newSubtotal = newPrice * newQuantity;

    // Actualizar el contenido de las celdas
    priceCell.textContent = "S/. " + newPrice.toFixed(2);
    quantityCell.textContent = newQuantity;
    subtotalCell.textContent = "S/. " + newSubtotal.toFixed(2);

    // Actualizar el total
    totalAmount += newSubtotal - oldSubtotal;
    updateTotals();

    // Actualizar el objeto en selectedProducts
    const productIndex = selectedProducts.findIndex(product => product.row === currentEditRow);
    if (productIndex !== -1) {
      selectedProducts[productIndex].priceUnit = newPrice;
      selectedProducts[productIndex].quantity = newQuantity;
      selectedProducts[productIndex].subtotal = newSubtotal;
    }

    // Cerrar el modal
    const editModal = bootstrap.Modal.getInstance(document.getElementById("editProductModal"));
    editModal.hide();

    // Mostrar mensaje de éxito
    swalWithBootstrapButtons.fire("¡Producto actualizado!", "", "success");
  });



  // Función para eliminar el producto de la tabla
  function removeProduct(row, subtotal) {
    // Eliminar el subtotal del totalAmount
    totalAmount -= subtotal;
    updateTotals();

    // Eliminar la fila de la tabla
    row.remove();

    // Eliminar el producto de la lista selectedProducts
    const index = selectedProducts.findIndex(product => product.subtotal === subtotal);
    if (index !== -1) {
      selectedProducts.splice(index, 1);
    }

    // Mostrar mensaje de eliminación
    swalWithBootstrapButtons.fire("¡Producto eliminado!", "", "success");
  }

  function submitForm() {
    const supplierId = document.getElementById("supplier").value;
    const paymentMethod = document.getElementById("paymentMethod").value;

    if (selectedProducts.length === 0) {
      swalWithBootstrapButtons.fire("No se puede registrar la compra", "Debe agregar al menos un producto.", "warning");
      return;
    }

    // Confirmación de SweetAlert2 con botones personalizados
    swalWithBootstrapButtons.fire({
      title: "¿Está seguro de registrar esta compra?",
      text: "Despues de Registar no podras editar la compra",
      icon: "question",
      showCancelButton: true,
      confirmButtonText: "Sí, registrar",
      cancelButtonText: "Cancelar",
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        // Enviar los datos al servidor
        fetch("/RegistrarCompra", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            supplierId,
            paymentMethod,
            totalAmount,
            products: selectedProducts,
          }),
        })
                .then((response) => {
                  if (response.ok) {
                    swalWithBootstrapButtons.fire("¡Compra registrada!", "", "success").then(() => {
                      window.location.href = "/Compras";
                    });
                  } else {
                    swalWithBootstrapButtons.fire("Error", "Hubo un problema al registrar la compra.", "error");
                  }
                })
                .catch((error) => {
                  console.error("Error:", error);
                  swalWithBootstrapButtons.fire("Error", "Hubo un problema al registrar la compra.", "error");
                });
      } else {
        swalWithBootstrapButtons.fire("La compra no fue registrada", "", "info");
      }
    });
  }

  function updateTotals() {
    document.getElementById("totalAmount").textContent = totalAmount.toFixed(2);
  }
</script>
</body>
</html>
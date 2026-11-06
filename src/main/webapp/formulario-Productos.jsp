<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Inicio"/>
</jsp:include>

<div class="container py-5">
    <div class="col-lg-7 col-xl-6 mx-auto">
        <div class="form-pantalla p-4 p-md-5">

            <!-- atrapa la variable de la request que se llama producto -->
            <h1>${not empty producto? 'Editando Producto' : 'Agregando Nuevo Producto'}</h1>

            <form method="post" action="${pageContext.request.contextPath}/productos">

                <!-- hidden es control oculto para visualizacion-->

                <c:if test="${not empty producto}">
                    <input type="hidden" name="txtIdProducto" id="txtIdProducto" value="${producto.idProducto}">
                </c:if>

                <div class="mb-3">
                    <label for="txtNombre"> Nombre </label>
                    <input type="text" class="form-control" name="txtNombre" id="txtNombre"
                           value="${producto.nombre}"
                           required placeholder="Ingrese el nombre">
                </div>

                <div class="mb-3">
                    <label for="txtDescripcion"> Descripción </label>
                    <input type="text" class="form-control" name="txtDescripcion" id="txtDescripcion"
                           value="${producto.descripcion}"
                           required placeholder="Ingrese la descripción">
                </div>

                <div class="mb-3">
                    <label for="txtUrlImagen"> URL Imagen </label>
                    <input type="text" class="form-control" name="txtUrlImagen" id="txtUrlImagen"
                           value="${producto.urlImagen}"
                           required placeholder="Ingrese la URL de la imagen">
                </div>

                <div class="mb-3">
                    <label for="txtUrlML"> URL Mercado Libre </label>
                    <input type="text" class="form-control" name="txtUrlML" id="txtUrlML"
                           value="${producto.urlML}"
                           required placeholder="Ingrese la URL de Mercado Libre">
                </div>

                <label for="txtPrecio"> Precio </label>
                <div class="input-group mb-4">
                    <span class="input-group-text">$</span>
                    <input type="number" class="form-control" name="txtPrecio" id="txtPrecio"
                           value="${producto.precio}"
                           required placeholder="Ingrese precio del producto">

                    <input type="text" class="form-control" aria-label="Amount (to the nearest dollar)">
                    <span class="input-group-text">.00</span>
                </div>

                <input type="submit" class="btn btn-frambuesa" value="${not empty producto? 'Actualizar' : 'Guardar'}">
                <button type="button" class="btn btn-contorno" onclick="limpiarFormulario(this.form)">Limpiar</button>

            </form>
        </div>
    </div>
</div>

<script>
    // Vacía todos los campos de texto y número (funciona al crear y al editar).
    // No toca el id oculto, así que al editar se sigue actualizando el mismo producto.
    function limpiarFormulario(form) {
        form.querySelectorAll('input[type="text"], input[type="number"]').forEach(function (campo) {
            campo.value = '';
        });
        form.txtNombre.focus();
    }
</script>

<jsp:include page = "footer.jsp"/>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Inicio"/>
</jsp:include>

<style>
    .form-pantalla {
        background-color: #0A0820;
        background-image: repeating-linear-gradient(0deg, rgba(255, 255, 255, .04) 0 1px, transparent 1px 3px);
        border: 3px solid var(--menta);
        border-radius: 6px;
        box-shadow: 0 0 28px rgba(0, 229, 255, .5), inset 0 0 30px rgba(0, 229, 255, .1);
        color: #fff;
    }

    .form-pantalla h1 {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .06em;
        font-size: clamp(1.2rem, 3vw, 1.6rem);
        color: #fff;
        text-shadow: 0 0 10px rgba(0, 229, 255, .8), 2px 2px 0 var(--frambuesa);
        margin: 0 0 1.75rem;
    }

    /* Etiquetas */
    .form-pantalla label {
        display: block;
        margin-bottom: .35rem;
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        font-size: .75rem;
        letter-spacing: .12em;
        text-transform: uppercase;
        color: var(--menta);
    }

    /* Campos */
    .form-pantalla .form-control {
        background-color: #12102A;
        color: #fff;
        border: 2px solid var(--menta);
        border-radius: 0;
        padding: .6rem .8rem;
    }
    .form-pantalla .form-control::placeholder { color: #8d88b8; }
    .form-pantalla .form-control:focus {
        background-color: #12102A;
        color: #fff;
        border-color: var(--frambuesa);
        box-shadow: 0 0 14px rgba(255, 43, 214, .7);
    }
    /* Que el autocompletado del navegador no ponga fondo blanco */
    .form-pantalla .form-control:-webkit-autofill {
        -webkit-box-shadow: 0 0 0 1000px #12102A inset;
        -webkit-text-fill-color: #fff;
    }

    /* Grupo del precio */
    .form-pantalla .input-group-text {
        background-color: #12102A;
        color: var(--manteca);
        font-weight: 700;
        border: 2px solid var(--menta);
        border-radius: 0;
    }

    /* Botones */
    .form-pantalla .btn {
        font-family: "Orbitron", sans-serif;
        text-transform: uppercase;
        letter-spacing: .1em;
        padding: .6rem 1.5rem;
        margin-right: .5rem;
    }
    .form-pantalla .btn-frambuesa { box-shadow: 4px 4px 0 var(--menta); }
    .form-pantalla .btn-contorno { box-shadow: 4px 4px 0 var(--frambuesa); }
</style>

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
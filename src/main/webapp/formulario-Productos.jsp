<%@ page isELIgnored="false" %> .
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Inicio"/>
</jsp:include>

<h1>${not empty producto? 'Editando Producto' : 'Agregando Nuevo Producto'}</h1>

<div class="container" style="margin: auto;">
    <form method="get" action="${pageContext.request.contextPath}/productos">">

        <!-- hidden es control oculto para visualizacion-->

        <c:if test="${not empty producto}">
            <input type="hidden" name="txtIdProducto" id="txtIdProducto" value="${producto.idProducto}">
        </c:if>

        <!-- <input type="hidden" name="txtId" id="txtId"> -->

        <label> Nombre </label>
        <input type="text" name="txtNombre" id="txtNombre" value="${not empty producto? producto.nombre : ''}"
               required placeholder="Ingrese el nombre">

        <br>
        <label> Descripción </label>
        <input type="text" name="txtDescripcion" id="txtDescripcion" value="${not empty producto? producto.descripcion : ''}"
               required placeholder="Ingrese la descripción">

        <br>
        <label> Precio </label>
        <div class="input-group mb-3">
            <span class="input-group-text">$</span>
            <input type="number" name="txtPrecio" id="txtPrecio"
                   value="${not empty producto? producto.precio : ''}"
                   required placeholder="Ingrese su salario base">

            <input type="text" class="form-control" aria-label="Amount (to the nearest dollar)">
            <span class="input-group-text">.00</span>
        </div>

        <input type="submit" value="${not empty producto? 'Actualizar' : 'Guardar'}">
        <input type="submit" value="Limpiar">

    </form>
</div>

<jsp:include page = "footer.jsp"/>
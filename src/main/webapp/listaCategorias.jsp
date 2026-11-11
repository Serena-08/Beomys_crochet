<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Categorías"/>
    <jsp:param name="activa" value="categorias"/>
</jsp:include>

<div class="container py-4">

    <div class="d-flex flex-wrap justify-content-between align-items-end gap-3 mb-5">
        <h1 class="titulo-seccion">Categorías</h1>
        <a href="${pageContext.request.contextPath}/categorias?accion=nuevo" class="btn btn-frambuesa">Agregar categoría</a>
    </div>

    <div class="panel-tabla">
        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th>ID</th>
                <th>Categoría</th>
                <th class="text-end">Acciones</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach items="${lista}" var="cat">
                <tr>
                    <td>${cat.idCategoria}</td>
                    <td><c:out value="${cat.categoria}"/></td>
                    <td class="text-end">
                        <a href="${pageContext.request.contextPath}/categorias?accion=editar&idCategoria=${cat.idCategoria}"
                           class="btn btn-contorno btn-sm">Editar</a>
                        <a href="${pageContext.request.contextPath}/categorias?accion=borrar&idCategoria=${cat.idCategoria}"
                           onclick="return confirm('¿Seguro que querés borrar esta categoría? Sus productos quedarán sin categoría.')"
                           class="btn btn-borrar btn-sm">Borrar</a>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty lista}">
                <tr>
                    <td colspan="3" class="text-center py-4">No existen categorías</td>
                </tr>
            </c:if>

            </tbody>
        </table>
    </div>

</div>

<jsp:include page="footer.jsp"/>
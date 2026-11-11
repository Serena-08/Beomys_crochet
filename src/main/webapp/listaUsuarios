<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Usuarios"/>
    <jsp:param name="activa" value="usuarios"/>
</jsp:include>

<div class="container py-4">

    <div class="d-flex flex-wrap justify-content-between align-items-end gap-3 mb-5">
        <h1 class="titulo-seccion">Usuarios</h1>
        <a href="${pageContext.request.contextPath}/usuarios?accion=nuevo" class="btn btn-frambuesa">Agregar usuario</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
    </c:if>

    <div class="panel-tabla table-responsive">
        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th>ID</th>
                <th>Usuario</th>
                <th>Apellido</th>
                <th>Correo</th>
                <th>Rol</th>
                <th class="text-end">Acciones</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach items="${lista}" var="u">
                <tr>
                    <td>${u.idUsuario}</td>
                    <td><c:out value="${u.nombre}"/></td>
                    <td><c:out value="${u.apellido}"/></td>
                    <td><c:out value="${u.correo}"/></td>
                    <td><c:out value="${u.rol}"/></td>
                    <td class="text-end text-nowrap">
                        <a href="${pageContext.request.contextPath}/usuarios?accion=editar&idUsuario=${u.idUsuario}"
                           class="btn btn-contorno btn-sm">Editar</a>
                        <a href="${pageContext.request.contextPath}/usuarios?accion=borrar&idUsuario=${u.idUsuario}"
                           onclick="return confirm('¿Seguro que querés borrar este usuario?')"
                           class="btn btn-borrar btn-sm">Borrar</a>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty lista}">
                <tr>
                    <td colspan="6" class="text-center py-4">No existen usuarios</td>
                </tr>
            </c:if>

            </tbody>
        </table>
    </div>

</div>

<jsp:include page="footer.jsp"/>
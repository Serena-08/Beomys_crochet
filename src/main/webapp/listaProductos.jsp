<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Productos"/>
    <jsp:param name="activa" value="productos"/>
</jsp:include>

<div class="container py-4">

    <div class="d-flex flex-wrap justify-content-between align-items-end gap-3 mb-5">
        <h1 class="titulo-seccion">Productos</h1>

        <c:if test="${sessionScope.usuario.rol == 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/productos?accion=nuevo" class="btn btn-frambuesa">Agregar producto</a>
        </c:if>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">

        <c:forEach items="${lista}" var="pro">
            <div class="col">
                <article class="producto h-100 d-flex flex-column">

                    <div class="producto__foto">
                        <img src="${pro.urlImagen}" alt="${pro.nombre}" referrerpolicy="no-referrer">
                        <span class="producto__precio">$ ${pro.precio}</span>
                    </div>

                    <div class="d-flex flex-column flex-grow-1 p-3">
                        <h2 class="producto__nombre">${pro.nombre}</h2>
                        <p class="producto__desc">${pro.descripcion}</p>

                        <div class="mt-auto">
                            <a href="${pro.urlML}" target="_blank" rel="noopener" class="btn btn-frambuesa w-100">Ver en Mercado Libre</a>

                            <c:if test="${sessionScope.usuario.rol == 'ADMIN'}">
                                <div class="d-flex gap-2 mt-2">
                                    <a href="${pageContext.request.contextPath}/productos?accion=editar&idProducto=${pro.idProducto}"
                                       class="btn btn-contorno btn-sm flex-fill">Editar</a>
                                    <a href="${pageContext.request.contextPath}/productos?accion=borrar&idProducto=${pro.idProducto}"
                                       class="btn btn-borrar btn-sm flex-fill">Borrar</a>
                                </div>
                            </c:if>
                        </div>
                    </div>

                </article>
            </div>
        </c:forEach>

    </div>

    <c:if test="${empty lista}">
        <div class="vacio text-center p-5">
            No existen registros
        </div>
    </c:if>

</div>

<jsp:include page="footer.jsp"/>

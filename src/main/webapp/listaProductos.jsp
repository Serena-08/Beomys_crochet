<%@ page isELIgnored="false" %> .
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Inicio"/>
</jsp:include>

<h1 Productos </h1>

<c:if test="${!empty sessionScope.usuario}">
    <table>
        <thead>
        <th>Nombre</th>
        <th>Precio</th>
        <th>Descripcion</th>
        <th>urlImagen</th>
        <th>urlML</th>
        </thead>
        <tbody>


        <c:forEach items="${lista}" var="pro">
            <tr>
                <td> ${pro.nombre}</td>
                <td> ${pro.precio}</td>
                <td> ${pro.descripcion}</td>
                <td> ${pro.urlImagen}</td>
                <td> ${pro.urlML}</td>
                <!-- Seria idProducto o idPedido? -->
                <td><a href="{pageContext.request.contextPath}/productos?accion=editar&idProducto=${pro.idProducto}">Editar</a>
                </td>
                <td><a href="{pageContext.request.contextPath}/productos?accion=borrar&idProducto=${pro.idProducto}">Borrar</a>
                </td>
            </tr>
        </c:forEach>

        <c:if test = "${empty lista}">
            <tr colspan = "4">
                <td> No existen registros</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/productos?accion=nuevo">Agregar Empleado</a>

</c:if>

<jsp:include page = "footer.jsp"/>
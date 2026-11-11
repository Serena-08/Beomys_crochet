<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Categoría"/>
    <jsp:param name="activa" value="categorias"/>
</jsp:include>

<div class="container py-5">
    <div class="col-lg-6 col-xl-5 mx-auto">
        <div class="form-pantalla p-4 p-md-5">

            <h1>${categoria.idCategoria > 0 ? 'Editando categoría' : 'Agregando categoría'}</h1>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/categorias">

                <%-- El id solo viaja al editar: con id se actualiza, sin id se crea una nueva --%>
                <c:if test="${categoria.idCategoria > 0}">
                    <input type="hidden" name="txtIdCategoria" id="txtIdCategoria" value="${categoria.idCategoria}">
                </c:if>

                <div class="mb-4">
                    <label for="txtCategoria">Nombre de la categoría</label>
                    <input type="text" class="form-control" name="txtCategoria" id="txtCategoria"
                           value="<c:out value='${categoria.categoria}'/>"
                           required maxlength="145" placeholder="Ej: Amigurumis">
                </div>

                <button type="submit" class="btn btn-frambuesa">${categoria.idCategoria > 0 ? 'Actualizar' : 'Guardar'}</button>
                <a href="${pageContext.request.contextPath}/categorias" class="btn btn-contorno">Cancelar</a>

            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Usuario"/>
    <jsp:param name="activa" value="usuarios"/>
</jsp:include>

<div class="container py-5">
    <div class="col-lg-6 col-xl-5 mx-auto">
        <div class="form-pantalla p-4 p-md-5">

            <h1>${usuarioEditar.idUsuario > 0 ? 'Editando usuario' : 'Agregando usuario'}</h1>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/usuarios">

                <%-- El id solo viaja al editar: con id se actualiza, sin id se crea uno nuevo --%>
                <c:if test="${usuarioEditar.idUsuario > 0}">
                    <input type="hidden" name="txtIdUsuario" id="txtIdUsuario" value="${usuarioEditar.idUsuario}">
                </c:if>

                <div class="mb-3">
                    <label for="txtNombre">Nombre de usuario</label>
                    <input type="text" class="form-control" name="txtNombre" id="txtNombre"
                           value="<c:out value='${usuarioEditar.nombre}'/>"
                           required maxlength="145" placeholder="nombre de usuario">
                </div>

                <div class="mb-3">
                    <label for="txtApellido">Apellido</label>
                    <input type="text" class="form-control" name="txtApellido" id="txtApellido"
                           value="<c:out value='${usuarioEditar.apellido}'/>"
                           required maxlength="145" placeholder="apellido">
                </div>

                <div class="mb-3">
                    <label for="txtCorreo">Correo</label>
                    <input type="email" class="form-control" name="txtCorreo" id="txtCorreo"
                           value="<c:out value='${usuarioEditar.correo}'/>"
                           required maxlength="145" placeholder="correo@ejemplo.com">
                </div>

                <div class="mb-3">
                    <label for="txtClave">Contraseña</label>
                    <input type="password" class="form-control" name="txtClave" id="txtClave"
                           ${usuarioEditar.idUsuario > 0 ? '' : 'required'}
                    minlength="6" maxlength="72"
                    placeholder="${usuarioEditar.idUsuario > 0 ? 'Dejá vacío para no cambiarla' : 'mínimo 6 caracteres'}">
                </div>

                <div class="mb-4">
                    <label for="txtIdRol">Rol</label>
                    <select class="form-select" name="txtIdRol" id="txtIdRol" required>
                        <option value="">Elegí un rol</option>
                        <c:forEach items="${roles}" var="r">
                            <option value="${r.idRol}" ${r.idRol == usuarioEditar.idRol ? 'selected' : ''}>
                            <c:out value="${r.nombre}"/>
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <button type="submit" class="btn btn-frambuesa">${usuarioEditar.idUsuario > 0 ? 'Actualizar' : 'Guardar'}</button>
                <a href="${pageContext.request.contextPath}/usuarios" class="btn btn-contorno">Cancelar</a>

            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Inicio"/>
</jsp:include>


<form method = "POST" action = "login" class="px-4 py-3">
    <div class="mb-3">
        <label for="txtNombre" class="form-label">Nombre de Usuario</label>
        <input type="text" class="form-control" id="txtNombre" name="txtNombre"
               placeholder="nombre de usuario">
    </div>
    <div class="mb-3">
        <label for="txtClave" class="form-label">Contraseña</label>
        <input type="password" class="form-control" id="txtClave" name="txtClave"
               placeholder="Contraseña">
    </div>
    <button type="submit" class="btn btn-primary">Enviar</button>
</form>
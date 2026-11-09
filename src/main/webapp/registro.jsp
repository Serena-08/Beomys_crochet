<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Registro"/>
</jsp:include>

<div class="container py-5">
    <div class="col-md-8 col-lg-5 col-xl-4 mx-auto">
        <div class="login-pantalla p-4 p-md-5">

            <div class="text-center mb-4">
                <!-- ovillo en pixel art -->
                <svg class="login__ovillo" viewBox="0 0 14 12" shape-rendering="crispEdges" aria-hidden="true">
                    <path fill="#FF2BD6"
                          d="M4 0h4v1h-4z M2 1h8v1h-8z M1 2h10v2h-10z M0 4h12v4h-12z M1 8h10v2h-10z M2 10h8v1h-8z M4 11h4v1h-4z M11 10h1v1h-1z M12 11h2v1h-2z"/>
                    <path fill="#00E5FF"
                          d="M3 2h1v1h-1z M4 3h1v1h-1z M5 4h1v1h-1z M6 5h1v1h-1z M7 6h1v1h-1z M8 7h1v1h-1z M1 5h1v1h-1z M2 6h1v1h-1z M3 7h1v1h-1z M4 8h1v1h-1z M5 9h1v1h-1z M6 10h1v1h-1z"/>
                </svg>
                <h1 class="login__titulo">Crear cuenta</h1>
                <p class="login__jp">新規登録</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/registro">
                <div class="mb-3">
                    <label for="txtNombre" class="form-label">Nombre de Usuario</label>
                    <input type="text" class="form-control" id="txtNombre" name="txtNombre"
                           value="<c:out value='${nombre}'/>"
                           required maxlength="145" placeholder="nombre de usuario">
                </div>
                <div class="mb-3">
                    <label for="txtApellido" class="form-label">Apellido</label>
                    <input type="text" class="form-control" id="txtApellido" name="txtApellido"
                           value="<c:out value='${apellido}'/>"
                           required maxlength="145" placeholder="apellido">
                </div>
                <div class="mb-3">
                    <label for="txtCorreo" class="form-label">Correo</label>
                    <input type="email" class="form-control" id="txtCorreo" name="txtCorreo"
                           value="<c:out value='${correo}'/>"
                           required maxlength="145" placeholder="correo@ejemplo.com">
                </div>
                <div class="mb-3">
                    <label for="txtClave" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="txtClave" name="txtClave"
                           required minlength="6" maxlength="72" placeholder="mínimo 6 caracteres">
                </div>
                <div class="mb-4">
                    <label for="txtClave2" class="form-label">Repetir contraseña</label>
                    <input type="password" class="form-control" id="txtClave2" name="txtClave2"
                           required minlength="6" maxlength="72" placeholder="repetí la contraseña">
                </div>
                <button type="submit" class="btn btn-frambuesa w-100">Registrarme</button>
            </form>

            <p class="text-center mt-3 mb-0">
                ¿Ya tenés cuenta?
                <a href="${pageContext.request.contextPath}/login" style="color: var(--menta);">Iniciar sesión</a>
            </p>

        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
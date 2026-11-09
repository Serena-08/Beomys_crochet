<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- Encabezado comun: abre html, head y body. Se cierra en footer.jsp --%>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- el titulo llega como parametro del jsp:include -->
    <title>${empty param.titulo ? 'Beomys Crochet' : param.titulo}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body class="d-flex flex-column min-vh-100">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&family=Orbitron:wght@500;700&family=Rajdhani:wght@500;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

<jsp:include page="/estilos.jsp"/>

</head>
<body class="d-flex flex-column min-vh-100">

<nav class="navbar navbar-expand-lg navbar-dark navbar-beomys">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
            <!-- ovillo en pixel art -->
            <svg viewBox="0 0 14 12" width="42" height="36" shape-rendering="crispEdges" aria-hidden="true">
                <path fill="#FF2BD6"
                      d="M4 0h4v1h-4z M2 1h8v1h-8z M1 2h10v2h-10z M0 4h12v4h-12z M1 8h10v2h-10z M2 10h8v1h-8z M4 11h4v1h-4z M11 10h1v1h-1z M12 11h2v1h-2z"/>
                <path fill="#00E5FF"
                      d="M3 2h1v1h-1z M4 3h1v1h-1z M5 4h1v1h-1z M6 5h1v1h-1z M7 6h1v1h-1z M8 7h1v1h-1z M1 5h1v1h-1z M2 6h1v1h-1z M3 7h1v1h-1z M4 8h1v1h-1z M5 9h1v1h-1z M6 10h1v1h-1z"/>
            </svg>
            <span>
                <span class="brand__nombre">BEOMYS</span>
                <span class="brand__sub">CROCHET<span class="brand__jp">かぎ針編み</span></span>
            </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuPrincipal"
                aria-controls="menuPrincipal" aria-expanded="false" aria-label="Mostrar menú">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="menuPrincipal">
            <ul class="navbar-nav me-auto ms-lg-4">
                <li class="nav-item">
                    <a class="nav-link ${param.activa == 'inicio' ? 'active' : ''}"
                       ${param.activa == 'inicio' ? 'aria-current="page"' : ''}
                    href="${pageContext.request.contextPath}/index.jsp">Inicio<span class="jp">ホーム</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.activa == 'productos' ? 'active' : ''}"
                       ${param.activa == 'productos' ? 'aria-current="page"' : ''}
                    href="${pageContext.request.contextPath}/productos">Productos<span class="jp">商品</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.activa == 'contacto' ? 'active' : ''}"
                       ${param.activa == 'contacto' ? 'aria-current="page"' : ''}
                    href="${pageContext.request.contextPath}/contacto.jsp">Contacto<span class="jp">お問い合わせ</span></a>
                </li>

                <c:if test="${sessionScope.usuario.rol == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/productos?accion=nuevo">Agregar producto<span class="jp">商品追加</span></a>
                    </li>
                </c:if>
            </ul>

            <!-- busca el atributo usuario en la sesión (lo guarda LoginServlet) -->
            <c:choose>
                <c:when test="${not empty sessionScope.usuario}">
                    <span class="hud">
                        <span class="dot"></span>Player 1 <strong><c:out value="${sessionScope.usuario.nombre}"/></strong>
                    </span>
                    <a class="btn btn-sesion btn-sm"
                       href="${pageContext.request.contextPath}/login?accion=salir">Salir</a>
                </c:when>
                <c:otherwise>
                    <span class="hud"><span class="dot dot--off"></span>Invitado</span>
                    <a class="btn btn-sesion btn-sm" href="${pageContext.request.contextPath}/login">&#9654; Ingresar</a>
                    <a class="btn btn-sesion btn-sm" href="${pageContext.request.contextPath}/registro">Registrarse</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<main class="flex-grow-1">
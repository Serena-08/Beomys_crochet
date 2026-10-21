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

<style>
    /* Los nombres de las variables se mantienen para no romper index.jsp ni otras páginas */
    :root {
        --ciruela: #12102A;   /* negro azulado (texto y fondos oscuros) */
        --frambuesa: #FF2BD6; /* magenta neón */
        --menta: #00E5FF;     /* cian neón */
        --manteca: #FFD400;   /* amarillo arcade */
        --papel: #F2F1FF;     /* lavanda muy claro */
        --lima: #7CFF4D;      /* verde "online" */
    }

    body {
        font-family: "Rajdhani", "Noto Sans JP", system-ui, sans-serif;
        font-weight: 500;
        font-size: 1.1rem;
        color: var(--ciruela);
        background-color: var(--papel);
        /* cuadrícula suave, como papel de diseño de niveles */
        background-image:
            linear-gradient(rgba(18, 16, 42, .05) 1px, transparent 1px),
            linear-gradient(90deg, rgba(18, 16, 42, .05) 1px, transparent 1px);
        background-size: 28px 28px;
    }

    /* ---------- Navbar ---------- */
    .navbar-beomys {
        background-color: #0A0820;
        /* líneas de escaneo de monitor retro */
        background-image: repeating-linear-gradient(0deg, rgba(255, 255, 255, .04) 0 1px, transparent 1px 3px);
        border-bottom: 3px solid;
        border-image: linear-gradient(90deg, var(--frambuesa), var(--menta)) 1;
        box-shadow: 0 4px 22px rgba(255, 43, 214, .35);
    }
    .navbar-beomys .navbar-brand {
        display: flex;
        align-items: center;
        gap: .75rem;
        color: #fff;
        line-height: 1;
    }
    .brand__nombre {
        display: block;
        font-family: "Press Start 2P", monospace;
        font-size: .85rem;
        letter-spacing: .05em;
        text-shadow: 0 0 8px var(--menta), 2px 2px 0 var(--frambuesa);
    }
    .brand__sub {
        display: block;
        margin-top: .45rem;
        font-family: "Orbitron", sans-serif;
        font-size: .6rem;
        letter-spacing: .25em;
        color: var(--menta);
    }
    .brand__sub .brand__jp { color: var(--manteca); letter-spacing: .1em; margin-left: .4rem; }

    .navbar-beomys .nav-link {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        font-size: .78rem;
        letter-spacing: .12em;
        text-transform: uppercase;
        line-height: 1.3;
        color: rgba(255, 255, 255, .85);
        border-bottom: 3px solid transparent;
        transition: color .15s ease, text-shadow .15s ease;
    }
    .navbar-beomys .nav-link .jp {
        display: block;
        font-family: "Noto Sans JP", sans-serif;
        font-size: .62rem;
        font-weight: 500;
        letter-spacing: .1em;
        text-transform: none;
        color: var(--menta);
    }
    .navbar-beomys .nav-link:hover,
    .navbar-beomys .nav-link:focus {
        color: var(--menta);
        text-shadow: 0 0 10px rgba(0, 229, 255, .9);
    }
    .navbar-beomys .nav-link.active {
        color: #fff;
        border-bottom-color: var(--frambuesa);
        text-shadow: 0 0 10px rgba(255, 43, 214, .9);
    }
    @media (min-width: 992px) {
        .navbar-beomys .nav-link { text-align: center; }
    }

    .navbar-beomys .navbar-toggler { border-color: var(--menta); }

    /* Panel de jugador (HUD) */
    .hud {
        display: inline-flex;
        align-items: center;
        font-family: "Orbitron", sans-serif;
        font-size: .72rem;
        letter-spacing: .08em;
        text-transform: uppercase;
        color: #fff;
        background: rgba(0, 229, 255, .1);
        border-left: 3px solid var(--menta);
        padding: .3rem .8rem;
        margin-right: 1rem;
    }
    .hud strong { color: var(--manteca); margin-left: .35rem; }
    .dot {
        width: 9px;
        height: 9px;
        border-radius: 50%;
        display: inline-block;
        margin-right: .5rem;
        background: var(--lima);
        box-shadow: 0 0 8px var(--lima);
    }
    .dot--off { background: #6b6b80; box-shadow: none; }

    .btn-sesion {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        font-size: .72rem;
        letter-spacing: .1em;
        text-transform: uppercase;
        border: 2px solid var(--menta);
        color: var(--menta);
        border-radius: 0;
        padding: .35rem 1rem;
    }
    .btn-sesion:hover, .btn-sesion:focus {
        background: var(--menta);
        color: var(--ciruela);
        box-shadow: 0 0 16px rgba(0, 229, 255, .8);
    }

    /* ---------- Botones de la marca (usables en cualquier página) ---------- */
    .btn-frambuesa {
        background: var(--frambuesa);
        border: 2px solid var(--ciruela);
        color: var(--ciruela);
        font-weight: 700;
        letter-spacing: .04em;
        border-radius: 4px;
        box-shadow: 4px 4px 0 var(--ciruela);
    }
    .btn-frambuesa:hover, .btn-frambuesa:focus {
        background: var(--menta);
        border-color: var(--ciruela);
        color: var(--ciruela);
    }
    .btn-contorno {
        border: 2px solid var(--ciruela);
        color: var(--ciruela);
        font-weight: 700;
        letter-spacing: .04em;
        border-radius: 4px;
        background: var(--papel);
        box-shadow: 4px 4px 0 var(--ciruela);
    }
    .btn-contorno:hover {
        background: var(--ciruela);
        color: var(--papel);
    }
</style>
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

                <%-- Solo se muestra con sesión iniciada --%>
                <c:if test="${not empty sessionScope.usuario}">
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
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<main class="flex-grow-1">
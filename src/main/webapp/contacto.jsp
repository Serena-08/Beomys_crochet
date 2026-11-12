<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contacto | Beomys</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Fuentes Google -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@500;700&family=Orbitron:wght@500;700&family=Press+Start+2P&family=Rajdhani:wght@500;700&display=swap" rel="stylesheet">

    <!-- Enlace a tu hoja de estilos global (ajustá la ruta si la tenés en otra carpeta) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
    <%-- Si lo tenés como JSP incluido, usá esta línea en lugar de la de arriba: --%>
    <%-- <jsp:include page="/WEB-INF/estilos.jsp" /> --%>
</head>
<body>


<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Categoría"/>
    <jsp:param name="activa" value="categorias"/>
</jsp:include>


<main class="pantalla-construccion">
    <div class="login-pantalla tarjeta-arcade">

        <span class="badge-nivel">STAGE: CONTACTO</span>

        <h1 class="login__titulo cursor-blink">GENERANDO TERRENO</h1>
        <p class="login__jp">工事中 • EN CONSTRUCCIÓN</p>

        <div class="barra-carga" title="Tejiendo píxeles...">
            <div class="barra-progreso"></div>
        </div>

        <p class="texto-terminal mb-4">
            Nuestros bots tejedores están armando los canales de comunicación. <br>
            Muy pronto vas a poder enviarnos mensajes y pedir tus amigurumis personalizados desde acá.
        </p>

        <a href="${pageContext.request.contextPath}/" class="btn btn-frambuesa w-100">
            &lt; VOLVER AL INICIO
        </a>

    </div>
</main>

<!-- Footer común (descomentar si lo usás) -->
<%-- <jsp:include page="footer.jsp" /> --%>

</body>
</html>
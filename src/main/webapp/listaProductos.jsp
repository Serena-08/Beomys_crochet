<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Productos"/>
    <jsp:param name="activa" value="productos"/>
</jsp:include>

<style>
    .titulo-seccion {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .06em;
        font-size: clamp(1.4rem, 3.5vw, 2rem);
        color: var(--ciruela);
        margin: 0;
    }
    .titulo-seccion::after {
        content: "";
        display: block;
        width: 90px;
        height: 4px;
        margin-top: .6rem;
        background: linear-gradient(90deg, var(--frambuesa), var(--menta));
    }

    /* ---------- Tarjeta ---------- */
    .producto {
        background: #fff;
        color: var(--ciruela);
        border: 3px solid var(--ciruela);
        border-radius: 6px;
        box-shadow: 5px 5px 0 var(--ciruela);
        overflow: hidden;
        transition: transform .15s ease, box-shadow .15s ease;
    }
    .producto:hover {
        transform: translate(-3px, -3px);
        box-shadow: 8px 8px 0 var(--frambuesa);
    }

    /* Marco de tamaño fijo: no depende de la foto */
    .producto__foto {
        position: relative;
        height: 260px;
        border-bottom: 3px solid var(--ciruela);
        overflow: hidden;
    }
    /* La foto llena todo el marco, centrada y recortada en los bordes que sobren */
    .producto__foto img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
        display: block;
    }

    .producto__precio {
        position: absolute;
        top: .75rem;
        right: .75rem;
        background: var(--manteca);
        color: var(--ciruela);
        border: 3px solid var(--ciruela);
        box-shadow: 3px 3px 0 var(--ciruela);
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        padding: .2rem .7rem;
    }

    /* Nombre: siempre ocupa 2 líneas de alto */
    .producto__nombre {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .05em;
        font-size: 1.05rem;
        line-height: 1.3;
        min-height: calc(1.05rem * 1.3 * 2);
        margin-bottom: .5rem;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    /* Descripción: siempre ocupa 3 líneas de alto */
    .producto__desc {
        line-height: 1.5;
        min-height: calc(1.5em * 3);
        margin-bottom: 1rem;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .btn-borrar {
        border: 2px solid #E0224A;
        color: #E0224A;
        font-weight: 700;
        border-radius: 4px;
        background: #fff;
    }
    .btn-borrar:hover, .btn-borrar:focus {
        background: #E0224A;
        color: #fff;
    }

    .vacio {
        background: var(--ciruela);
        color: #fff;
        border: 3px solid var(--menta);
        border-radius: 6px;
        box-shadow: 0 0 24px rgba(0, 229, 255, .35);
    }
</style>

<div class="container py-4">

    <div class="d-flex flex-wrap justify-content-between align-items-end gap-3 mb-5">
        <h1 class="titulo-seccion">Productos</h1>

        <c:if test="${not empty sessionScope.usuario}">
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

                            <c:if test="${not empty sessionScope.usuario}">
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

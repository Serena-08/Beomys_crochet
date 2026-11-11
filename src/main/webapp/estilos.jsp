<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<style>
    /* =====================================================
       VARIABLES Y BASE
       ===================================================== */
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

    /* =====================================================
       BOTONES DE LA MARCA (se usan en todas las páginas)
       ===================================================== */
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

    /* =====================================================
       HEADER (navbar)
       ===================================================== */
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

    /* =====================================================
       FOOTER
       ===================================================== */
    .pie-beomys {
        background-color: #0A0820;
        background-image: repeating-linear-gradient(0deg, rgba(255, 255, 255, .04) 0 1px, transparent 1px 3px);
        border-top: 3px solid;
        border-image: linear-gradient(90deg, var(--frambuesa), var(--menta)) 1;
        box-shadow: 0 -4px 22px rgba(255, 43, 214, .35);
        color: rgba(255, 255, 255, .85);
    }
    .pie-beomys small {
        font-family: "Orbitron", sans-serif;
        font-size: .75rem;
        font-weight: 500;
        letter-spacing: .15em;
        text-transform: uppercase;
    }
    /* cursor parpadeante, estilo terminal */
    .pie-beomys small::after {
        content: "_";
        margin-left: .25rem;
        color: var(--menta);
        text-shadow: 0 0 8px rgba(0, 229, 255, .9);
        animation: pie-cursor 1.1s steps(1) infinite;
    }
    @keyframes pie-cursor { 50% { opacity: 0; } }
    @media (prefers-reduced-motion: reduce) {
        .pie-beomys small::after { animation: none; }
    }

    /* =====================================================
       TÍTULOS DE SECCIÓN (index y lista de productos)
       ===================================================== */
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
    /* Si el título está centrado, la rayita también */
    .text-center .titulo-seccion::after,
    .titulo-seccion.text-center::after {
        margin-left: auto;
        margin-right: auto;
    }

    /* =====================================================
       INDEX
       ===================================================== */
    .hero {
        background-color: #0A0820;
        background-image:
            repeating-linear-gradient(0deg, rgba(255, 255, 255, .04) 0 1px, transparent 1px 3px),
            radial-gradient(circle at 85% 15%, rgba(255, 43, 214, .28), transparent 45%),
            radial-gradient(circle at 8% 90%, rgba(0, 229, 255, .2), transparent 40%);
        color: #fff;
    }
    .hero__titulo {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .04em;
        font-size: clamp(1.9rem, 5vw, 3.1rem);
        line-height: 1.2;
        color: #fff;
    }
    .hero__titulo .resalte {
        color: var(--menta);
        text-shadow: 0 0 14px rgba(0, 229, 255, .8), 3px 3px 0 var(--frambuesa);
    }
    .hero__texto {
        font-size: 1.2rem;
        color: rgba(255, 255, 255, .88);
    }

    /* Tarjetas de categorías */
    .tipo {
        background: #fff;
        color: var(--ciruela);
        border: 3px solid var(--ciruela);
        border-radius: 6px;
        box-shadow: 5px 5px 0 var(--ciruela);
        transition: transform .15s ease, box-shadow .15s ease;
    }
    .tipo:hover, .tipo:focus {
        transform: translate(-3px, -3px);
        box-shadow: 8px 8px 0 var(--frambuesa);
        color: var(--ciruela);
    }
    .tipo h3,
    .valor h3 {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .06em;
    }

    /* Valores */
    .banda-clara { background: #E6E4FF; }
    .valor__icono {
        width: 56px;
        height: 56px;
        background: var(--frambuesa);
        color: var(--ciruela);
        border: 3px solid var(--ciruela);
        box-shadow: 4px 4px 0 var(--ciruela);
        font-family: "Press Start 2P", monospace;
        font-size: 1rem;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1.1rem;
    }

    /* Cierre */
    .cta {
        background: var(--ciruela);
        color: #fff;
        border: 3px solid var(--menta);
        border-radius: 6px;
        box-shadow: 0 0 24px rgba(0, 229, 255, .45);
    }
    .cta .titulo-seccion { color: #fff; }

    /* =====================================================
       LISTA DE PRODUCTOS (tarjetas)
       ===================================================== */
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

    .vacio {
        background: var(--ciruela);
        color: #fff;
        border: 3px solid var(--menta);
        border-radius: 6px;
        box-shadow: 0 0 24px rgba(0, 229, 255, .35);
    }

    /* =====================================================
       LOGIN Y FORMULARIO DE PRODUCTO (panel compartido)
       ===================================================== */
    .login-pantalla,
    .form-pantalla {
        background-color: #0A0820;
        background-image: repeating-linear-gradient(0deg, rgba(255, 255, 255, .04) 0 1px, transparent 1px 3px);
        border: 3px solid var(--menta);
        border-radius: 6px;
        box-shadow: 0 0 28px rgba(0, 229, 255, .5), inset 0 0 30px rgba(0, 229, 255, .1);
        color: #fff;
    }

    /* Encabezado del login */
    .login__ovillo { width: 64px; height: auto; }
    .login__titulo {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .08em;
        font-size: 1.5rem;
        color: #fff;
        text-shadow: 0 0 10px rgba(0, 229, 255, .8), 2px 2px 0 var(--frambuesa);
        margin: .75rem 0 .25rem;
    }
    .login__jp {
        font-size: .85rem;
        letter-spacing: .25em;
        color: var(--manteca);
        margin: 0;
    }

    /* Título del formulario */
    .form-pantalla h1 {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .06em;
        font-size: clamp(1.2rem, 3vw, 1.6rem);
        color: #fff;
        text-shadow: 0 0 10px rgba(0, 229, 255, .8), 2px 2px 0 var(--frambuesa);
        margin: 0 0 1.75rem;
    }

    /* Etiquetas */
    .login-pantalla label,
    .form-pantalla label {
        display: block;
        margin-bottom: .35rem;
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        font-size: .75rem;
        letter-spacing: .12em;
        text-transform: uppercase;
        color: var(--menta);
    }

    /* Campos */
    .login-pantalla .form-control,
    .form-pantalla .form-control {
        background-color: #12102A;
        color: #fff;
        border: 2px solid var(--menta);
        border-radius: 0;
        padding: .6rem .8rem;
    }
    .login-pantalla .form-control::placeholder,
    .form-pantalla .form-control::placeholder { color: #8d88b8; }
    .login-pantalla .form-control:focus,
    .form-pantalla .form-control:focus {
        background-color: #12102A;
        color: #fff;
        border-color: var(--frambuesa);
        box-shadow: 0 0 14px rgba(255, 43, 214, .7);
    }
    /* Que el autocompletado del navegador no ponga fondo blanco */
    .login-pantalla .form-control:-webkit-autofill,
    .form-pantalla .form-control:-webkit-autofill {
        -webkit-box-shadow: 0 0 0 1000px #12102A inset;
        -webkit-text-fill-color: #fff;
    }

    /* Grupo del precio */
    .form-pantalla .input-group-text {
        background-color: #12102A;
        color: var(--manteca);
        font-weight: 700;
        border: 2px solid var(--menta);
        border-radius: 0;
    }

    /* Botones dentro de los paneles */
    .login-pantalla .btn-frambuesa,
    .form-pantalla .btn {
        font-family: "Orbitron", sans-serif;
        text-transform: uppercase;
        letter-spacing: .1em;
    }
    .login-pantalla .btn-frambuesa {
        padding: .65rem 1rem;
        box-shadow: 4px 4px 0 var(--menta);
    }
    .form-pantalla .btn {
        padding: .6rem 1.5rem;
        margin-right: .5rem;
    }
    .form-pantalla .btn-frambuesa { box-shadow: 4px 4px 0 var(--menta); }
    .form-pantalla .btn-contorno { box-shadow: 4px 4px 0 var(--frambuesa); }

        /* =====================================================
       TABLAS DE ADMINISTRACIÓN (categorías)
       ===================================================== */
    .panel-tabla {
        background: #fff;
        color: var(--ciruela);
        border: 3px solid var(--ciruela);
        border-radius: 6px;
        box-shadow: 5px 5px 0 var(--ciruela);
        overflow: hidden;
    }
    .panel-tabla .table { margin-bottom: 0; }
    .panel-tabla .table thead th {
        background: var(--ciruela);
        color: var(--menta);
        font-family: "Orbitron", sans-serif;
        font-size: .75rem;
        letter-spacing: .12em;
        text-transform: uppercase;
        border: 0;
    }
</style>
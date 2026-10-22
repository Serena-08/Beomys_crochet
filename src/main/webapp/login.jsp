<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Inicio"/>
</jsp:include>

<style>
    .login-pantalla {
        background-color: #0A0820;
        background-image: repeating-linear-gradient(0deg, rgba(255, 255, 255, .04) 0 1px, transparent 1px 3px);
        border: 3px solid var(--menta);
        border-radius: 6px;
        box-shadow: 0 0 28px rgba(0, 229, 255, .5), inset 0 0 30px rgba(0, 229, 255, .1);
        color: #fff;
    }

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

    /* Etiquetas */
    .login-pantalla .form-label {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        font-size: .75rem;
        letter-spacing: .12em;
        text-transform: uppercase;
        color: var(--menta);
    }

    /* Campos */
    .login-pantalla .form-control {
        background-color: #12102A;
        color: #fff;
        border: 2px solid var(--menta);
        border-radius: 0;
        padding: .6rem .8rem;
    }
    .login-pantalla .form-control::placeholder { color: #8d88b8; }
    .login-pantalla .form-control:focus {
        background-color: #12102A;
        color: #fff;
        border-color: var(--frambuesa);
        box-shadow: 0 0 14px rgba(255, 43, 214, .7);
    }
    /* Que el autocompletado del navegador no ponga fondo blanco */
    .login-pantalla .form-control:-webkit-autofill {
        -webkit-box-shadow: 0 0 0 1000px #12102A inset;
        -webkit-text-fill-color: #fff;
    }

    .login-pantalla .btn-frambuesa {
        font-family: "Orbitron", sans-serif;
        text-transform: uppercase;
        letter-spacing: .1em;
        padding: .65rem 1rem;
        box-shadow: 4px 4px 0 var(--menta);
    }
</style>

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
                <h1 class="login__titulo">Iniciar sesión</h1>
                <p class="login__jp">ログイン</p>
            </div>

            <form method = "POST" action = "login" class="px-4 py-3">
                <div class="mb-3">
                    <label for="txtNombre" class="form-label">Nombre de Usuario</label>
                    <input type="text" class="form-control" id="txtNombre" name="txtNombre"
                           placeholder="nombre de usuario">
                </div>
                <div class="mb-4">
                    <label for="txtClave" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="txtClave" name="txtClave"
                           placeholder="Contraseña">
                </div>
                <button type="submit" class="btn btn-frambuesa w-100">Enviar</button>
            </form>

        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
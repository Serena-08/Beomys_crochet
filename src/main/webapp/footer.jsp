<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%-- Pie comun: cierra main, body y html abiertos en header.jsp --%>
</main>

<style>
    .pie-beomys {
        background-color: #0A0820;
        /* líneas de escaneo de monitor retro */
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
</style>

<footer class="pie-beomys text-center py-3 mt-auto">
    <div class="container">
        <small>Beomys Crochet - 2026</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>
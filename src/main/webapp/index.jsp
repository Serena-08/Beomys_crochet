<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Inicio"/>
    <jsp:param name="activa" value="inicio"/>
</jsp:include>

<style>
    /* ---------- Portada (banda oscura) ---------- */
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

    /* ---------- Títulos de sección ---------- */
    .titulo-seccion {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .06em;
        font-size: clamp(1.3rem, 3.5vw, 1.9rem);
        color: var(--ciruela);
    }
    .titulo-seccion::after {
        content: "";
        display: block;
        width: 90px;
        height: 4px;
        margin: .7rem auto 0;
        background: linear-gradient(90deg, var(--frambuesa), var(--menta));
    }

    /* ---------- Tarjetas de categorías ---------- */
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
    .tipo h3 {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .06em;
    }

    /* ---------- Valores ---------- */
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
    .valor h3 {
        font-family: "Orbitron", sans-serif;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .06em;
    }

    /* ---------- Cierre ---------- */
    .cta {
        background: var(--ciruela);
        color: #fff;
        border: 3px solid var(--menta);
        border-radius: 6px;
        box-shadow: 0 0 24px rgba(0, 229, 255, .45);
    }
    .cta .titulo-seccion { color: #fff; }
</style>

<!-- ========== PRESENTACIÓN ========== -->
<section class="hero py-5">
    <div class="container text-center py-lg-4">
        <div class="col-lg-9 mx-auto">
            <h1 class="hero__titulo mb-4">Bienvenidos a <span class="resalte">Beomys Crochet</span></h1>
            <p class="hero__texto mb-4">
                En Beomys Crochet, nos dedicamos a crear hermosas piezas de crochet hechas a mano con amor y dedicación.
                Cada producto que ofrecemos es único y refleja la pasión por el arte del crochet. Desde mantas y bufandas
                hasta accesorios y decoraciones, nuestros productos están diseñados para brindar calidez, estilo y un toque
                personal a tu vida. Explora nuestra colección y descubre la belleza del crochet artesanal.
            </p>
            <a href="productos" class="btn btn-frambuesa btn-lg">Explorar la colección</a>
        </div>
    </div>
</section>

<!-- ========== QUÉ VAS A ENCONTRAR ========== -->
<section class="py-5">
    <div class="container">
        <h2 class="titulo-seccion text-center mb-5">Qué vas a encontrar</h2>
        <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4">

            <div class="col">
                <a href="productos" class="tipo card h-100 text-center text-decoration-none p-4">
                    <h3 class="h5 mb-2">Mantas</h3>
                    <p class="mb-0">Abrigo suave para tu cama o tu sillón.</p>
                </a>
            </div>

            <div class="col">
                <a href="productos" class="tipo card h-100 text-center text-decoration-none p-4">
                    <h3 class="h5 mb-2">Bufandas</h3>
                    <p class="mb-0">Calidez y estilo para los días fríos.</p>
                </a>
            </div>

            <div class="col">
                <a href="productos" class="tipo card h-100 text-center text-decoration-none p-4">
                    <h3 class="h5 mb-2">Accesorios</h3>
                    <p class="mb-0">Detalles tejidos para tu día a día.</p>
                </a>
            </div>

            <div class="col">
                <a href="productos" class="tipo card h-100 text-center text-decoration-none p-4">
                    <h3 class="h5 mb-2">Decoraciones</h3>
                    <p class="mb-0">Un toque personal para tu hogar.</p>
                </a>
            </div>

        </div>
    </div>
</section>

<!-- ========== VALORES ========== -->
<section class="banda-clara py-5">
    <div class="container">
        <div class="row g-4 text-center">
            <div class="valor col-md-4">
                <div class="valor__icono">1</div>
                <h3 class="h5">Hecho a mano</h3>
                <p class="mb-0">Cada pieza se teje con tiempo, paciencia y buen hilo.</p>
            </div>
            <div class="valor col-md-4">
                <div class="valor__icono">2</div>
                <h3 class="h5">Único</h3>
                <p class="mb-0">No hay dos piezas iguales: cada una tiene su carácter.</p>
            </div>
            <div class="valor col-md-4">
                <div class="valor__icono">3</div>
                <h3 class="h5">Con dedicación</h3>
                <p class="mb-0">Pasión por el crochet en cada puntada.</p>
            </div>
        </div>
    </div>
</section>

<!-- ========== CIERRE ========== -->
<section class="py-5">
    <div class="container">
        <div class="cta text-center p-4 p-md-5">
            <h2 class="titulo-seccion mb-3">Descubrí la belleza del crochet artesanal</h2>
            <p class="mb-4">Mirá toda la colección y encontrá tu próxima pieza favorita.</p>
            <a href="$productos" class="btn btn-frambuesa btn-lg">Ver productos</a>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp"/>
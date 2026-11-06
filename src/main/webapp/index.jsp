<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Inicio"/>
    <jsp:param name="activa" value="inicio"/>
</jsp:include>


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
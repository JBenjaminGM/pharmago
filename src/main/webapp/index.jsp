<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Pharmago</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg" />
        <jsp:include page="includes/css.jsp" />
    </head>
    <body>
        <jsp:include page="includes/header.jsp" />

        <section class="hero-area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-12 custom-padding-right">
                        <div class="slider-head">
                            <div class="hero-slider">
                                <div class="single-slider"
                                     style="background-image: url(assets/images/banner/banner3.jpg);">
                                </div>
                                <div class="single-slider"
                                     style="background-image: url(assets/images/banner/banner2.jpg);">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="trending-product section" style="margin-top: 12px;">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="section-title">
                            <h2>Oferta</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <c:forEach items="${app_productos_cn_descuento}" var="item">
                        <div class="col-lg-3 col-md-6 col-12">
                            <div class="single-product">
                                <div class="product-image">
                                    <img src="${item.imagen}" alt="#">
                                </div>
                                <div class="product-info">
                                    <span class="category">${item.categoria.nombreCateg}</span>
                                    <h4 class="title">
                                        <a href="javascript:void(0)">${item.nombreProd}</a>
                                    </h4>
                                    <div class="price">
                                        <span>S/${item.precio}</span>
                                    </div>
                                    <a href="producto?accion=detalle&id=${item.idProd}" class="btn btn-primary btn-sm mt-2"> 
                                        <i class="fa fa-shopping-cart"></i>  Agregar al carrito
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <jsp:include page="includes/footer.jsp" />
        <jsp:include page="includes/js.jsp" />

        <script type="text/javascript">
            tns({
                container: '.hero-slider',
                slideBy: 'page',
                autoplay: true,
                autoplayButtonOutput: false,
                mouseDrag: true,
                gutter: 0,
                items: 1,
                nav: false,
                controls: true,
                controlsText: ['<i class="lni lni-chevron-left"></i>', '<i class="lni lni-chevron-right"></i>']
            });

            tns({
                container: '.brands-logo-carousel',
                autoplay: true,
                autoplayButtonOutput: false,
                mouseDrag: true,
                gutter: 15,
                nav: false,
                controls: false,
                responsive: {
                    0: {
                        items: 1
                    },
                    540: {
                        items: 2
                    },
                    768: {
                        items: 5
                    },
                    992: {
                        items: 6
                    }
                }
            });
        </script>
    </body>
</html>
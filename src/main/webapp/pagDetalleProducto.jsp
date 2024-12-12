<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Pharmago - Detalle Producto</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg" />
        <jsp:include page="includes/css.jsp" />
    </head>
    <body>
        <jsp:include page="includes/header.jsp" />
        <jsp:include page="includes/mensaje.jsp" />

        <section class="item-details mt-3">
            <div class="container">
                <div class="top-area">
                    <div class="row align-items-center">
                        <div class="col-lg-6 col-md-12 col-12">
                            <div class="product-images">
                                <main id="gallery">
                                    <div class="main-img">
                                        <img src="${producto.imagen}" id="current" alt="#">
                                    </div>
                                </main>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-12 col-12">
                            <div class="product-info">
                                <h2 class="title">${producto.nombreProd}</h2>
                                <p class="category"><i class="lni lni-tag"></i> Categoria: <a href="javascript:void(0)">${producto.categoria.nombreCateg}</a></p>

                                <c:if test="${producto.porcDesc > 0}">
                                    <h3 class="price">S/${producto.PrecioCnDescuento()}<span style="color: red;">S/${producto.precio}</span></h3>
                                </c:if>

                                <c:if test="${producto.porcDesc == 0}">
                                    <h3 class="price">S/${producto.precio}</h3>
                                </c:if>

                                <form action="carrito" method="post">
                                    <div class="row">
                                        <div class="col-lg-4 col-md-4 col-12">
                                            <div class="form-group color-option">
                                                <label class="title-label" for="size">Stock:</label>
                                                <c:choose>
                                                    <c:when test="${producto.stock > 0}">
                                                        <span class="badge badge-success" style="background-color: #00cc33;">Stock disponible</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-danger" style="background-color: #ff3333">Sin stock</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-12">
                                            <div class="form-group quantity">
                                                <label for="color">Cantidad</label>
                                                <input type="number" min="1" max="${producto.stock}" name="cantidad" class="form-control" required="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bottom-content">
                                        <div class="row align-items-end">
                                            <div class="col-lg-4 col-md-4 col-12">
                                                <div class="button cart-button">
                                                    <input type="hidden" name="accion" value="agregar">
                                                    <input type="hidden" name="id" value="${producto.idProd}">
                                                    <button ${producto.stock <= 0 ? "disabled": ""} type="submit" class="btn" style="width: 100%;" >
                                                        <i class="fa fa-shopping-cart"></i> Agregar al Carrito
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="row align-items-center">
                        <div class="col-lg-12 col-md-12 col-12">
                            <div class="form-group">
                                <div class="farmacia-info d-flex align-items-center">
                                    <img src="${producto.farmacia.logo}" alt="Logo de la farmacia" 
                                         class="farmacia-logo" style="width: 100px; height: 70px; margin-right: 10px;">
                                    <span class="farmacia-name">${producto.farmacia.nombre}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="product-details-info">
                        <div class="single-block">
                            <div class="row">
                                <div class="col-lg-8 col-12">
                                    <div class="info-body custom-responsive-margin">
                                        <h4>Descripción</h4>
                                        <hr />
                                        <p>${producto.descripcion}</p>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-12">
                                    <div class="info-body custom-responsive-margin">
                                        <h4>Envíos</h4>
                                        <hr />
                                        <p>El tiempo de entrega varia según la zona:</p>
                                        <p>En el GAM (Gran Area Metropolitana) la entrega se realizará de 3 a 4 dias habiles despues de realizada la compra</p>
                                        <p>En el resto del pais la entrega se realizará en un máximo de 5 a 6 días hábiles déspues de realizada la compra.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
        </section>


        <jsp:include page="includes/footer.jsp" />
        <jsp:include page="includes/js.jsp" />
    </script>
</body>
</html>
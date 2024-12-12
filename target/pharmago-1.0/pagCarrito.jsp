<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Pharmago - Carrito</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg" />
        <jsp:include page="includes/css.jsp" />
    </head>
    <body>
        <jsp:include page="includes/header.jsp" />
        <jsp:include page="includes/mensaje.jsp" />

        <section class="h-100 h-custom" style="background-color: #eee;">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col">
                        <h3 class="text-center">
                            <div class="section-title">
                                <h2>Mi Carrito</h2>
                            </div>
                        </h3>
                        <div class="card">
                            <div class="card-body p-4">
                                <c:if test="${sessionScope.carrito == null || sessionScope.carrito.isEmpty()}">
                                    <div class="row mt-2">
                                        <div class="text-center" >
                                            <img src="assets/images/cart.svg" /> <br />
                                            <strong>Tu carrito está vacío</strong><br />
                                            <span>Agrega productos y da el primer paso para iniciar tu compra.</span>
                                            <br />    <br />
                                            <a href="index.jsp" class="btn btn-primary btn-sm">Ir a pagina principal</a>
                                            <br />  
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test="${sessionScope.carrito != null && sessionScope.carrito.size() > 0}">
                                    <div class="row">

                                        <div class="col-lg-7">
                                            <h5 class="mb-3"><a href="index.jsp" class="text-body"><i
                                                        class="fas fa-long-arrow-alt-left me-2"></i>Continuar comprado</a></h5>
                                            <hr>

                                            <c:forEach items="${sessionScope.carrito}" var="item" varStatus="loop">

                                                <div class="card mb-3">
                                                    <div class="card-body">
                                                        <div class="d-flex justify-content-between">
                                                            <div class="d-flex flex-row align-items-center">
                                                                <div>
                                                                    <img
                                                                        src="${item.producto.imagen}"
                                                                        class="img-fluid rounded-3" alt="Shopping item" style="width: 65px;">
                                                                </div>
                                                                <div class="ms-3" >
                                                                    <h5 style="font-size: 15px;">${item.producto.nombreProd}</h5>
                                                                </div>
                                                            </div>
                                                            <div class="d-flex flex-row align-items-center">
                                                                <div style="width: 50px;">
                                                                    <h5 class="fw-normal mb-0" style="font-size: 15px;">${item.cantidad}</h5>
                                                                </div>
                                                                <div style="width: 80px;">
                                                                    <h5 class="mb-0" style="font-size: 15px;">S/<fmt:formatNumber value="${item.producto.PrecioCnDescuento()}" minFractionDigits="2" maxFractionDigits="2"/></h5>
                                                                </div>
                                                                <div style="width: 80px;">
                                                                    <h5 class="mb-0" style="font-size: 15px;">S/<fmt:formatNumber value="${item.Importe()}" minFractionDigits="2" maxFractionDigits="2"/></h5>
                                                                </div>
                                                                <a href="carrito?accion=eliminar&indice=${loop.index}" style="color: #cecece;" title="Quitar del carrito">
                                                                    <i class="fas fa-trash-alt"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                        </div>
                                        <div class="col-lg-5">
                                            <h5 class="mb-3">Resumen Pedido</h5>
                                            <hr />
                                            <div class="card rounded-3">
                                                <form action="transacion">
                                                    <div class="card-body">

                                                        <p class="small mb-2">Información de Envío</p>
                                                        <div class="form-group">
                                                            <label for="direccionEnvio" class="form-label">Dirección de Envío: <span style="color: red;">(*)</span></label>
                                                            <input type="text" id="direccionEnvio" name="direccionEnvio" class="form-control" placeholder="Ingresa tu dirección de envío" required="">
                                                        </div>
                                                        <div class="form-group mt-3">
                                                            <label for="referenciaEnvio" class="form-label">Referencia de Envío: <span style="color: red;">(*)</span></label>
                                                            <input type="text" id="referenciaEnvio" name="referenciaEnvio" class="form-control" placeholder="Ej: cerca al parque principal" required="">
                                                        </div>
                                                        <div class="form-group mt-3">
                                                            <label for="detalleAdicional" class="form-label">Detalle Adicional: <span style="font-style: italic;">(Opcional)</span></label>
                                                            <textarea id="detalleAdicional" name="detalleAdicional" class="form-control" rows="3" placeholder="Comentarios adicionales para el envío"></textarea>
                                                        </div>

                                                        <hr class="my-4">

                                                        <!-- Métodos de Pago -->
                                                        <p class="small mb-2">Métodos de Pago</p>
                                                        <a href="#!" title="PayPal">
                                                            <i class="fab fa-cc-paypal fa-2x"></i>
                                                        </a>

                                                        <hr class="my-4">
                                                        <div class="d-flex justify-content-between">
                                                            <p class="mb-2">Total</p>
                                                            <p class="mb-2" style="font-weight: bold; font-size: 20px;">
                                                                S/<fmt:formatNumber value="${total}" minFractionDigits="2" maxFractionDigits="2"/>
                                                            </p>
                                                        </div>

                                                        <input type="hidden" name="accion" value="autorizar">
                                                        <button type="submit"  class="myButton0a">
                                                            <span class="paypal1">Pay</span><span class="paypal2">Pal</span><span class="paypal3"></span>
                                                        </button>
                                                        <!--
                                                           <a href="transacion?accion=autorizar" class="myButton0a">
                                                               <span class="paypal1">Pay</span><span class="paypal2">Pal</span><span class="paypal3"></span>
                                                           </a>
                                                        -->
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="includes/footer.jsp" />
        <jsp:include page="includes/js.jsp" />
    </script>
</body>
</html>
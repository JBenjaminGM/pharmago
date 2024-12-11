<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Pharmago - Busqueda</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg" />
        <jsp:include page="includes/css.jsp" />
    </head>
    <body>
        <jsp:include page="includes/header.jsp" />
         <jsp:include page="includes/mensaje.jsp" />

        <section class="trending-product section" style="margin-top: 12px;">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="section-title">
                            <h2>${titulo}</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <c:forEach items="${productos}" var="item">
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
                        z            <a href="producto?accion=detalle&id=${item.idProd}" class="btn btn-primary btn-sm mt-2"> 
                                        <i class="fa fa-shopping-cart"></i>  Agregar al carrito
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${msg_error != null}">
                        <div class="alert alert-primary" role="alert">
                           ${msg_error}
                        </div>
                    </c:if>
                </div>
            </div>
        </section>


        <jsp:include page="includes/footer.jsp" />
        <jsp:include page="includes/js.jsp" />
    </script>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="header navbar-area">
    <div class="topbar">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-4 col-md-4 col-12">
                    <div class="top-left">
                        <ul class="menu-top-link">
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-12">
                </div>
                <div class="col-lg-4 col-md-4 col-12">
                    <div class="top-end">
                        <c:if test="${sessionScope.usuario != null}">
                            <div class="user">
                                <i class="lni lni-user"></i>
                                Hola! ${sessionScope.usuario.nombres}
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.usuario == null}">
                            <ul class="user-login">
                                <li>
                                    <a href="pagLogin.jsp">Login</a>
                                </li>
                                <li>
                                    <a href="auth?accion=new_account">Registro</a>
                                </li>
                            </ul>
                        </c:if>
                        <c:if test="${sessionScope.usuario != null}">
                            <a href="auth?accion=logout" class="btn btn-primary btn-sm">
                                <i class="fa fa-sign-out-alt"></i> Cerrar Sesión
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="header-middle">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-3 col-md-3 col-7">
                    <a class="navbar-brand" href="index.jsp">
                        <img src="assets/images/logo.png" alt="Logo" style="height: 50px; width: 100px;">
                    </a>
                </div>
                <div class="col-lg-5 col-md-7 d-xs-none">
                    <div class="main-menu-search">
                        <form action="producto" method="get">
                            <div class="navbar-search search-style-5">
                                <div class="search-input">
                                    <input type="text" placeholder="Buscar..." name="s" required="" value="${s}">
                                </div>
                                <div class="search-btn">
                                    <input type="hidden" name="accion" value="search">
                                    <button type="submit"><i class="lni lni-search-alt"></i></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-4 col-md-2 col-5">
                    <div class="middle-right-area">
                        <div class="nav-hotline">
                        </div>
                        <div class="navbar-cart">
                            <div class="cart-items">
                                <a href="carrito?accion=listar" class="main-btn">
                                    <i class="lni lni-cart"></i>
                                    <span class="total-items">${sessionScope.carrito!= null ? sessionScope.carrito.size(): 0}</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8 col-md-6 col-12">
                <div class="nav-inner">
                    <div class="mega-category-menu">
                        <!--- 
                        <span class="cat-button"><i class="lni lni-menu"></i>Categorias</span>
                        <ul class="sub-category">
                        <c:forEach items="${app_categorias}" var="item">
                            <li>
                                <a href="producto?accion=categoria&id=${item.idCateg}">${item.nombreCateg}</a>
                            </li>
                        </c:forEach>
                    </ul>
                        -->
                    </div>

                    <nav class="navbar navbar-expand-lg">
                        <button class="navbar-toggler mobile-menu-btn" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                aria-expanded="false" aria-label="Toggle navigation">
                            <span class="toggler-icon"></span>
                            <span class="toggler-icon"></span>
                            <span class="toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
                            <ul id="nav" class="navbar-nav ms-auto">
                                <li class="nav-item">
                                    <a href="index.jsp" class="active" aria-label="Toggle navigation">Inicio</a>
                                </li>

                                <li class="nav-item">
                                    <a class="dd-menu collapsed" href="javascript:void(0)" data-bs-toggle="collapse"
                                       data-bs-target="#submenu-1-2" aria-controls="navbarSupportedContent"
                                       aria-expanded="false" aria-label="Toggle navigation">Categorias</a>
                                    <ul class="sub-menu collapse" id="submenu-1-2">
                                        <c:forEach items="${app_categorias}" var="item">
                                            <li>
                                                <a href="producto?accion=categoria&id=${item.idCateg}">${item.nombreCateg}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </li>

                                <li class="nav-item">
                                    <a class="dd-menu collapsed" href="javascript:void(0)" data-bs-toggle="collapse"
                                       data-bs-target="#submenu-1-2" aria-controls="navbarSupportedContent"
                                       aria-expanded="false" aria-label="Toggle navigation">Farmacias</a>
                                    <ul class="sub-menu collapse" id="submenu-1-2">
                                        <c:forEach items="${app_farmacias}" var="item">
                                            <li>
                                                <a href="producto?accion=farmacia&id=${item.idFarmacia}">${item.nombre}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </li>

                                <li class="nav-item">
                                    <a href="producto?accion=oferta" aria-label="Toggle navigation">Oferta</a>
                                </li>
                                <c:if test="${sessionScope.usuario != null}">
                                    <li class="nav-item">
                                        <a href="pedido?accion=cuenta" aria-label="Toggle navigation">Cuenta</a>
                                    </li>
                                </c:if>

                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</header>
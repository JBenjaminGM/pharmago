<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Detalle del Pedido</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            .estado-row {
                display: flex;
                justify-content: space-around;
                margin-top: 20px;
            }
            .estado {
                width: 30%;
                padding: 10px;
                border-radius: 5px;
                color: white;
                text-align: center;
                font-weight: bold;
            }
            .estado-aceptado {
                background-color: #4CAF50;
            }
            .estado-en-curso {
                background-color: #FFC107;
            }
            .estado-entregado {
                background-color: #2196F3;
            }
            .estado-inactivo {
                background-color: #e0e0e0;
                color: #6b6b6b;
            }
            .pedido-info {
                margin-top: 30px;
                padding: 15px;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                background-color: #f9f9f9;
                text-align: center;
                color: #333;
                font-size: 1.1em;
            }
            .pedido-info h2 {
                font-size: 1.5em;
                margin-bottom: 10px;
            }
            .pedido-info p {
                margin: 5px 0;
            }
        </style>
    </head>
    <body class="container mt-3">
        <div class="pedido-info">
            <p><strong>Código de Transación:</strong> ${pedido.codigoTransacion}</p>
            <p><strong>Código de Orden:</strong> ${pedido.idPedFarmacia}</p>
            <p><strong>Farmacia:</strong> ${pedido.farmacia.nombre}</p>
            <p><strong>Fecha de Orden:</strong> ${pedido.fechaDespacho1Aceptado}</p>
        </div>

        <div class="estado-row mt-4">
            <div class="estado 
                 <c:choose>
                     <c:when test="${not empty pedido.fechaDespacho1Aceptado}">estado-aceptado</c:when>
                     <c:otherwise>estado-inactivo</c:otherwise>
                 </c:choose>">
                <i class="fas fa-check-circle"></i> Aceptado
            </div>
            <div class="estado 
                 <c:choose>
                     <c:when test="${not empty pedido.fechaDespacho2EnCurso}">estado-en-curso</c:when>
                     <c:otherwise>estado-inactivo</c:otherwise>
                 </c:choose>">
                <i class="fas fa-truck"></i> En Curso
            </div>
            <div class="estado 
                 <c:choose>
                     <c:when test="${not empty pedido.fechaDespacho3Entregado}">estado-entregado</c:when>
                     <c:otherwise>estado-inactivo</c:otherwise>
                 </c:choose>">
                <i class="fas fa-box"></i> Entregado
            </div>
        </div>

        <table class="table table-bordered table-striped mt-4">
            <thead class="thead-dark">
                <tr>
                    <th>Imagen</th>
                    <th>Categoría</th>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Precio Unitario</th>
                    <th>Importe</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="detalle" items="${pedido.detallesPedido}">
                    <tr>
                        <td>
                            <img src="${detalle.producto.imagen}" style="width: 100px; height: 70px;">
                        </td>
                        <td>${detalle.producto.categoria.nombreCateg}</td>
                        <td>${detalle.producto.nombreProd}</td>
                        <td>${detalle.cantidad}</td>
                        <td>S/${detalle.producto.precio}</td>
                        <td>S/${detalle.importe}</td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="5" class="text-right"><strong>Total</strong></td>
                    <td style="font-weight: bold;">S/${pedido.total}</td>
                </tr>
            </tbody>
        </table>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>

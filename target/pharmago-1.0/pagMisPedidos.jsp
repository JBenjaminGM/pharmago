<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Pharmago - Cuenta</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg" />
        <jsp:include page="includes/css.jsp" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.1/css/bootstrap.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.bootstrap4.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.bootstrap4.min.css">
    </head>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    <jsp:include page="includes/mensaje.jsp" />

    <div class="container-fluid mt-2">
        <div class="card w-100">
            <div class="card-body">
                <div class="d-flex align-items-start w-100">
                    <div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-cuenta" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">Cuenta</button>
                        <button class="nav-link active" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pedidos" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">Pedidos</button>
                        <button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-ayuda" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">Ayuda</button>
                    </div>
                    <div class="tab-content w-100" id="v-pills-tabContent">
                        <div class="tab-pane fade" id="v-cuenta" role="tabpanel" aria-labelledby="v-pills-home-tab" tabindex="0">
                            <div class="card">
                                <div class="card-body">
                                    <h5>Información Cuenta</h5>
                                    <hr />

                                    <form id="actualizarForm">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <label for="nombres">Nombres:</label>
                                                <input value="${cliente.nombres}" type="text" id="nombres" name="nombres" placeholder="Ingrese sus nombres" 
                                                       pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]+" title="Solo letras y espacios" required class="form-control" />
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="apellidos">Apellidos:</label>
                                                <input value="${cliente.apellidos}" type="text" id="apellidos" name="apellidos" placeholder="Ingrese sus apellidos" 
                                                       pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]+" title="Solo letras y espacios" required class="form-control" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <label for="fechaNacimiento">Fecha de Nacimiento:</label>
                                                <%
                                                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                    String fechaActual = sdf.format(new java.util.Date());
                                                %>
                                                <input value="${cliente.fechaNac}" type="date" id="fechaNacimiento" name="fechaNacimiento" 
                                                       min="1900-01-01" max="<%= fechaActual%>" required class="form-control" />
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="nroDocumento">Número de Documento:</label>
                                                <input value="${cliente.nroDocumento}" type="text" id="nroDocumento" name="nroDocumento" placeholder="Número de Documento" 
                                                       pattern="[0-9]{8,15}" title="Ingrese solo números (8-15 dígitos)" required class="form-control" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <label for="telefono">Teléfono:</label>
                                                <input value="${cliente.telefono}" type="tel" id="telefono" name="telefono" placeholder="Ingrese su teléfono" 
                                                       pattern="[0-9]{9,15}" title="Ingrese un número de teléfono válido (9-15 dígitos)" required class="form-control" />
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="correo">Correo:</label>
                                                <input value="${cliente.correo}" type="email" id="correo" name="correo" placeholder="Ingrese su correo" 
                                                       required class="form-control" disabled />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <label for="password">Contraseña:</label>
                                                <input value="${cliente.password}" type="password" id="password" name="password" placeholder="Ingrese su contraseña" 
                                                       minlength="8" title="Debe contener al menos 8 caracteres" required class="form-control" />
                                            </div>
                                        </div>

                                        <div class="row mt-3">
                                            <div class="col-sm-6">
                                                <input type="hidden" name="id" id="id" value="${cliente.idCliente}">
                                                <button type="submit" class="btn btn-primary">Guardar</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>


                        <div class="tab-pane fade show active" id="v-pedidos" role="tabpanel" aria-labelledby="v-pills-profile-tab" tabindex="0">
                            <div class="card">
                                <div class="card-body">
                                    <h5>Mis Pedidos</h5>
                                    <hr />

                                    <table class="table table-bordered table-striped tabla">
                                        <thead class="bg-primary text-white">
                                            <tr>
                                                <th scope="col">Codigo Transación</th>
                                                <th scope="col"># Orden Pedido</th>
                                                <th scope="col">Farmacia</th>
                                                <th scope="col">Fecha</th>
                                                <th scope="col">Total</th>
                                                <th>Detalle</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${pedidos}" var="item">
                                                <tr>
                                                    <th>${item.codigoTransacion}</th>
                                                    <th>${item.idPedFarmacia}</th>
                                                    <th>${item.farmacia.nombre}</th>
                                                    <th>${item.fechaDespacho1Aceptado}</th>
                                                    <th>${item.total}</th>
                                                    <th>
                                                        <button type="button" onclick="fnVerDetalle(${item.idPedFarmacia})" class="btn btn-info btn-sm"
                                                                >Ver
                                                        </button>
                                                    </th>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>


                        <div class="tab-pane fade" id="v-ayuda" role="tabpanel" aria-labelledby="v-pills-disabled-tab" tabindex="0">
                            <div class="card">
                                <div class="card-body">
                                    <h5>Soporte y Ayuda</h5>
                                    <hr />

                                    <p>¿Necesitas ayuda? En <strong>Online Pharmaco</strong> estamos aquí para ayudarte a resolver tus dudas y brindarte el mejor soporte en tu experiencia de compra.</p>

                                    <h5>Opciones de Ayuda y Soporte:</h5>
                                    <hr />
                                    <br />
                                    <ul>
                                        <li>
                                            <strong>Preguntas Frecuentes (FAQ):</strong> Revisa nuestra sección de Preguntas Frecuentes para encontrar respuestas a las consultas más comunes sobre pedidos, métodos de pago, envíos, devoluciones y más.
                                        </li>
                                        <li>
                                            <strong>Asesoría en Productos y Recetas:</strong> Si tienes dudas sobre algún producto o necesitas orientación en tu compra, nuestros asesores especializados en farmacia están disponibles para asistirte.
                                        </li>
                                        <li>
                                            <strong>Estado de Pedido:</strong> Puedes verificar el estado de tu pedido desde tu cuenta en la sección "Mis Pedidos". Si necesitas más información, contáctanos directamente.
                                        </li>
                                        <li>
                                            <strong>Soporte en Línea:</strong> Puedes comunicarte con nuestro equipo de soporte a través de nuestro <strong>chat en línea</strong> disponible de 9:00 a.m. a 9:00 p.m., de lunes a sábado.
                                        </li>
                                        <li>
                                            <strong>Contáctanos:</strong> Si no encuentras la información que necesitas, estamos disponibles en:
                                            <ul>
                                                <li><strong>Correo Electrónico:</strong> <a href="mailto:soporte@onlinepharmaco.com">soporte@onlinepharmaco.com</a></li>
                                                <li><strong>Línea Telefónica:</strong> +1 (555) 123-4567</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <br />
    </div>

    <div class="modal fade" id="modalDetalle" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">::: Orden de Pedido :::</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="lbDetalle">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>                                           

    <jsp:include page="includes/footer.jsp" />
    <jsp:include page="includes/js.jsp" />
    <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.2.3/js/responsive.bootstrap4.min.js"></script>
</body>
<script>
                                                            $('#actualizarForm').submit(function (event) {
                                                                event.preventDefault();
                                                                var _params = {
                                                                    "accion": "actualizar",
                                                                    "nombres": $("#nombres").val(),
                                                                    "apellidos": $("#apellidos").val(),
                                                                    "nroDocumento": $("#nroDocumento").val(),
                                                                    "fechaNacimiento": $("#fechaNacimiento").val(),
                                                                    "telefono": $("#telefono").val(),
                                                                    "password": $("#password").val(),
                                                                    "id": $("#id").val()
                                                                };

                                                                axios.get('auth', {params: _params})
                                                                        .then(function (response) {
                                                                            response = response.data;
                                                                            console.log(response);
                                                                            if (response.msg !== "OK") {
                                                                                fnToast("error", response.msg);
                                                                            } else {
                                                                                fnToast("success", "Cuenta actualizado!");
                                                                            }
                                                                        })
                                                                        .catch(function (error) {
                                                                            console.error('Hubo un error al actualizar el cuenta', error);
                                                                            fnToast("error", 'Error al actualizar la cuenta.');
                                                                        });
                                                            });

                                                            function fnVerDetalle(id) {
                                                                axios.get('pedido', {
                                                                    params: {
                                                                        accion: 'view_pedido',
                                                                        id: id
                                                                    }
                                                                })
                                                                        .then(function (response) {
                                                                            document.getElementById("lbDetalle").innerHTML = response.data;

                                                                            $("#modalDetalle").modal("show");
                                                                        })
                                                                        .catch(function (error) {
                                                                            console.error("Error al cargar los detalles:", error);
                                                                        });
                                                            }

</script>
<script>
    $(document).ready(function () {
        $('.tabla').DataTable({
            language: {
                "decimal": "",
                "emptyTable": "No hay información",
                "info": "Mostrando _START_ a _END_ de _TOTAL_ Entradas",
                "infoEmpty": "Mostrando 0 to 0 of 0 Entradas",
                "infoFiltered": "(Filtrado de _MAX_ total entradas)",
                "infoPostFix": "",
                "thousands": ",",
                "lengthMenu": "Mostrar _MENU_ Entradas",
                "loadingRecords": "Cargando...",
                "processing": "Procesando...",
                "search": "Buscar:",
                "zeroRecords": "Sin resultados encontrados",
                "paginate": {
                    "first": "Primero",
                    "last": "Ultimo",
                    "next": "Siguiente",
                    "previous": "Anterior"
                }
            }
        });
    });
</script>
</html>

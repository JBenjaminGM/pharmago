<%@page import="com.company.pharmago.modelo.dao.FarmaciaDAO"%>
<%@page import="com.company.pharmago.modelo.Farmacia"%>
<%@page import="java.util.List"%>
<%@page import="com.company.pharmago.modelo.Categoria"%>
<%@page import="com.company.pharmago.modelo.dao.CategoriaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Pharmago - Registro</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg" />
        <jsp:include page="includes/css.jsp" />
    </head>
    <body>
        <jsp:include page="includes/header.jsp" />

        <%
            FarmaciaDAO farmaciaDao = new FarmaciaDAO();
            CategoriaDAO categoriaDao = new CategoriaDAO();

            List<Farmacia> farmacias = farmaciaDao.ListarTodos();
            List<Categoria> categorias = categoriaDao.ListarTodos();
        %>

        <div class="container">
            <h3>Registrar Producto</h3>
            <form id="registroProductoForm">
                <div class="row">
                    <div class="col-sm-6">
                        <label for="categoria">Categoría:</label>
                        <select id="idCateg" name="idCateg" required class="form-control">
                            <option value="">Seleccione una categoría</option>
                            <% for (Categoria categoria : categorias) {%>
                            <option value="<%= categoria.getIdCateg()%>"><%= categoria.getNombreCateg()%></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-sm-6">
                        <label for="nombreProd">Nombre:</label>
                        <input type="text" id="nombreProd" name="nombreProd" required class="form-control">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <label for="farmacia">Farmacia:</label>
                        <select id="idFarmacia" name="idFarmacia" required class="form-control">
                            <option value="">Seleccione una farmacia</option>
                            <% for (Farmacia farmacia : farmacias) {%>
                            <option value="<%= farmacia.getIdFarmacia()%>"><%= farmacia.getNombre()%></option>
                            <% }%>
                        </select>
                    </div>
                    <div class="col-sm-3">
                        <label for="stock">Stock:</label>
                        <input type="number" id="stock" name="stock" required class="form-control">
                    </div>

                    <div class="col-sm-3">
                        <label for="precio">Precio:</label>
                        <input type="number" step="0.01" id="precio" name="precio" required class="form-control">

                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-9">
                        <label for="imagen">Imagen URL:</label>
                        <input type="text" id="imagen" name="imagen" required class="form-control">
                    </div>

                    <div class="col-sm-3">
                        <label for="porcDesc">Porcentaje de Descuento:</label>
                        <input type="number" step="0.01" id="porcDesc" name="porcDesc" required class="form-control">
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <label for="descripcion">Descripción:</label>
                        <textarea id="descripcion" name="descripcion" required class="form-control"></textarea>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Registrar</button>
            </form>
        </div>

        <jsp:include page="includes/footer.jsp" />
        <jsp:include page="includes/js.jsp" />
        <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
        <script>
            $(document).ready(function () {
                CKEDITOR.replace('descripcion');

                $('#registroProductoForm').submit(function (event) {
                    event.preventDefault();

                    for (var instance in CKEDITOR.instances) {
                        CKEDITOR.instances[instance].updateElement(); 
                    }


                    const formData = new FormData();
                    formData.append('nombreProd', $('#nombreProd').val());
                    formData.append('stock', $('#stock').val());
                    formData.append('precio', $('#precio').val());
                    formData.append('descripcion', $('#descripcion').val()); 
                    formData.append('porcDesc', $('#porcDesc').val());
                    formData.append('idCateg', $('#idCateg').val());
                    formData.append('idFarmacia', $('#idFarmacia').val());
                    formData.append('imagen', $('#imagen').val());

                    axios.post('registroProducto', formData)
                            .then(function (response) {
                                response = response.data;
                                if (response.msg !== "OK") {
                                    fnToast("error", response.msg);
                                } else {
                             //       $("#registroProductoForm")[0].reset();
                                    fnToast("success", "Producto registrado");
                                }
                            })
                            .catch(function (error) {
                                console.error('Hubo un error al registrar el producto:', error);
                                fnToast("error", 'Error al registrar el producto.');
                            });
                });
            });
        </script>
    </body>
</html>
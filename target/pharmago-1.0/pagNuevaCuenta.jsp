<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Pharmago - Nueva Cuenta</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg" />
        <jsp:include page="includes/css.jsp" />
        <style>
            .register-container {
                max-width: 600px;
                margin: 60px auto;
                padding: 40px;
                border-radius: 10px;
                background-color: #fff;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            }
            .register-container h2 {
                text-align: center;
                margin-bottom: 25px;
                font-size: 26px;
                color: #333;
                font-weight: 600;
            }
            .register-container hr {
                border: 0;
                border-top: 2px solid #007bff;
                width: 50px;
                margin: 20px auto;
            }
            .form-group {
                display: flex;
                flex-wrap: wrap;
                margin-bottom: 20px;
            }
            .form-item {
                flex: 1 1 48%;
                margin-right: 4%;
            }
            .form-item:last-child {
                margin-right: 0;
            }
            .form-item label {
                display: block;
                margin-bottom: 8px;
                color: #666;
                font-weight: 500;
            }
            .form-item input {
                width: 100%;
                padding: 12px;
                border-radius: 5px;
                border: 1px solid #ccc;
                font-size: 16px;
                color: #333;
                transition: all 0.3s ease;
            }
            .form-item input:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 8px rgba(0, 123, 255, 0.3);
            }
            .btn-primary {
                width: 100%;
                padding: 12px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                font-size: 18px;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .register-container p {
                text-align: center;
                margin-top: 20px;
                color: #555;
            }
            .register-container a {
                color: #007bff;
                text-decoration: none;
                font-weight: 500;
            }
            .register-container a:hover {
                text-decoration: underline;
            }
        </style>
        <script>
            function validarFormulario(event) {
                const password = document.getElementById("password").value;
                if (password.length < 8) {
                    alert("La contraseña debe tener al menos 8 caracteres.");
                    event.preventDefault();
                    return false;
                }

                const correo = document.getElementById("correo").value;
                const correoRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!correoRegex.test(correo)) {
                    alert("Por favor, ingrese un correo válido.");
                    event.preventDefault();
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <jsp:include page="includes/header.jsp" />
        <jsp:include page="includes/mensaje.jsp" />

        <div class="register-container">
            <h2>Nueva Cuenta</h2>
            <hr />
            <form action="auth" method="post" onsubmit="return validarFormulario(event)">
                <div class="form-group">
                    <div class="form-item">
                        <label for="nombres">Nombres:</label>
                        <input value="${cliente.nombres}" type="text" id="nombres" name="nombres" placeholder="Ingrese sus nombres" 
                               pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]+" title="Solo letras y espacios" required />
                    </div>
                    <div class="form-item">
                        <label for="apellidos">Apellidos:</label>
                        <input value="${cliente.apellidos}" type="text" id="apellidos" name="apellidos" placeholder="Ingrese sus apellidos" 
                               pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]+" title="Solo letras y espacios" required />
                    </div>
                </div>
                <div class="form-group">
                    <div class="form-item">
                        <label for="fechaNacimiento">Fecha de Nacimiento:</label>
                        <%
                            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                            String fechaActual = sdf.format(new java.util.Date());
                        %>
                        <input value="${cliente.fechaNac}" type="date" id="fechaNacimiento" name="fechaNacimiento" 
                               min="1900-01-01" max="<%= fechaActual %>" required />
                    </div>
                    <div class="form-item">
                        <label for="nroDocumento">Número de Documento:</label>
                        <input value="${cliente.nroDocumento}" type="text" id="nroDocumento" name="nroDocumento" placeholder="Número de Documento" 
                               pattern="[0-9]{8,15}" title="Ingrese solo números (8-15 dígitos)" required />
                    </div>
                </div>
                <div class="form-group">
                    <div class="form-item">
                        <label for="telefono">Teléfono:</label>
                        <input value="${cliente.telefono}" type="tel" id="telefono" name="telefono" placeholder="Ingrese su teléfono" 
                               pattern="[0-9]{9,15}" title="Ingrese un número de teléfono válido (9-15 dígitos)" required />
                    </div>
                    <div class="form-item">
                        <label for="correo">Correo:</label>
                        <input value="${cliente.correo}" type="email" id="correo" name="correo" placeholder="Ingrese su correo" required />
                    </div>
                </div>
                <div class="form-group">
                    <div class="form-item" style="flex: 1;">
                        <label for="password">Contraseña:</label>
                        <input value="${cliente.password}" type="password" id="password" name="password" placeholder="Ingrese su contraseña" 
                               minlength="8" title="Debe contener al menos 8 caracteres" required />
                    </div>
                </div>
                <div class="form-group">
                    <input type="hidden" name="accion" value="register">
                    <button type="submit" class="btn-primary">Registrarse</button>
                </div>
            </form>
            <p>¿Ya tienes una cuenta? <a href="pagLogin.jsp">Inicia sesión aquí</a></p>
        </div>
        <jsp:include page="includes/footer.jsp" />
        <jsp:include page="includes/js.jsp" />
    </body>
</html>

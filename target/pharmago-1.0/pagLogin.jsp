<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Pharmago - Iniciar Sesión</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.svg" />
        <jsp:include page="includes/css.jsp" />
        <style>
        
            .login-container {
                max-width: 400px;
                margin: 60px auto;
                padding: 40px;
                border-radius: 10px;
                background-color: #fff;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
                text-align: center;
            }
            .login-container h2 {
                margin-bottom: 25px;
                font-size: 26px;
                color: #333;
                font-weight: 600;
            }
            .login-container hr {
                border: 0;
                border-top: 2px solid #007bff;
                width: 50px;
                margin: 20px auto;
            }
            .form-group {
                margin-bottom: 20px;
                text-align: left;
            }
            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #666;
                font-weight: 500;
            }
            .form-group input {
                width: 100%;
                padding: 12px;
                border-radius: 5px;
                border: 1px solid #ccc;
                font-size: 16px;
                color: #333;
                transition: all 0.3s ease;
            }
            .form-group input:focus {
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
            .login-container p {
                margin-top: 20px;
                color: #555;
            }
            .login-container a {
                color: #007bff;
                text-decoration: none;
                font-weight: 500;
            }
            .login-container a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/header.jsp" />
        <jsp:include page="includes/mensaje.jsp" />

        <div class="login-container">
            <h2>Iniciar Sesión</h2>
            <hr />
            <form action="auth" method="post">
                <div class="form-group">
                    <label for="correo">Correo:</label>
                    <input value="${correo}" type="email" id="correo" name="correo" placeholder="Ingrese su correo" required />
                </div>
                <div class="form-group">
                    <label for="password">Contraseña:</label>
                    <input value="" type="password" id="password" name="password" placeholder="Ingrese su contraseña" required />
                </div>
                <div class="form-group">
                    <input type="hidden" name="accion" value="login">
                    <button type="submit" class="btn-primary">Iniciar Sesión</button>
                </div>
            </form>
            <p>¿No tienes una cuenta? <a href="auth?accion=new_account">Regístrate aquí</a></p>
        </div>

        <jsp:include page="includes/footer.jsp" />
        <jsp:include page="includes/js.jsp" />
    </body>
</html>

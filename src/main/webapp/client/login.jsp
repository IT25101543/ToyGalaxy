<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyGalaxy | Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/style/styles.css">
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: radial-gradient(circle at top right, rgba(79, 70, 229, 0.1), transparent),
                        radial-gradient(circle at bottom left, rgba(245, 158, 11, 0.1), transparent),
                        #F9FAFB;
        }
        .auth-card {
            background: white;
            padding: 3rem;
            border-radius: 2rem;
            box-shadow: var(--shadow-lg);
            width: 100%;
            max-width: 450px;
            text-align: center;
            animation: fadeInUp 0.8s ease-out;
        }
        .auth-card h2 {
            font-size: 2.5rem;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }
        .auth-card p {
            color: var(--text-muted);
            margin-bottom: 2rem;
        }
        .message {
            padding: 1rem;
            border-radius: 1rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }
        .error { background: #FEE2E2; color: #DC2626; border: 1px solid #FECACA; }
        .success { background: #ECFDF5; color: #059669; border: 1px solid #D1FAE5; }
        
        .input-group {
            text-align: left;
            margin-bottom: 1.5rem;
        }
        .input-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-dark);
        }
        .auth-card input {
            width: 100%;
            padding: 1rem 1.5rem;
            border: 1px solid #E5E7EB;
            border-radius: 1rem;
            font-family: inherit;
            transition: all 0.3s;
        }
        .auth-card input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }
        .auth-btn {
            width: 100%;
            padding: 1rem;
            margin-top: 1rem;
        }
        .footer-link {
            margin-top: 2rem;
            font-size: 0.9rem;
            color: var(--text-muted);
        }
        .footer-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>

    <div class="auth-card">
        <div class="logo" style="margin-bottom: 1rem;">Toy<span>Galaxy</span></div>
        <h2>Welcome Back</h2>
        <p>Log in to continue your adventure</p>

        <!-- Success/Logout Message -->
        <c:if test="${not empty logoutMessage}">
            <div class="message success">
                ${logoutMessage}
                <c:remove var="logoutMessage" scope="session"/>
            </div>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="message error">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="input-group">
                <label>Star-Mail Address</label>
                <input type="email" name="email" placeholder="explorer@galaxy.com" required>
            </div>

            <div class="input-group">
                <label>Secret Code</label>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>

            <button type="submit" class="auth-btn sign-up">Enter the Galaxy</button>
        </form>

        <div class="footer-link">
            New explorer? <a href="${pageContext.request.contextPath}/register">Create an Account</a>
        </div>
        <div class="footer-link" style="margin-top: 1rem;">
            <a href="${pageContext.request.contextPath}/index">Return Home</a>
        </div>
    </div>

</body>
</html>

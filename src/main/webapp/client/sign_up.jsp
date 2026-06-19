<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyGalaxy | Join the Fun</title>
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
            padding: 2rem 0;
        }
        .auth-card {
            background: white;
            padding: 3rem;
            border-radius: 2rem;
            box-shadow: var(--shadow-lg);
            width: 100%;
            max-width: 500px;
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
        
        .input-group {
            text-align: left;
            margin-bottom: 1.25rem;
        }
        .input-group label {
            display: block;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 0.4rem;
            color: var(--text-dark);
        }
        .auth-card input, .auth-card textarea {
            width: 100%;
            padding: 0.9rem 1.25rem;
            border: 1px solid #E5E7EB;
            border-radius: 1rem;
            font-family: inherit;
            transition: all 0.3s;
        }
        .auth-card input:focus, .auth-card textarea:focus {
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
            margin-top: 1.5rem;
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
        <h2>Start Your Adventure</h2>
        <p>Join the galaxy of happy explorers!</p>

        <!-- Error message -->
        <c:if test="${not empty error}">
            <div class="message error">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="input-group">
                <label>Explorer Name</label>
                <input type="text" name="name" placeholder="E.g. Buzz Lightyear" required>
            </div>

            <div class="input-group">
                <label>Star-Mail Address</label>
                <input type="email" name="email" placeholder="explorer@galaxy.com" required>
            </div>

            <div class="input-group">
                <label>Secret Code</label>
                <input type="password" name="password" placeholder="Choose a strong password" required>
            </div>

            <div class="input-group">
                <label>Star-Link Phone</label>
                <input type="tel" name="phone" placeholder="10-digit number" pattern="[0-9]{10}" title="Please enter exactly 10 digits" required>
            </div>

            <div class="input-group">
                <label>Home Base Address</label>
                <textarea name="address" placeholder="Where should we ship your toys?" rows="3" required></textarea>
            </div>

            <button type="submit" class="auth-btn sign-up">Join the Fun</button>
        </form>

        <div class="footer-link">
            Already an explorer? <a href="${pageContext.request.contextPath}/login">Log In Here</a>
        </div>
        <div class="footer-link" style="margin-top: 1rem;">
            <a href="${pageContext.request.contextPath}/index">Return Home</a>
        </div>
    </div>

</body>
</html>

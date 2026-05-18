<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Seller Login - Toy Galaxy</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        window.onload = () => {
            document.getElementById("login-form").classList.add("opacity-100", "translate-y-0");
        }
        function showTab(tab) {
            document.getElementById('loginTab').classList.toggle('hidden', tab !== 'login');
            document.getElementById('registerTab').classList.toggle('hidden', tab !== 'register');
            document.getElementById('btnLogin').classList.toggle('border-purple-400', tab === 'login');
            document.getElementById('btnLogin').classList.toggle('text-purple-400', tab === 'login');
            document.getElementById('btnLogin').classList.toggle('border-transparent', tab !== 'login');
            document.getElementById('btnLogin').classList.toggle('text-gray-400', tab !== 'login');
            document.getElementById('btnRegister').classList.toggle('border-purple-400', tab === 'register');
            document.getElementById('btnRegister').classList.toggle('text-purple-400', tab === 'register');
            document.getElementById('btnRegister').classList.toggle('border-transparent', tab !== 'register');
            document.getElementById('btnRegister').classList.toggle('text-gray-400', tab !== 'register');
        }
    </script>
    <style>
        .fade-in-start {
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.8s ease, transform 0.8s ease;
        }
    </style>
</head>

<body class="bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-900 min-h-screen flex justify-center items-center text-white font-sans">

    <div class="w-full max-w-sm bg-gray-800 p-8 rounded-xl shadow-xl fade-in-start" id="login-form">
        <h2 class="text-3xl font-bold text-center mb-6 text-purple-400">Seller Portal</h2>

        <!-- Tab Buttons -->
        <div class="flex border-b border-gray-600 mb-6">
            <button id="btnLogin" onclick="showTab('login')"
                class="flex-1 pb-3 text-sm font-semibold border-b-2 border-purple-400 text-purple-400 transition-all">
                Sign In
            </button>
            <button id="btnRegister" onclick="showTab('register')"
                class="flex-1 pb-3 text-sm font-semibold border-b-2 border-transparent text-gray-400 transition-all">
                Register
            </button>
        </div>

        <!-- Error / Success Messages -->
        <c:if test="${not empty error}">
            <div class="bg-red-500 text-white px-4 py-2 rounded mb-4 text-center animate-pulse">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="bg-green-600 text-white px-4 py-2 rounded mb-4 text-center">${success}</div>
        </c:if>

        <!-- LOGIN TAB -->
        <div id="loginTab">
            <form action="${pageContext.request.contextPath}/seller/login" method="post" class="space-y-4">
                <input type="email" name="email" placeholder="Email Address" required
                    class="w-full px-4 py-2 rounded bg-gray-700 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-purple-500">

                <input type="password" name="password" placeholder="Password" required
                    class="w-full px-4 py-2 rounded bg-gray-700 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-purple-500">

                <button type="submit"
                    class="w-full bg-purple-600 hover:bg-purple-700 transition-all text-white font-semibold py-2 rounded shadow-lg transform hover:scale-105">
                    Login
                </button>
            </form>

            <p class="mt-4 text-center text-xs text-gray-400">
                Don't have an account?
                <button onclick="showTab('register')" class="text-purple-400 hover:text-purple-300 underline">Register here</button>
            </p>
        </div>

        <!-- REGISTER TAB -->
        <div id="registerTab" class="hidden">
            <form action="${pageContext.request.contextPath}/seller/register" method="post" class="space-y-4">
                <input type="text" name="name" placeholder="Full Name" required
                    class="w-full px-4 py-2 rounded bg-gray-700 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-purple-500">

                <input type="email" name="email" placeholder="Email Address" required
                    class="w-full px-4 py-2 rounded bg-gray-700 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-purple-500">

                <input type="password" name="password" placeholder="Password" required
                    class="w-full px-4 py-2 rounded bg-gray-700 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-purple-500">

                <input type="text" name="storeName" placeholder="Store Name" required
                    class="w-full px-4 py-2 rounded bg-gray-700 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-purple-500">

                <button type="submit"
                    class="w-full bg-pink-600 hover:bg-pink-700 transition-all text-white font-semibold py-2 rounded shadow-lg transform hover:scale-105">
                    Create Seller Account
                </button>
            </form>
            <p class="mt-4 text-center text-xs text-gray-400">
                Already have an account?
                <button onclick="showTab('login')" class="text-purple-400 hover:text-purple-300 underline">Sign in</button>
            </p>
        </div>

        <p class="mt-6 text-center text-sm text-gray-400">
            <a href="${pageContext.request.contextPath}/index" class="text-purple-400 hover:text-purple-300 underline">HOME</a>
        </p>
    </div>

</body>
</html>

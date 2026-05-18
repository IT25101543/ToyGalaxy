<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyGalaxy | Command Center</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-indigo-950 via-gray-900 to-black min-h-screen flex items-center justify-center text-white font-sans">

    <div class="bg-gray-900/80 backdrop-blur-xl p-10 rounded-3xl shadow-2xl w-full max-w-md border border-gray-800">
        <div class="text-center mb-8">
             <div class="text-3xl font-bold text-indigo-500 mb-2">Toy<span>Galaxy</span></div>
             <h2 class="text-xl font-semibold text-gray-300">Command Center</h2>
        </div>

        <form action="${pageContext.request.contextPath}/admin/login" method="post" class="space-y-6">
            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="bg-red-500/20 text-red-400 px-4 py-2 rounded-xl text-sm text-center border border-red-500/30"><%= error %></div>
            <% } %>

            <div>
                <label for="email" class="block mb-2 text-sm font-medium text-gray-400">Commander Email</label>
                <input type="email" id="email" name="email"
                       class="w-full px-5 py-3 rounded-xl bg-gray-800 border border-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 transition"
                       placeholder="admin@toygalaxy.com" required autofocus>
            </div>

            <div>
                <label for="password" class="block mb-2 text-sm font-medium text-gray-400">Access Key</label>
                <input type="password" id="password" name="password"
                       class="w-full px-5 py-3 rounded-xl bg-gray-800 border border-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 transition"
                       placeholder="••••••••" required>
            </div>

            <button type="submit"
                    class="w-full py-3 px-4 bg-indigo-600 hover:bg-indigo-500 transition-all text-white font-bold rounded-xl shadow-lg shadow-indigo-500/20">
                Log In to Dashboard
            </button>
        </form>

        <div class="mt-8 text-center">
            <a href="${pageContext.request.contextPath}/index" class="text-gray-500 hover:text-indigo-400 text-sm transition underline">Return to Main View</a>
        </div>
        
        <p class="mt-8 text-[10px] text-center text-gray-600 uppercase tracking-widest">
            © 2026 ToyGalaxy Systems. Secure Access Only.
        </p>
    </div>

</body>
</html>

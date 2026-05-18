<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Seller" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session == null || session.getAttribute("seller") == null) {
        response.sendRedirect(request.getContextPath() + "/seller/login");
        return;
    }
    Seller seller = (Seller) session.getAttribute("seller");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seller Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-purple-900 via-indigo-900 to-pink-900 min-h-screen text-white flex font-sans">

    <!-- Sidebar -->
    <aside id="sidebar" class="w-64 bg-gray-800 p-6 min-h-screen shadow-lg transition-all duration-300 ease-in-out">
        
        <h2 class="text-2xl font-bold mb-8 text-indigo-400"><a href="${pageContext.request.contextPath}/index" class="text-indigo-400 hover:text-indigo-300 underline">Galaxy Seller</a></h2>
        <nav class="space-y-4">
            <a href="${pageContext.request.contextPath}/seller/dashboard" class="block px-4 py-2 rounded hover:bg-gray-700 transition">Dashboard</a>
            <a href="${pageContext.request.contextPath}/seller/logout" class="block px-4 py-2 text-red-400 hover:text-red-500 hover:bg-gray-700 rounded transition">Logout</a>
        </nav>
    </aside>


</body>
</html>

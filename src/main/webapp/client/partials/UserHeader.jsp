<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-white via-gray-100 to-gray-200 min-h-screen text-gray-800 flex font-sans">

    <!-- Sidebar -->
    <aside class="w-72 bg-white/80 backdrop-blur-xl min-h-screen shadow-2xl border-r border-white/20 sticky top-0 z-[1000]">
        <div class="p-8">
            <h2 class="text-3xl font-black mb-12 tracking-tighter">
                <a href="${pageContext.request.contextPath}/index" class="text-gray-900 group">
                    Toy<span class="text-indigo-600 group-hover:text-indigo-700 transition-colors">Galaxy</span>
                </a>
            </h2>
            
            <nav class="space-y-2">
                <a href="${pageContext.request.contextPath}/user/products" 
                   class="flex items-center space-x-3 px-6 py-4 rounded-2xl text-gray-500 hover:text-indigo-600 hover:bg-indigo-50/50 transition-all font-bold">
                    <i class="fas fa-rocket w-6"></i>
                    <span>Marketplace</span>
                </a>
                <a href="${pageContext.request.contextPath}/user/profile" 
                   class="flex items-center space-x-3 px-6 py-4 rounded-2xl text-gray-500 hover:text-indigo-600 hover:bg-indigo-50/50 transition-all font-bold">
                    <i class="fas fa-user-circle w-6"></i>
                    <span>Account</span>
                </a>
                
                <div class="pt-8 mt-8 border-t border-gray-100">
                    <a href="${pageContext.request.contextPath}/user/logout" 
                       class="flex items-center space-x-3 px-6 py-4 rounded-2xl text-red-400 hover:text-red-600 hover:bg-red-50 transition-all font-bold">
                        <i class="fas fa-sign-out-alt w-6"></i>
                        <span>Sign Out</span>
                    </a>
                </div>
            </nav>
        </div>
    </aside>

    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

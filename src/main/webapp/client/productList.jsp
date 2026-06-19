<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyGalaxy | Explore Our Universe</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/style/styles.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-50 font-['Inter']">

    <!-- Premium Header -->
    <header class="fixed top-0 left-0 right-0 z-[1000] bg-white/70 backdrop-blur-xl border-b border-white/20 px-[5%] py-4 flex justify-between items-center shadow-sm">
        <div class="text-3xl font-black tracking-tighter cursor-pointer" onclick="window.location.href='${pageContext.request.contextPath}/index'">
            Toy<span class="text-indigo-600">Galaxy</span>
        </div>
        <div class="flex items-center space-x-6">
            <a href="${pageContext.request.contextPath}/index" class="text-sm font-bold text-gray-500 hover:text-indigo-600 transition-colors">Home</a>
            <a href="${pageContext.request.contextPath}/user/profile" class="w-10 h-10 bg-indigo-50 rounded-full flex items-center justify-center text-indigo-600 hover:bg-indigo-100 transition-all">
                <i class="fas fa-user"></i>
            </a>
        </div>
    </header>

    <!-- Hero Section -->
    <div class="pt-32 pb-20 px-[5%] bg-gradient-to-br from-indigo-600 via-purple-600 to-pink-500 text-center relative overflow-hidden">
        <div class="absolute inset-0 opacity-10 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')]"></div>
        <div class="relative z-10 animate-in fade-in slide-in-from-bottom-8 duration-1000">
            <h1 class="text-6xl font-black text-white mb-6 tracking-tight">Discover Endless Fun</h1>
            <p class="text-white/80 text-xl max-w-2xl mx-auto font-medium leading-relaxed">
                Browse our curated collection of out-of-this-world toys that spark imagination and joy across the galaxy.
            </p>
        </div>
    </div>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto py-20 px-[5%]">
        
        <div class="flex justify-between items-center mb-12">
            <h2 class="text-3xl font-black text-gray-900 flex items-center">
                <i class="fas fa-stars text-indigo-600 mr-3"></i>
                Latest Arrivals
            </h2>
            <div class="text-gray-400 text-sm font-bold uppercase tracking-widest">${products.size()} Items Found</div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">
            <c:forEach items="${products}" var="product">
                <div class="group bg-white rounded-[2.5rem] p-8 shadow-xl border border-gray-100 hover:shadow-2xl hover:-translate-y-2 transition-all duration-500 flex flex-col h-full">
                    <div class="relative aspect-square mb-8 bg-gray-50 rounded-3xl p-6 flex items-center justify-center overflow-hidden">
                        <div class="absolute inset-0 bg-gradient-to-br from-indigo-500/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
                        <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.productName}" 
                             class="w-full h-full object-contain transform group-hover:scale-110 transition-transform duration-700">
                    </div>

                    <div class="flex-1">
                        <h3 class="text-2xl font-black text-gray-900 mb-3 group-hover:text-indigo-600 transition-colors">${product.productName}</h3>
                        <p class="text-gray-500 text-sm leading-relaxed line-clamp-2 mb-6">${product.description}</p>
                    </div>

                    <div class="flex items-center justify-between mt-auto pt-6 border-t border-gray-50">
                        <span class="text-3xl font-black text-gray-900">Rs. ${product.price}</span>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/user/product-details?productId=${product.productId}'" 
                                class="px-6 py-3 bg-indigo-600 text-white rounded-2xl font-bold text-sm shadow-lg hover:bg-indigo-700 active:scale-95 transition-all">
                            Explore <i class="fas fa-arrow-right ml-2 text-xs"></i>
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty products}">
            <div class="py-32 text-center">
                <div class="w-24 h-24 bg-indigo-50 rounded-full flex items-center justify-center mx-auto mb-8 text-indigo-300 text-4xl">
                    <i class="fas fa-rocket"></i>
                </div>
                <h3 class="text-3xl font-black text-gray-900">No toys in this orbit</h3>
                <p class="text-gray-500 mt-4 max-w-sm mx-auto font-medium">We're searching the galaxy for new arrivals. Check back soon!</p>
                <button onclick="window.location.href='${pageContext.request.contextPath}/index'" 
                        class="mt-10 px-8 py-4 bg-white text-indigo-600 border-2 border-indigo-50 rounded-2xl font-bold hover:bg-indigo-50 transition-all">
                    Return to Base
                </button>
            </div>
        </c:if>
    </main>

    <footer class="bg-white border-t border-gray-100 py-12">
        <div class="max-w-7xl mx-auto px-[5%] text-center">
            <div class="text-2xl font-black tracking-tighter mb-6">
                Toy<span class="text-indigo-600">Galaxy</span>
            </div>
            <p class="text-gray-400 text-sm font-medium">&copy; 2026 ToyGalaxy. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>

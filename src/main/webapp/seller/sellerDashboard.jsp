<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/SellerHeader.jsp" %>

<main class="flex-1 p-8">
    <div class="max-w-full bg-gray-800 p-6 rounded-lg shadow-lg transition transform hover:scale-[1.01]">
        <h2 class="text-3xl font-semibold mb-6 text-purple-300 border-b border-gray-600 pb-2">Welcome to Your Seller Dashboard</h2>

        <!-- Seller Overview — Real Data -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <div class="bg-gray-700 p-4 rounded-lg shadow-lg">
                <h3 class="text-xl font-semibold">Total Products</h3>
                <p class="text-2xl font-bold mt-2">${totalProducts}</p>
                <p class="text-xs text-gray-400 mt-1">Products listed in your store</p>
            </div>
            <div class="bg-gray-700 p-4 rounded-lg shadow-lg">
                <h3 class="text-xl font-semibold">Pending Orders</h3>
                <p class="text-2xl font-bold mt-2 text-amber-400">${pendingOrders}</p>
                <p class="text-xs text-gray-400 mt-1">Cash on Delivery — awaiting payment</p>
            </div>
            <div class="bg-gray-700 p-4 rounded-lg shadow-lg">
                <h3 class="text-xl font-semibold">Total Sales</h3>
                <p class="text-2xl font-bold mt-2 text-emerald-400">Rs. ${totalSales}</p>
                <p class="text-xs text-gray-400 mt-1">Revenue from paid orders</p>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="mt-8">
            <h3 class="text-2xl font-semibold text-purple-300 mb-4">Quick Actions</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <a href="${pageContext.request.contextPath}/seller/products"
                   class="block bg-purple-600 hover:bg-purple-700 text-white text-center py-4 rounded-lg shadow-md transition-all">
                    Manage Products
                </a>
                <a href="${pageContext.request.contextPath}/seller/profile"
                   class="block bg-indigo-600 hover:bg-indigo-700 text-white text-center py-4 rounded-lg shadow-md transition-all">
                    View Profile
                </a>
            </div>
        </div>
    </div>
</main>

<%@ include file="../partials/SellerFooter.jsp" %>

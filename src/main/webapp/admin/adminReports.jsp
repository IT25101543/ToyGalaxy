<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="./partials/adminHeader.jsp" %>

<main class="flex-1 p-6">
    <header class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-bold">Reports</h1>
    </header>

    <!-- ── Summary Cards ── -->
    <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        <div class="bg-gray-700 p-5 rounded-xl shadow hover:shadow-xl transition">
            <h3 class="text-sm font-semibold text-gray-400 mb-1">Total Orders</h3>
            <p class="text-3xl font-bold">${totalOrders}</p>
        </div>
        <div class="bg-gray-700 p-5 rounded-xl shadow hover:shadow-xl transition">
            <h3 class="text-sm font-semibold text-gray-400 mb-1">Total Revenue</h3>
            <p class="text-3xl font-bold text-emerald-400">Rs. ${totalRevenue}</p>
        </div>
        <div class="bg-gray-700 p-5 rounded-xl shadow hover:shadow-xl transition">
            <h3 class="text-sm font-semibold text-gray-400 mb-1">Total Users</h3>
            <p class="text-3xl font-bold text-blue-400">${totalUsers}</p>
        </div>
        <div class="bg-gray-700 p-5 rounded-xl shadow hover:shadow-xl transition">
            <h3 class="text-sm font-semibold text-gray-400 mb-1">Total Reviews</h3>
            <p class="text-3xl font-bold text-purple-400">${totalReviews}</p>
        </div>
    </section>

    <!-- ── Order Status Breakdown ── -->
    <section class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <div class="bg-gray-800 border border-amber-500 p-4 rounded-xl text-center">
            <p class="text-xs text-gray-400 mb-1">Pending</p>
            <p class="text-2xl font-bold text-amber-400">${pendingOrders}</p>
        </div>
        <div class="bg-gray-800 border border-green-500 p-4 rounded-xl text-center">
            <p class="text-xs text-gray-400 mb-1">Paid</p>
            <p class="text-2xl font-bold text-green-400">${paidOrders}</p>
        </div>
        <div class="bg-gray-800 border border-blue-500 p-4 rounded-xl text-center">
            <p class="text-xs text-gray-400 mb-1">Cash on Delivery</p>
            <p class="text-2xl font-bold text-blue-400">${codOrders}</p>
        </div>
        <div class="bg-gray-800 border border-red-500 p-4 rounded-xl text-center">
            <p class="text-xs text-gray-400 mb-1">Cancelled</p>
            <p class="text-2xl font-bold text-red-400">${cancelledOrders}</p>
        </div>
    </section>

    <!-- ── Product Stats ── -->
    <section class="grid grid-cols-2 gap-4 mb-8">
        <div class="bg-gray-700 p-5 rounded-xl shadow">
            <h3 class="text-sm font-semibold text-gray-400 mb-1">Active Products</h3>
            <p class="text-3xl font-bold text-emerald-400">${activeProducts}</p>
        </div>
        <div class="bg-gray-700 p-5 rounded-xl shadow">
            <h3 class="text-sm font-semibold text-gray-400 mb-1">Inactive Products</h3>
            <p class="text-3xl font-bold text-amber-400">${inactiveProducts}</p>
        </div>
    </section>

    <!-- ── All Orders Table ── -->
    <section class="bg-gray-800 p-6 rounded-xl shadow mb-8">
        <h2 class="text-xl font-semibold text-purple-300 mb-4 border-b border-gray-600 pb-2">All Orders</h2>
        <c:choose>
            <c:when test="${empty allOrders}">
                <p class="text-gray-400 text-center py-6">No orders found.</p>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm text-left text-gray-300">
                        <thead class="text-xs uppercase bg-gray-700 text-gray-400">
                            <tr>
                                <th class="px-4 py-3">Order ID</th>
                                <th class="px-4 py-3">User ID</th>
                                <th class="px-4 py-3">Product</th>
                                <th class="px-4 py-3">Qty</th>
                                <th class="px-4 py-3">Total (Rs.)</th>
                                <th class="px-4 py-3">Date</th>
                                <th class="px-4 py-3">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${allOrders}">
                                <tr class="border-b border-gray-700 hover:bg-gray-750">
                                    <td class="px-4 py-3">#${order.orderId}</td>
                                    <td class="px-4 py-3">${order.userId}</td>
                                    <td class="px-4 py-3">${productNameMap[order.productId]}</td>
                                    <td class="px-4 py-3">${order.quantity}</td>
                                    <td class="px-4 py-3">${order.totalPrice}</td>
                                    <td class="px-4 py-3">${order.orderDate}</td>
                                    <td class="px-4 py-3">
                                        <c:choose>
                                            <c:when test="${order.status == 'Paid'}">
                                                <span class="px-2 py-1 rounded text-xs bg-green-700 text-green-200">Paid</span>
                                            </c:when>
                                            <c:when test="${order.status == 'Pending'}">
                                                <span class="px-2 py-1 rounded text-xs bg-amber-700 text-amber-200">Pending</span>
                                            </c:when>
                                            <c:when test="${order.status == 'Cash on Delivery'}">
                                                <span class="px-2 py-1 rounded text-xs bg-blue-700 text-blue-200">Cash on Delivery</span>
                                            </c:when>
                                            <c:when test="${order.status == 'Cancelled'}">
                                                <span class="px-2 py-1 rounded text-xs bg-red-700 text-red-200">Cancelled</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-2 py-1 rounded text-xs bg-gray-600 text-gray-200">${order.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

</main>

<%@ include file="./partials/adminFooter.jsp" %>

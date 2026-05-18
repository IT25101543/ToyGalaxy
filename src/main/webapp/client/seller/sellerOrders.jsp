<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/SellerHeader.jsp" %>

<main class="flex-1 p-8">
    <div class="max-w-full bg-gray-800 p-6 rounded-lg shadow-lg">
        <h2 class="text-3xl font-semibold mb-6 text-purple-300 border-b border-gray-600 pb-2">Manage Orders</h2>

        <c:choose>
            <c:when test="${empty orders}">
                <p class="text-gray-400 text-center py-10">No orders found for your products.</p>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm text-left text-gray-300">
                        <thead class="text-xs uppercase bg-gray-700 text-gray-400">
                            <tr>
                                <th class="px-4 py-3">Order ID</th>
                                <th class="px-4 py-3">Product</th>
                                <th class="px-4 py-3">Qty</th>
                                <th class="px-4 py-3">Total (Rs.)</th>
                                <th class="px-4 py-3">Date</th>
                                <th class="px-4 py-3">Status</th>
                                <th class="px-4 py-3">Update Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr class="border-b border-gray-700 hover:bg-gray-750">
                                    <td class="px-4 py-3">#${order.orderId}</td>
                                    <td class="px-4 py-3">
                                        <c:choose>
                                            <c:when test="${not empty productMap[order.productId]}">
                                                ${productMap[order.productId].productName}
                                            </c:when>
                                            <c:otherwise>Product #${order.productId}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-4 py-3">${order.quantity}</td>
                                    <td class="px-4 py-3">Rs. <fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/>${order.totalPrice}</td>
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
                                    <td class="px-4 py-3">
                                        <form method="post" action="${pageContext.request.contextPath}/seller/orders">
                                            <input type="hidden" name="orderId" value="${order.orderId}" />
                                            <select name="status"
                                                    class="bg-gray-700 text-gray-200 text-xs rounded px-2 py-1 border border-gray-600 mr-2">
                                                <option value="Pending"          ${order.status == 'Pending'          ? 'selected' : ''}>Pending</option>
                                                <option value="Cash on Delivery" ${order.status == 'Cash on Delivery' ? 'selected' : ''}>Cash on Delivery</option>
                                                <option value="Paid"             ${order.status == 'Paid'             ? 'selected' : ''}>Paid</option>
                                                <option value="Cancelled"        ${order.status == 'Cancelled'        ? 'selected' : ''}>Cancelled</option>
                                            </select>
                                            <button type="submit"
                                                    class="bg-purple-600 hover:bg-purple-700 text-white text-xs px-3 py-1 rounded">
                                                Update
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<%@ include file="../partials/SellerFooter.jsp" %>

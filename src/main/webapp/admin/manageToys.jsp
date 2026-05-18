<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ include file="./partials/adminHeader.jsp"%>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>

<main class="p-6 w-full">
    <!-- Messages -->
    <c:if test="${not empty success}">
        <div class="bg-green-500 text-white px-4 py-3 rounded-lg shadow mb-6 animate-pulse">
            <p>${success}</p>
            <c:remove var="success" scope="session"/>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="bg-red-500 text-white px-4 py-3 rounded-lg shadow mb-6">
            <p>${error}</p>
            <c:remove var="error" scope="session"/>
        </div>
    </c:if>

    <div class="flex items-center justify-between mb-6">
        <h1 class="text-3xl font-bold text-purple-400">Manage Toys</h1>
        <span class="bg-gray-700 text-gray-300 text-sm px-4 py-1 rounded-full">
            Total Products: <strong class="text-white">${products != null ? products.size() : 0}</strong>
        </span>
    </div>

    <div class="bg-gray-900 rounded-xl shadow-lg overflow-hidden">
        <table class="w-full text-sm text-left">
            <thead class="bg-gray-700 text-gray-300 uppercase text-xs tracking-wider">
                <tr>
                    <th class="px-6 py-4">ID</th>
                    <th class="px-6 py-4">Image</th>
                    <th class="px-6 py-4">Product Name</th>
                    <th class="px-6 py-4">Description</th>
                    <th class="px-6 py-4">Price</th>
                    <th class="px-6 py-4">Qty</th>
                    <th class="px-6 py-4">Seller ID</th>
                    <th class="px-6 py-4">Status</th>
                    <th class="px-6 py-4 text-center">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-700">
                <c:choose>
                    <c:when test="${empty products}">
                        <tr>
                            <td colspan="9" class="px-6 py-12 text-center text-gray-400">
                                <div class="flex flex-col items-center gap-2">
                                    <span class="text-4xl">🧸</span>
                                    <p class="font-semibold">No products found.</p>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${products}" var="product">
                            <tr class="hover:bg-gray-800 transition-colors">
                                <td class="px-6 py-4 text-gray-400">#${product.productId}</td>
                                <td class="px-6 py-4">
                                    <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                                         alt="${product.productName}"
                                         class="w-14 h-14 object-cover rounded-lg bg-gray-700 border border-gray-600"
                                         onerror="this.src='https://via.placeholder.com/56?text=Toy'">
                                </td>
                                <td class="px-6 py-4 font-semibold text-white">${product.productName}</td>
                                <td class="px-6 py-4 text-gray-400 max-w-xs truncate">${product.description}</td>
                                <td class="px-6 py-4 text-emerald-400 font-bold">Rs. ${product.price}</td>
                                <td class="px-6 py-4 text-gray-300">${product.quantity}</td>
                                <td class="px-6 py-4 text-gray-400">${product.sellerId}</td>
                                <td class="px-6 py-4">
                                    <c:choose>
                                        <c:when test="${product.active}">
                                            <span class="bg-green-800 text-green-300 text-xs font-bold px-3 py-1 rounded-full">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-red-900 text-red-300 text-xs font-bold px-3 py-1 rounded-full">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <form action="${pageContext.request.contextPath}/admin/toys" method="post"
                                          onsubmit="return confirm('Are you sure you want to delete \'${product.productName}\'? This action cannot be undone.');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${product.productId}">
                                        <button type="submit"
                                                class="bg-red-600 hover:bg-red-700 text-white text-xs font-semibold px-4 py-2 rounded-lg transition-all transform hover:scale-105">
                                            🗑 Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</main>

<%@ include file="./partials/adminFooter.jsp"%>

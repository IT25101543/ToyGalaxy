<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/SellerHeader.jsp" %>

<main class="p-6 w-full">
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="bg-green-500 text-white px-4 py-3 rounded-lg shadow mb-6 transition-opacity duration-500 animate-fade-in">
            <p>${success}</p>
            <c:remove var="success" scope="session"/>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="bg-red-500 text-white px-4 py-3 rounded-lg shadow mb-6 transition-opacity duration-500 animate-fade-in">
            <p>${error}</p>
            <c:remove var="error" scope="session"/>
        </div>
    </c:if>

    <!-- Create/Edit Product Form -->
    <c:if test="${mode == 'edit' || mode == 'create'}">
        <div class="bg-gray-900 rounded-xl shadow-lg p-6 mb-6 transition-transform transform hover:scale-105 max-w-3xl mx-auto">
            <h2 class="text-2xl font-bold mb-4 text-purple-400">
                <c:choose>
                    <c:when test="${mode == 'create'}">Add New Product</c:when>
                    <c:otherwise>Edit Product</c:otherwise>
                </c:choose>
            </h2>
            <form action="${pageContext.request.contextPath}/seller/products" method="post" enctype="multipart/form-data" class="space-y-4" id="productForm">
                <input type="hidden" name="action" value="${mode == 'create' ? 'create' : 'update'}">
                <c:if test="${mode == 'edit'}">
                    <input type="hidden" name="id" value="${currentProduct.productId}" />
                </c:if>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <input type="text" name="productName" value="${currentProduct.productName}" placeholder="Product Name"
                        class="w-full px-4 py-2 rounded-lg bg-gray-800 text-white border border-gray-600 focus:outline-none" required />

                    <input type="number" name="price" step="0.01" min="0.01" value="${currentProduct.price}" placeholder="Price"
                        class="w-full px-4 py-2 rounded-lg bg-gray-800 text-white border border-gray-600 focus:outline-none" required />
                </div>

                <textarea name="description" placeholder="Description"
                    class="w-full px-4 py-2 rounded-lg bg-gray-800 text-white border border-gray-600 focus:outline-none resize-none" rows="4"
                    required>${currentProduct.description}</textarea>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <input type="number" name="quantity" min="0" value="${currentProduct.quantity}" placeholder="Stock Quantity"
                        class="w-full px-4 py-2 rounded-lg bg-gray-800 text-white border border-gray-600 focus:outline-none" required />
                    <input type="file" name="image" accept="image/*" class="w-full text-white" />
                </div>

                <div class="flex items-center space-x-3 bg-gray-800 p-3 rounded-lg border border-gray-600">
                    <input type="checkbox" id="isActive" name="isActive" value="true" 
                        ${mode == 'create' || currentProduct.active ? 'checked' : ''} 
                        class="w-5 h-5 text-purple-600 rounded focus:ring-purple-500 bg-gray-700 border-gray-600">
                    <label for="isActive" class="text-white font-medium">Active Status (Visible to Buyers)</label>
                </div>

                <div class="flex justify-end space-x-3">
                    <a href="${pageContext.request.contextPath}/seller/products" class="bg-gray-600 hover:bg-gray-500 text-white px-4 py-2 rounded">Cancel</a>
                    <button type="submit" class="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded">
                        <c:choose>
                            <c:when test="${mode == 'create'}">Create Product</c:when>
                            <c:otherwise>Update Product</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </c:if>

    <!-- View Product -->
    <c:if test="${mode == 'view'}">
        <div class="bg-gray-900 rounded-xl shadow-lg p-6 mb-6 max-w-3xl mx-auto text-white">
            <h2 class="text-2xl font-bold mb-4 text-purple-400">Product Details</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <p><strong>Name:</strong> ${currentProduct.productName}</p>
                    <p><strong>Price:</strong> Rs. ${currentProduct.price}</p>
                    <p><strong>Stock:</strong> ${currentProduct.quantity}</p>
                    <p><strong>Description:</strong> ${currentProduct.description}</p>
                </div>
                <div>
                    <c:if test="${not empty currentProduct.imageUrl}">
                        <img src="${pageContext.request.contextPath}/${currentProduct.imageUrl}" alt="Product Image"
                            class="rounded-lg max-h-64 object-cover border border-gray-700">
                    </c:if>
                    <c:if test="${empty currentProduct.imageUrl}">
                        <p class="text-gray-400">No image available</p>
                    </c:if>
                </div>
            </div>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/seller/products" class="text-purple-400 hover:underline">← Back to List</a>
            </div>
        </div>
    </c:if>

    <!-- Product List -->
    <c:if test="${mode == 'list'}">
        <div class="bg-gray-900 rounded-xl shadow-lg overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-700 flex justify-between items-center">
                <h2 class="text-2xl font-bold text-white">Your Products</h2>
                <a href="${pageContext.request.contextPath}/seller/products?mode=create"
                    class="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-md text-sm font-medium">
                    + Add Product
                </a>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-700 text-white">
                    <thead class="bg-gray-800">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">ID</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Name</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Price</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Stock</th>
                            <th class="px-6 py-3 text-left text-xs font-semibold uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-gray-900 divide-y divide-gray-800">
                        <c:forEach var="p" items="${products}">
                            <tr class="hover:bg-gray-800 transition-all">
                                <td class="px-6 py-4 whitespace-nowrap">${p.productId}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${p.productName}</td>
                                <td class="px-6 py-4 whitespace-nowrap">Rs. ${p.price}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${p.quantity}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <a href="${pageContext.request.contextPath}/seller/products?mode=view&id=${p.productId}" class="text-blue-400 hover:underline mr-3">View</a>
                                    <a href="${pageContext.request.contextPath}/seller/products?mode=edit&id=${p.productId}" class="text-yellow-400 hover:underline mr-3">Edit</a>
                                    <form action="${pageContext.request.contextPath}/seller/products" method="post" class="inline">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="id" value="${p.productId}" />
                                        <button type="submit" onclick="return confirm('Are you sure you want to delete this product?')" class="text-red-400 hover:underline">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
</main>

<!-- Optional JavaScript validation -->
<script>
    document.getElementById("productForm")?.addEventListener("submit", function (e) {
        const price = parseFloat(document.querySelector("input[name='price']").value);
        const quantity = parseInt(document.querySelector("input[name='quantity']").value);

        if (price < 0.01) {
            alert("Price must be at least 0.01");
            e.preventDefault();
        }

        if (quantity < 0) {
            alert("Stock quantity cannot be negative");
            e.preventDefault();
        }
    });
</script>

<%@ include file="../partials/SellerFooter.jsp" %>

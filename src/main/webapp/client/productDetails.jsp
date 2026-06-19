<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="partials/UserHeader.jsp" %>

<main class="min-h-screen pt-32 pb-20 px-5 bg-gradient-to-br from-gray-50 to-indigo-50">
    <div class="max-w-6xl mx-auto">
        
        <!-- Breadcrumbs -->
        <nav class="flex mb-8 text-sm font-medium text-gray-500">
            <a href="${pageContext.request.contextPath}/index" class="hover:text-indigo-600 transition-colors">Home</a>
            <span class="mx-2">/</span>
            <a href="${pageContext.request.contextPath}/user/products" class="hover:text-indigo-600 transition-colors">Products</a>
            <span class="mx-2">/</span>
            <span class="text-gray-900">${product.productName}</span>
        </nav>

        <div class="bg-white rounded-[3rem] shadow-2xl overflow-hidden border border-white/20 backdrop-blur-xl">
            <div class="grid grid-cols-1 lg:grid-cols-2">
                
                <!-- Product Image -->
                <div class="p-12 bg-gray-50 flex items-center justify-center relative overflow-hidden group">
                    <div class="absolute inset-0 bg-gradient-to-br from-indigo-500/5 to-purple-500/5 opacity-0 group-hover:opacity-100 transition-opacity"></div>
                    <img src="${pageContext.request.contextPath}/${not empty product.imageUrl ? product.imageUrl : 'client/images/placeholder.png'}" 
                         alt="${product.productName}" class="w-full h-[400px] object-contain transform group-hover:scale-105 transition-transform duration-700">
                </div>

                <!-- Product Info -->
                <div class="p-12 lg:p-16 flex flex-col justify-center">
                    <div class="mb-8">
                        <div class="flex items-center space-x-2 mb-4">
                            <div class="flex text-yellow-400">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                            </div>
                            <span class="text-sm text-gray-400 font-bold">(${reviews.size()} Reviews)</span>
                        </div>
                        <h1 class="text-5xl font-black text-gray-900 leading-tight mb-4">${product.productName}</h1>
                        <p class="text-gray-500 text-lg leading-relaxed">${product.description}</p>
                    </div>

                    <div class="flex items-center justify-between mb-10 pb-10 border-b border-gray-100">
                        <div>
                            <span class="text-sm text-gray-400 font-bold uppercase tracking-widest block mb-1">Price</span>
                            <span class="text-5xl font-black text-indigo-600">Rs. ${product.price}</span>
                        </div>
                        <div class="text-right">
                            <span class="text-sm text-gray-400 font-bold uppercase tracking-widest block mb-1">Availability</span>
                            <span class="${product.quantity > 0 ? 'text-green-500' : 'text-red-500'} font-black text-xl">
                                ${product.quantity > 0 ? 'In Stock' : 'Out of Stock'}
                            </span>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/user/order" method="POST">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <div class="flex items-center space-x-6">
                            <div class="w-32">
                                <label class="block text-xs font-black text-gray-400 uppercase tracking-widest mb-2 ml-1">Quantity</label>
                                <input type="number" name="quantity" value="1" min="1" max="${product.quantity}" 
                                       class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl font-bold text-center focus:ring-2 focus:ring-indigo-500 outline-none">
                            </div>
                            <button type="submit" ${product.quantity <= 0 ? 'disabled' : ''} 
                                    class="flex-1 py-5 bg-indigo-600 text-white rounded-3xl font-black text-xl shadow-xl hover:bg-indigo-700 hover:-translate-y-1 transition-all disabled:opacity-50 disabled:translate-y-0 active:scale-95">
                                Buy Now
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Reviews Section -->
        <div class="mt-20">
            <div class="flex justify-between items-center mb-12">
                <h2 class="text-4xl font-black text-gray-900">Customer Reviews</h2>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <c:forEach items="${reviews}" var="review">
                    <div class="bg-white rounded-3xl p-8 shadow-xl border border-white/20 backdrop-blur-lg hover:shadow-2xl transition-all">
                        <div class="flex items-center justify-between mb-6">
                            <div class="flex items-center space-x-4">
                                <div class="w-12 h-12 bg-indigo-100 rounded-full flex items-center justify-center text-indigo-600 font-black">
                                    R
                                </div>
                                <div>
                                    <h4 class="font-bold text-gray-900">User #${review.userId}</h4>
                                    <p class="text-xs text-gray-400 font-bold uppercase">${review.createdAt}</p>
                                </div>
                            </div>
                            <div class="bg-indigo-50 px-4 py-2 rounded-2xl text-indigo-600 font-black">
                                ${review.rating}★
                            </div>
                        </div>
                        <p class="text-gray-600 leading-relaxed italic text-lg">"${review.comment}"</p>
                    </div>
                </c:forEach>
                
                <c:if test="${empty reviews}">
                    <div class="col-span-2 text-center py-20 bg-white rounded-3xl border-2 border-dashed border-gray-200">
                        <div class="text-6xl text-gray-200 mb-6"><i class="fas fa-comments"></i></div>
                        <h3 class="text-2xl font-black text-gray-800">No reviews yet</h3>
                        <p class="text-gray-500 mt-2">Be the first to share your thoughts about this product!</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</main>

<%@ include file="partials/UserFooter.jsp" %>

<%@ page import="model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/UserHeader.jsp" %>

<main class="min-h-screen pt-24 pb-12 px-5 bg-gradient-to-br from-indigo-50 via-white to-purple-50">
    <div class="max-w-5xl mx-auto">

        <!-- Profile Header Card -->
        <div class="bg-white rounded-[3rem] shadow-2xl overflow-hidden border border-white/20 backdrop-blur-xl mb-12">
            <div class="h-48 bg-gradient-to-r from-indigo-600 to-purple-600 relative">
                <div class="absolute -bottom-16 left-12">
                    <div class="w-32 h-32 bg-white rounded-full p-2 shadow-2xl">
                        <div class="w-full h-full bg-indigo-100 rounded-full flex items-center justify-center text-indigo-600 text-4xl font-black">
                            ${user.name.substring(0,1).toUpperCase()}
                        </div>
                    </div>
                </div>
            </div>

            <div class="pt-20 pb-10 px-12">
                <div class="flex justify-between items-start">
                    <div>
                        <h1 class="text-4xl font-black text-gray-900">${user.name}</h1>
                        <p class="text-gray-500 font-medium flex items-center mt-1">
                            <i class="fas fa-envelope mr-2 text-indigo-400"></i> ${user.email}
                        </p>
                    </div>
                    <div class="flex space-x-3">
                        <button onclick="toggleEdit()" class="px-6 py-3 bg-indigo-600 text-white rounded-2xl font-bold hover:bg-indigo-700 transition-all shadow-lg hover:-translate-y-1">
                            Edit Profile
                        </button>
                        <form method="post" action="${pageContext.request.contextPath}/user/profile" onsubmit="return confirm('Are you sure? This cannot be undone.')">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="px-6 py-3 bg-red-50 text-red-600 border border-red-100 rounded-2xl font-bold hover:bg-red-100 transition-all">
                                Delete Account
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Profile Stats -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mt-12 pt-8 border-t border-gray-100">
                    <div class="p-6 bg-gray-50 rounded-3xl">
                        <span class="text-gray-400 text-sm font-bold uppercase tracking-wider">Address</span>
                        <p class="text-gray-800 font-semibold mt-1">${user.address != null && !user.address.isEmpty() ? user.address : 'Not provided'}</p>
                    </div>
                    <div class="p-6 bg-gray-50 rounded-3xl">
                        <span class="text-gray-400 text-sm font-bold uppercase tracking-wider">Phone</span>
                        <p class="text-gray-800 font-semibold mt-1">${user.phone != null && !user.phone.isEmpty() ? user.phone : 'Not provided'}</p>
                    </div>
                    <div class="p-6 bg-indigo-50 rounded-3xl">
                        <span class="text-indigo-400 text-sm font-bold uppercase tracking-wider">Total Orders</span>
                        <p class="text-indigo-600 font-black text-2xl mt-1">${orders.size()}</p>
                    </div>
                    <div class="p-6 bg-purple-50 rounded-3xl">
                        <span class="text-purple-400 text-sm font-bold uppercase tracking-wider">Reviews Written</span>
                        <p class="text-purple-600 font-black text-2xl mt-1">${reviews.size()}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Profile Modal -->
        <div id="profileEditForm" class="hidden fixed inset-0 bg-black/60 backdrop-blur-sm z-[2000] flex items-center justify-center p-5">
            <div class="bg-white rounded-[2.5rem] shadow-2xl w-full max-w-2xl p-10 relative">
                <button onclick="toggleEdit()" class="absolute top-8 right-8 text-gray-400 hover:text-gray-600">
                    <i class="fas fa-times text-xl"></i>
                </button>
                <h2 class="text-3xl font-black text-gray-900 mb-8">Update Your Profile</h2>
                <form method="post" action="${pageContext.request.contextPath}/user/profile" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <input type="hidden" name="action" value="update">
                    <div class="space-y-2">
                        <label class="text-sm font-bold text-gray-700 ml-1">Full Name</label>
                        <input type="text" name="name" value="${user.name}" required class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-bold text-gray-700 ml-1">Email Address</label>
                        <input type="email" name="email" value="${user.email}" required class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-bold text-gray-700 ml-1">Phone Number</label>
                        <input type="text" name="phone" value="${user.phone}" class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-bold text-gray-700 ml-1">New Password</label>
                        <input type="password" name="password" placeholder="Leave blank to keep same" class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                    </div>
                    <div class="md:col-span-2 space-y-2">
                        <label class="text-sm font-bold text-gray-700 ml-1">Home Address</label>
                        <textarea name="address" rows="3" class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">${user.address}</textarea>
                    </div>
                    <div class="md:col-span-2 pt-4">
                        <button type="submit" class="w-full py-4 bg-indigo-600 text-white rounded-2xl font-bold text-lg shadow-lg hover:bg-indigo-700 transition-all">
                            Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- ===== ORDER HISTORY ===== -->
        <div class="mt-10 mb-14">
            <div class="flex justify-between items-end mb-8">
                <div>
                    <h2 class="text-4xl font-black text-gray-900">Order History</h2>
                    <p class="text-gray-500 font-medium mt-2">All your past purchases at a glance</p>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty orders}">
                    <div class="bg-white rounded-3xl shadow-xl overflow-hidden border border-gray-50">
                        <table class="w-full text-sm">
                            <thead>
                                <tr class="bg-indigo-50 text-indigo-700 uppercase text-xs font-black tracking-widest">
                                    <th class="py-4 px-6 text-left">Order #</th>
                                    <th class="py-4 px-6 text-left">Product</th>
                                    <th class="py-4 px-6 text-center">Qty</th>
                                    <th class="py-4 px-6 text-right">Total</th>
                                    <th class="py-4 px-6 text-center">Status</th>
                                    <th class="py-4 px-6 text-left">Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="order" varStatus="loop">
                                    <c:set var="prod" value="${productService.getProductById(order.productId)}"/>
                                    <tr class="${loop.index % 2 == 0 ? 'bg-white' : 'bg-gray-50/50'} border-t border-gray-50 hover:bg-indigo-50/30 transition-colors">
                                        <td class="py-4 px-6 font-bold text-gray-500">#${order.orderId}</td>
                                        <td class="py-4 px-6 font-semibold text-gray-800">
                                            ${prod != null ? prod.productName : 'Product #'.concat(order.productId)}
                                        </td>
                                        <td class="py-4 px-6 text-center text-gray-600">${order.quantity}</td>
                                        <td class="py-4 px-6 text-right font-bold text-gray-800">Rs. ${order.totalPrice}</td>
                                        <td class="py-4 px-6 text-center">
                                            <span class="${order.status == 'Paid' ? 'bg-emerald-100 text-emerald-700' : order.status == 'Cash on Delivery' ? 'bg-amber-100 text-amber-700' : 'bg-gray-100 text-gray-600'} px-3 py-1 rounded-full text-xs font-bold">
                                                ${order.status}
                                            </span>
                                        </td>
                                        <td class="py-4 px-6 text-gray-500">${order.orderDate}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="bg-white rounded-3xl p-12 shadow-xl border border-dashed border-gray-200 text-center">
                        <div class="w-20 h-20 bg-gray-50 rounded-full flex items-center justify-center mx-auto mb-6 text-gray-300 text-3xl">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-800">No orders yet</h3>
                        <p class="text-gray-500 mt-2">Head to the Marketplace to start shopping!</p>
                        <a href="${pageContext.request.contextPath}/user/products"
                           class="inline-block mt-6 px-6 py-3 bg-indigo-600 text-white rounded-2xl font-bold hover:bg-indigo-700 transition-all">
                            Browse Products
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- ===== MY REVIEWS ===== -->
        <div class="mt-4">
            <div class="flex justify-between items-end mb-8">
                <div>
                    <h2 class="text-4xl font-black text-gray-900">My Reviews</h2>
                    <p class="text-gray-500 font-medium mt-2">Your submitted feedback on purchased products</p>
                </div>
                <a href="${pageContext.request.contextPath}/user/reviews"
                   class="px-5 py-3 bg-indigo-50 text-indigo-600 rounded-2xl font-bold hover:bg-indigo-100 transition-all text-sm">
                    Manage All Reviews
                </a>
            </div>

            <!-- Pending Reviews Banner -->
            <c:if test="${not empty unreviewedOrders}">
                <div class="bg-amber-50 border border-amber-200 rounded-3xl p-6 mb-8 flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 bg-amber-100 rounded-2xl flex items-center justify-center text-amber-600 text-xl">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div>
                            <p class="font-black text-amber-800">You have ${unreviewedOrders.size()} order(s) waiting for a review</p>
                            <p class="text-amber-600 text-sm font-medium mt-0.5">Share your experience to help other shoppers</p>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/user/reviews"
                       class="px-5 py-2.5 bg-amber-500 text-white rounded-2xl font-bold hover:bg-amber-600 transition-all text-sm whitespace-nowrap">
                        Write Reviews
                    </a>
                </div>
            </c:if>

            <!-- Submitted Reviews Grid -->
            <div class="grid grid-cols-1 gap-6">
                <c:forEach items="${reviews}" var="review">
                    <div class="bg-white rounded-3xl p-8 shadow-xl border border-gray-50 flex items-start space-x-6 hover:shadow-2xl transition-all group">
                        <div class="w-20 h-20 bg-indigo-50 rounded-2xl flex items-center justify-center text-indigo-600 text-3xl font-black flex-shrink-0">
                            ${review.rating}★
                        </div>
                        <div class="flex-1">
                            <div class="flex justify-between">
                                <h3 class="text-xl font-bold text-gray-800">
                                    <c:set var="p" value="${productService.getProductById(review.productId)}"/>
                                    ${p != null ? p.productName : 'Product #'.concat(review.productId)}
                                </h3>
                                <div class="flex space-x-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                    <button onclick="editReview(${review.reviewId}, ${review.rating}, '${review.comment}')"
                                            class="p-2 text-indigo-600 hover:bg-indigo-50 rounded-lg transition-colors">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/user/reviews" method="POST"
                                          onsubmit="return confirm('Delete this review?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${review.reviewId}">
                                        <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/user/profile">
                                        <button type="submit" class="p-2 text-red-500 hover:bg-red-50 rounded-lg transition-colors">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <p class="text-gray-600 mt-2 leading-relaxed italic">"${review.comment}"</p>
                            <p class="text-gray-400 text-xs font-bold mt-4 uppercase tracking-tighter">Posted on: ${review.createdAt}</p>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty reviews}">
                    <div class="bg-white rounded-3xl p-12 shadow-xl border border-dashed border-gray-200 text-center">
                        <div class="w-20 h-20 bg-gray-50 rounded-full flex items-center justify-center mx-auto mb-6 text-gray-300 text-3xl">
                            <i class="fas fa-comment-slash"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-800">No reviews submitted yet</h3>
                        <p class="text-gray-500 mt-2">After you receive an order, you can share your experience here.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Review Edit Modal -->
    <div id="reviewEditModal" class="hidden fixed inset-0 bg-black/60 backdrop-blur-sm z-[2000] flex items-center justify-center p-5">
        <div class="bg-white rounded-3xl shadow-2xl w-full max-w-lg p-10 relative">
            <button onclick="document.getElementById('reviewEditModal').classList.add('hidden')"
                    class="absolute top-8 right-8 text-gray-400 hover:text-gray-600">
                <i class="fas fa-times text-xl"></i>
            </button>
            <h2 class="text-3xl font-black text-gray-900 mb-8">Edit Your Review</h2>
            <form action="${pageContext.request.contextPath}/user/reviews" method="POST" class="space-y-6">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" id="editReviewId">
                <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/user/profile">
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Rating</label>
                    <div class="flex space-x-4">
                        <c:forEach var="i" begin="1" end="5">
                            <label class="flex-1">
                                <input type="radio" name="rating" value="${i}" id="rating${i}" class="sr-only peer">
                                <div class="p-3 text-center border-2 border-gray-100 rounded-xl cursor-pointer peer-checked:border-indigo-600 peer-checked:bg-indigo-50 peer-checked:text-indigo-600 font-bold transition-all hover:bg-gray-50">
                                    ${i}★
                                </div>
                            </label>
                        </c:forEach>
                    </div>
                </div>
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Comment</label>
                    <textarea name="comment" id="editComment" rows="4" required
                              class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all"></textarea>
                </div>
                <button type="submit" class="w-full py-4 bg-indigo-600 text-white rounded-2xl font-bold text-lg shadow-lg hover:bg-indigo-700 transition-all">
                    Update Review
                </button>
            </form>
        </div>
    </div>
</main>

<%@ include file="../partials/UserFooter.jsp" %>

<script>
    function toggleEdit() {
        document.getElementById("profileEditForm").classList.toggle("hidden");
    }
    function editReview(id, rating, comment) {
        document.getElementById('editReviewId').value = id;
        document.getElementById('editComment').value = comment;
        document.getElementById('rating' + rating).checked = true;
        document.getElementById('reviewEditModal').classList.remove('hidden');
    }
</script>

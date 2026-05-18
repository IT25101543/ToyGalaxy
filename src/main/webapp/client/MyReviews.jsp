<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/UserHeader.jsp" %>

<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800;900&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Outfit', sans-serif; }
    .glass {
        background: rgba(255,255,255,0.7);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(255,255,255,0.4);
    }
    .neo-button {
        background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
        box-shadow: 0 10px 20px -10px rgba(79,70,229,0.5);
    }
    .neo-button:hover {
        box-shadow: 0 15px 25px -5px rgba(79,70,229,0.6);
        transform: translateY(-2px);
    }
</style>

<main class="flex-1 min-h-screen p-8 bg-slate-50 relative overflow-hidden">
    <!-- Decorative background -->
    <div class="fixed top-[-10%] right-[-10%] w-[40%] h-[40%] bg-indigo-200/20 rounded-full blur-[120px] pointer-events-none"></div>
    <div class="fixed bottom-[-10%] left-[-10%] w-[40%] h-[40%] bg-blue-200/20 rounded-full blur-[120px] pointer-events-none"></div>

    <div class="max-w-6xl mx-auto relative z-10">

        <!-- Page Header -->
        <div class="flex justify-between items-end mb-10">
            <div>
                <h1 class="text-4xl font-black text-slate-900 tracking-tight">My Reviews</h1>
                <p class="text-slate-500 font-medium mt-2">Manage your feedback and rate products you've purchased</p>
            </div>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="glass border-l-4 border-emerald-500 p-5 rounded-2xl mb-8 flex items-center">
                <div class="w-10 h-10 bg-emerald-500/10 text-emerald-600 rounded-full flex items-center justify-center mr-4">
                    <i class="fas fa-check"></i>
                </div>
                <p class="font-bold text-slate-800">${sessionScope.success}</p>
                <c:remove var="success" scope="session"/>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="glass border-l-4 border-rose-500 p-5 rounded-2xl mb-8 flex items-center">
                <div class="w-10 h-10 bg-rose-500/10 text-rose-600 rounded-full flex items-center justify-center mr-4">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <p class="font-bold text-slate-800">${sessionScope.error}</p>
                <c:remove var="error" scope="session"/>
            </div>
        </c:if>

        <!-- =================== LIST MODE =================== -->
        <c:if test="${mode == 'list'}">

            <!-- ---- PENDING REVIEWS SECTION ---- -->
            <c:if test="${not empty unreviewedOrders}">
                <div class="mb-12">
                    <div class="flex items-center gap-3 mb-6">
                        <div class="w-8 h-8 bg-amber-500 rounded-xl flex items-center justify-center text-white text-sm">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h2 class="text-2xl font-black text-slate-800">Awaiting Your Review</h2>
                        <span class="bg-amber-100 text-amber-700 px-3 py-1 rounded-full text-xs font-black">
                            ${unreviewedOrders.size()} pending
                        </span>
                    </div>

                    <div class="grid grid-cols-1 gap-5">
                        <c:forEach items="${unreviewedOrders}" var="order">
                            <c:set var="prod" value="${productService.getProductById(order.productId)}"/>
                            <div class="glass rounded-3xl border border-amber-100 bg-amber-50/40 overflow-hidden shadow-md" id="pending-${order.orderId}">
                                <!-- Order summary bar -->
                                <div class="flex items-center justify-between px-8 py-5 border-b border-amber-100">
                                    <div class="flex items-center gap-5">
                                        <div class="w-14 h-14 bg-white rounded-2xl shadow-sm flex items-center justify-center text-amber-500 text-2xl">
                                            <i class="fas fa-box-open"></i>
                                        </div>
                                        <div>
                                            <p class="font-black text-slate-800 text-lg">
                                                ${prod != null ? prod.productName : 'Product #'.concat(order.productId)}
                                            </p>
                                            <p class="text-slate-500 text-sm font-medium">
                                                Order #${order.orderId} &bull; ${order.orderDate} &bull; Rs. ${order.totalPrice}
                                            </p>
                                        </div>
                                    </div>
                                    <button onclick="toggleReviewForm('form-${order.orderId}')"
                                            class="neo-button px-6 py-3 text-white rounded-2xl font-bold text-sm transition-all active:scale-95 flex items-center gap-2">
                                        <i class="fas fa-pen"></i> Write Review
                                    </button>
                                </div>

                                <!-- Inline Review Form (hidden by default) -->
                                <div id="form-${order.orderId}" class="hidden px-8 py-7 bg-white/60">
                                    <form action="${pageContext.request.contextPath}/user/reviews" method="POST" class="space-y-5">
                                        <input type="hidden" name="action" value="create"/>
                                        <input type="hidden" name="orderId" value="${order.orderId}"/>
                                        <input type="hidden" name="productId" value="${order.productId}"/>
                                        <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/user/reviews"/>

                                        <div>
                                            <label class="block text-xs font-black text-slate-400 uppercase tracking-widest mb-3">Your Rating</label>
                                            <div class="flex gap-3">
                                                <c:forEach var="i" begin="1" end="5">
                                                    <div class="relative">
                                                        <input type="radio" name="rating" id="pstar-${order.orderId}-${i}" value="${i}" required class="sr-only peer">
                                                        <label for="pstar-${order.orderId}-${i}"
                                                               class="w-12 h-12 rounded-xl bg-white border-2 border-slate-100 flex items-center justify-center text-slate-300 text-lg cursor-pointer transition-all hover:scale-110 active:scale-90 peer-checked:bg-amber-50 peer-checked:border-amber-400 peer-checked:text-amber-500 shadow-sm font-bold">
                                                            ${i}★
                                                        </label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <div>
                                            <label class="block text-xs font-black text-slate-400 uppercase tracking-widest mb-3">Your Experience</label>
                                            <textarea name="comment" rows="3" required
                                                      placeholder="How was this product? Be honest and helpful!"
                                                      class="w-full p-4 bg-white border border-slate-100 rounded-2xl focus:ring-4 focus:ring-indigo-100 outline-none transition-all font-medium text-slate-700 resize-none shadow-inner"></textarea>
                                        </div>

                                        <div class="flex gap-3 pt-2">
                                            <button type="submit"
                                                    class="neo-button px-8 py-3.5 text-white rounded-2xl font-black text-sm transition-all active:scale-95">
                                                <i class="fas fa-paper-plane mr-2"></i>Submit Review
                                            </button>
                                            <button type="button" onclick="toggleReviewForm('form-${order.orderId}')"
                                                    class="px-8 py-3.5 bg-white text-slate-400 rounded-2xl font-black text-sm border border-slate-100 hover:bg-slate-50 transition-all">
                                                Cancel
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- ---- SUBMITTED REVIEWS SECTION ---- -->
            <div>
                <div class="flex items-center gap-3 mb-6">
                    <div class="w-8 h-8 bg-emerald-500 rounded-xl flex items-center justify-center text-white text-sm">
                        <i class="fas fa-check"></i>
                    </div>
                    <h2 class="text-2xl font-black text-slate-800">Submitted Reviews</h2>
                    <c:if test="${not empty reviews}">
                        <span class="bg-emerald-100 text-emerald-700 px-3 py-1 rounded-full text-xs font-black">
                            ${reviews.size()} review(s)
                        </span>
                    </c:if>
                </div>

                <c:choose>
                    <c:when test="${not empty reviews}">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-7">
                            <c:forEach items="${reviews}" var="review">
                                <div class="glass group rounded-[2.5rem] p-8 shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-2 border border-white/60">
                                    <div class="flex justify-between items-start mb-5">
                                        <div class="flex gap-1 text-amber-400">
                                            <c:forEach begin="1" end="${review.rating}">
                                                <i class="fas fa-star text-xs"></i>
                                            </c:forEach>
                                            <c:if test="${review.rating < 5}">
                                                <c:forEach begin="${review.rating + 1}" end="5">
                                                    <i class="far fa-star text-xs text-slate-200"></i>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                        <span class="text-[10px] font-black text-slate-300 uppercase tracking-widest">ID #${review.reviewId}</span>
                                    </div>

                                    <h3 class="text-lg font-bold text-slate-800 mb-2 truncate">
                                        <c:set var="p" value="${productService.getProductById(review.productId)}"/>
                                        ${p != null ? p.productName : 'Product #'.concat(review.productId)}
                                    </h3>

                                    <p class="text-slate-600 font-medium mb-5 leading-relaxed line-clamp-2 italic">"${review.comment}"</p>

                                    <div class="pt-5 border-t border-slate-50 flex items-center justify-between mb-6">
                                        <div>
                                            <p class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1">Product ID</p>
                                            <p class="text-xs font-bold text-slate-800">#${review.productId}</p>
                                        </div>
                                        <div class="text-right">
                                            <p class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1">Posted</p>
                                            <p class="text-[10px] font-bold text-slate-500">${review.createdAt}</p>
                                        </div>
                                    </div>

                                    <div class="flex gap-3">
                                        <a href="${pageContext.request.contextPath}/user/reviews?mode=view&id=${review.reviewId}"
                                           class="flex-1 py-3 text-center bg-slate-50 text-slate-600 rounded-xl font-bold text-xs hover:bg-slate-100 transition-colors">View</a>
                                        <a href="${pageContext.request.contextPath}/user/reviews?mode=edit&id=${review.reviewId}"
                                           class="flex-1 py-3 text-center bg-indigo-50 text-indigo-600 rounded-xl font-bold text-xs hover:bg-indigo-100 transition-colors">Edit</a>
                                        <form action="${pageContext.request.contextPath}/user/reviews" method="POST"
                                              onsubmit="return confirm('Delete this review?');" class="flex-1">
                                            <input type="hidden" name="action" value="delete"/>
                                            <input type="hidden" name="id" value="${review.reviewId}"/>
                                            <button type="submit" class="w-full py-3 text-center bg-rose-50 text-rose-500 rounded-xl font-bold text-xs hover:bg-rose-100 transition-colors">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="glass rounded-[3rem] p-16 text-center border-2 border-dashed border-slate-200">
                            <div class="w-20 h-20 bg-white rounded-full flex items-center justify-center mx-auto mb-6 shadow-sm text-slate-300 text-3xl">
                                <i class="fas fa-comment-alt"></i>
                            </div>
                            <h3 class="text-2xl font-black text-slate-800 tracking-tight">No reviews submitted yet</h3>
                            <p class="text-slate-500 mt-2 max-w-xs mx-auto font-medium">
                                <c:choose>
                                    <c:when test="${not empty unreviewedOrders}">
                                        Use the "Write Review" buttons above to share your experience!
                                    </c:when>
                                    <c:otherwise>
                                        Place an order first, then come back to review your purchase.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- =================== EDIT MODE =================== -->
        <c:if test="${mode == 'edit'}">
            <div class="max-w-2xl mx-auto">
                <div class="glass rounded-[3rem] shadow-2xl p-12 border border-white/60">
                    <h2 class="text-3xl font-black text-slate-900 mb-10 tracking-tight">Edit Your Feedback</h2>
                    <form action="${pageContext.request.contextPath}/user/reviews" method="POST" class="space-y-8">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="id" value="${currentReview.reviewId}"/>
                        <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/user/reviews"/>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div>
                                <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">Product</label>
                                <c:set var="editProd" value="${productService.getProductById(currentReview.productId)}"/>
                                <input type="text" readonly
                                       value="${editProd != null ? editProd.productName : 'Product #'.concat(currentReview.productId)}"
                                       class="w-full p-4 bg-white/50 border border-slate-100 rounded-2xl font-bold text-slate-800 opacity-60 cursor-not-allowed">
                            </div>
                            <div>
                                <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">Your Rating</label>
                                <div class="flex gap-3">
                                    <c:forEach var="i" begin="1" end="5">
                                        <div class="relative">
                                            <input type="radio" name="rating" id="estar-${i}" value="${i}"
                                                   ${currentReview.rating == i ? 'checked' : ''} required class="sr-only peer">
                                            <label for="estar-${i}"
                                                   class="w-11 h-11 rounded-xl bg-white border-2 border-slate-100 flex items-center justify-center text-slate-300 cursor-pointer transition-all hover:scale-110 peer-checked:bg-amber-50 peer-checked:border-amber-400 peer-checked:text-amber-500 shadow-sm font-bold text-sm">
                                                ${i}★
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <div>
                            <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">Your Experience</label>
                            <textarea name="comment" rows="5" required
                                      class="w-full p-6 bg-white/50 border border-slate-100 rounded-[2rem] focus:ring-4 focus:ring-indigo-100 outline-none transition-all font-medium text-slate-700 shadow-inner resize-none">${currentReview.comment}</textarea>
                        </div>

                        <div class="flex gap-4 pt-4">
                            <button type="submit" class="neo-button flex-1 py-5 text-white rounded-2xl font-black text-lg transition-all active:scale-95">
                                Save Changes <i class="fas fa-check ml-2"></i>
                            </button>
                            <a href="${pageContext.request.contextPath}/user/reviews"
                               class="flex-1 py-5 bg-white text-slate-400 rounded-2xl font-black text-lg text-center border border-slate-100 hover:bg-slate-50 transition-all">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

        <!-- =================== VIEW MODE =================== -->
        <c:if test="${mode == 'view'}">
            <div class="max-w-2xl mx-auto">
                <div class="glass rounded-[3rem] shadow-2xl p-12 border border-white/60">
                    <div class="flex justify-between items-start mb-10">
                        <div>
                            <h2 class="text-3xl font-black text-slate-900 tracking-tight">Review Details</h2>
                            <c:set var="viewProd" value="${productService.getProductById(currentReview.productId)}"/>
                            <p class="text-slate-500 font-medium mt-1">
                                ${viewProd != null ? viewProd.productName : 'Product #'.concat(currentReview.productId)}
                            </p>
                        </div>
                        <div class="flex gap-1 text-amber-400 bg-amber-50 px-4 py-2 rounded-xl border border-amber-100 shadow-sm">
                            <c:forEach begin="1" end="${currentReview.rating}">
                                <i class="fas fa-star text-xs"></i>
                            </c:forEach>
                            <span class="ml-2 text-xs font-black text-amber-600">${currentReview.rating}.0</span>
                        </div>
                    </div>

                    <div class="bg-white/40 rounded-[2.5rem] p-8 border border-white/60 mb-10 shadow-inner">
                        <p class="text-xl font-medium text-slate-800 leading-relaxed italic">"${currentReview.comment}"</p>
                    </div>

                    <div class="grid grid-cols-2 gap-8 mb-10 text-sm">
                        <div>
                            <p class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1">Posted</p>
                            <p class="font-bold text-slate-800">${currentReview.createdAt}</p>
                        </div>
                        <div class="text-right">
                            <p class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1">Last Updated</p>
                            <p class="font-bold text-slate-800">${currentReview.updatedAt}</p>
                        </div>
                    </div>

                    <div class="flex gap-4 pt-4 border-t border-slate-100">
                        <a href="${pageContext.request.contextPath}/user/reviews?mode=edit&id=${currentReview.reviewId}"
                           class="flex-1 py-4 bg-indigo-50 text-indigo-600 rounded-2xl font-black text-sm text-center hover:bg-indigo-100 transition-all">Edit Review</a>
                        <a href="${pageContext.request.contextPath}/user/reviews"
                           class="flex-1 py-4 bg-slate-50 text-slate-400 rounded-2xl font-black text-sm text-center hover:bg-slate-100 transition-all">Back to List</a>
                    </div>
                </div>
            </div>
        </c:if>

    </div>
</main>

<%@ include file="../partials/UserFooter.jsp" %>

<script>
function toggleReviewForm(id) {
    const el = document.getElementById(id);
    if (el) el.classList.toggle('hidden');
}
</script>

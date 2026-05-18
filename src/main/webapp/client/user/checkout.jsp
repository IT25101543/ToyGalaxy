<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/UserHeader.jsp" %>

<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800;900&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Outfit', sans-serif; }
    .glass {
        background: rgba(255, 255, 255, 0.7);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.4);
    }
    .neo-button {
        background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
        box-shadow: 0 10px 20px -10px rgba(79, 70, 229, 0.5);
    }
    .neo-button:hover {
        box-shadow: 0 15px 25px -5px rgba(79, 70, 229, 0.6);
        transform: translateY(-2px);
    }
</style>

<main class="flex-1 min-h-screen p-8 bg-slate-50 relative overflow-hidden">
    <div class="absolute top-[-10%] right-[-10%] w-[40%] h-[40%] bg-indigo-200/30 rounded-full blur-[120px] pointer-events-none"></div>
    <div class="absolute bottom-[-10%] left-[-10%] w-[40%] h-[40%] bg-blue-200/30 rounded-full blur-[120px] pointer-events-none"></div>

    <div class="max-w-6xl mx-auto relative z-10">
        <nav class="flex mb-8 text-sm font-medium text-gray-400">
            <span class="hover:text-indigo-600 transition-colors cursor-pointer">Marketplace</span>
            <span class="mx-2">/</span>
            <span class="hover:text-indigo-600 transition-colors cursor-pointer">${product.productName}</span>
            <span class="mx-2 text-indigo-600">/</span>
            <span class="text-indigo-600 font-bold tracking-tight">Checkout</span>
        </nav>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12">
            <!-- Left Side -->
            <div class="lg:col-span-8 space-y-8">

                <!-- Section 1: Order Recap -->
                <section class="glass rounded-[2.5rem] p-8 shadow-2xl">
                    <div class="flex items-center justify-between mb-8">
                        <h2 class="text-3xl font-black text-slate-900 tracking-tight flex items-center">
                            <span class="bg-indigo-600 text-white w-10 h-10 rounded-2xl flex items-center justify-center mr-4 text-lg shadow-lg shadow-indigo-200">1</span>
                            Review Items
                        </h2>
                        <span class="px-4 py-2 bg-indigo-50 text-indigo-600 rounded-xl text-xs font-black uppercase tracking-widest">Secure Checkout</span>
                    </div>

                    <div class="group relative flex flex-col md:flex-row items-center gap-8 p-6 bg-white/40 rounded-[2rem] border border-white/60 hover:bg-white/60">
                        <div class="relative w-40 h-40 shrink-0">
                            <div class="absolute inset-0 bg-indigo-100 rounded-[1.5rem] rotate-3 group-hover:rotate-6 transition-transform"></div>
                            <img src="${product.imageUrl != null ? product.imageUrl : (pageContext.request.contextPath.concat('/client/images/placeholder.png'))}"
                                 alt="${product.productName}"
                                 class="relative w-full h-full object-contain rounded-[1.5rem] bg-white p-4 shadow-sm border border-white/20 transition-transform group-hover:-translate-y-2 group-hover:-rotate-3">
                        </div>
                        <div class="flex-1 text-center md:text-left">
                            <h3 class="text-2xl font-extrabold text-slate-800 mb-2">${product.productName}</h3>
                            <div class="flex flex-wrap items-center justify-center md:justify-start gap-4 text-sm text-slate-500 font-medium">
                                <span class="flex items-center"><i class="fas fa-layer-group mr-2 text-indigo-400"></i> Quantity: <b class="text-slate-900 ml-1">${quantity}</b></span>
                                <span class="flex items-center"><i class="fas fa-tag mr-2 text-indigo-400"></i> Unit Price: <b class="text-slate-900 ml-1">Rs. ${product.price}</b></span>
                            </div>
                        </div>
                        <div class="text-right">
                            <p class="text-3xl font-black text-indigo-600 leading-none">Rs. ${product.price * quantity}</p>
                            <p class="text-[10px] font-black text-slate-400 uppercase tracking-widest mt-2">Total for item</p>
                        </div>
                    </div>
                </section>

                <!-- Section 2: Delivery Info -->
                <section class="glass rounded-[2.5rem] p-8 shadow-2xl">
                    <div class="flex items-center mb-8">
                        <h2 class="text-3xl font-black text-slate-900 tracking-tight flex items-center">
                            <span class="bg-indigo-600 text-white w-10 h-10 rounded-2xl flex items-center justify-center mr-4 text-lg shadow-lg shadow-indigo-200">2</span>
                            Delivery Details
                        </h2>
                    </div>
                    <div class="p-6 bg-white/50 rounded-[2rem] border border-white/60">
                        <div class="flex items-center gap-4 mb-4">
                            <div class="w-12 h-12 bg-indigo-100 rounded-xl flex items-center justify-center">
                                <i class="fas fa-map-marker-alt text-indigo-600 text-xl"></i>
                            </div>
                            <div>
                                <p class="font-black text-slate-800">Delivery to your address</p>
                                <p class="text-sm text-slate-500 font-medium">Standard delivery — FREE</p>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 mt-4 p-4 bg-emerald-50 rounded-2xl border border-emerald-100">
                            <i class="fas fa-check-circle text-emerald-500 text-xl"></i>
                            <p class="text-sm font-bold text-emerald-700">Your order will be processed and shipped within 2–5 business days.</p>
                        </div>
                    </div>
                </section>
            </div>

            <!-- Right Side: Summary -->
            <div class="lg:col-span-4">
                <div class="sticky top-32">
                    <div class="glass rounded-[2.5rem] p-8 shadow-2xl shadow-indigo-500/10 border border-white/60">
                        <h3 class="text-2xl font-black text-slate-900 mb-8 tracking-tight">Order Summary</h3>

                        <div class="space-y-4 mb-8">
                            <div class="flex justify-between items-center text-sm font-medium">
                                <span class="text-slate-400 uppercase tracking-widest text-[10px] font-black">Subtotal</span>
                                <span class="text-slate-900 font-bold">Rs. ${product.price * quantity}</span>
                            </div>
                            <div class="flex justify-between items-center text-sm font-medium">
                                <span class="text-slate-400 uppercase tracking-widest text-[10px] font-black">Shipping</span>
                                <span class="text-emerald-500 font-black">FREE</span>
                            </div>
                            <div class="flex justify-between items-center text-sm font-medium">
                                <span class="text-slate-400 uppercase tracking-widest text-[10px] font-black">Estimated Tax</span>
                                <span class="text-slate-900 font-bold">$0.00</span>
                            </div>
                            <div class="pt-6 mt-6 border-t border-slate-100">
                                <div class="flex justify-between items-end">
                                    <span class="text-slate-900 font-black text-lg tracking-tight">Total</span>
                                    <div class="text-right">
                                        <p class="text-4xl font-black text-indigo-600 leading-none">Rs. ${product.price * quantity}</p>
                                        <p class="text-[9px] font-black text-slate-400 uppercase tracking-tighter mt-2">USD inclusive of taxes</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <form action="${pageContext.request.contextPath}/user/order" method="POST" id="checkoutForm">
                            <input type="hidden" name="action" value="confirm">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <input type="hidden" name="quantity" value="${quantity}">

                            <button type="submit" class="neo-button w-full py-5 text-white rounded-2xl font-black text-lg transition-all active:scale-95 group">
                                <span class="flex items-center justify-center">
                                    Complete Purchase
                                    <i class="fas fa-arrow-right ml-3 group-hover:translate-x-2 transition-transform"></i>
                                </span>
                            </button>
                        </form>

                        <div class="mt-8 p-4 bg-slate-50/50 rounded-2xl border border-slate-100">
                            <div class="flex items-center text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">
                                <i class="fas fa-shield-alt text-indigo-400 mr-2"></i> Buyer Protection
                            </div>
                            <p class="text-[10px] leading-relaxed text-slate-400 font-medium">
                                Your information is protected by 256-bit SSL encryption.
                                By clicking the button above, you agree to our terms of service.
                            </p>
                        </div>
                    </div>

                    <div class="mt-8 flex justify-center gap-6 opacity-30 grayscale hover:grayscale-0 hover:opacity-100 transition-all duration-700">
                        <i class="fas fa-lock text-3xl"></i>
                        <i class="fas fa-shield-alt text-3xl"></i>
                        <i class="fas fa-truck text-3xl"></i>
                        <i class="fas fa-undo text-3xl"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="../partials/UserFooter.jsp" %>

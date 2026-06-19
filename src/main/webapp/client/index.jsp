<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Object user = session.getAttribute("user");
    Object admin = session.getAttribute("admin");
    Object seller = session.getAttribute("seller");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyGalaxy | Premium Toys & Games</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/style/styles.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="logo">Toy<span>Galaxy</span></div>
        <nav class="nav-menu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/user/products">Explore Toys</a></li>
                <li><a href="#about">Our Story</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
			<% if (user != null) { %>
			    <button class="dashboard" onclick="window.location.href = '<%=request.getContextPath()%>/client/user/userDashboard.jsp';">
			        User Dashboard
			    </button>
			    <button class="logout" onclick="window.location.href = '<%=request.getContextPath()%>/user/logout';">
			        Logout
			    </button>
			<% } else if (seller != null) { %>
			    <button class="dashboard" onclick="window.location.href = '<%=request.getContextPath()%>/client/seller/sellerDashboard.jsp';">
			        Seller Dashboard
			    </button>
			    <button class="logout" onclick="window.location.href = '<%=request.getContextPath()%>/seller/logout';">
			        Logout
			    </button>
			<% } else if (admin != null) { %>
			    <button class="dashboard" onclick="window.location.href = '<%=request.getContextPath()%>/admin';">
			        Admin Dashboard
			    </button>
			    <button class="logout" onclick="window.location.href = '<%=request.getContextPath()%>/admin/logout';">
			        Logout
			    </button>
			<% } else { %>
			    <button class="sign-in" onclick="window.location.href = '<%=request.getContextPath()%>/seller/login';">
			        Seller Sign In
			    </button>
			    <button class="sign-up" onclick="window.location.href = '<%=request.getContextPath()%>/login';">
			        Shop Now
			    </button>
			<% } %>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero" id="home">
        <div class="hero-content">
            <h1>Where Imagination<span> Comes to Life</span></h1>
            <p>Discover a universe of high-quality toys, games, and educational kits designed to spark creativity and joy in every child.</p>
            <button class="shop-now" onclick="window.location.href='${pageContext.request.contextPath}/user/products'">Start Your Adventure</button>
        </div>
    </section>

    <!-- Home Categories -->
    <section class="home-products" id="products">
        <h2>Explore Our Collections</h2>
        <div class="category-grid">
            <div class="category-card">
                <img src="${pageContext.request.contextPath}/client/images/action_figures.png" alt="Action Figures">
                <div class="category-info">
                    <h3>Action Figures</h3>
                    <a href="${pageContext.request.contextPath}/user/products" class="category-link">&rarr;</a>
                </div>
            </div>
            <div class="category-card">
                <img src="${pageContext.request.contextPath}/client/images/plushies.png" alt="Plushies & Dolls">
                <div class="category-info">
                    <h3>Plushies & Dolls</h3>
                    <a href="${pageContext.request.contextPath}/user/products" class="category-link">Shop Soft Toys &rarr;</a>
                </div>
            </div>
            <div class="category-card">
                <img src="https://images.pexels.com/photos/2599244/pexels-photo-2599244.jpeg" alt="STEM & Educational">
                <div class="category-info">
                    <h3>STEM & Learning</h3>
                    <a href="${pageContext.request.contextPath}/user/products" class="category-link">Explore Science &rarr;</a>
                </div>
            </div>
            <div class="category-card">
                <img src="https://images.pexels.com/photos/1018481/pexels-photo-1018481.jpeg" alt="Board Games">
                <div class="category-info">
                    <h3>Games & Puzzles</h3>
                    <a href="${pageContext.request.contextPath}/user/products" class="category-link">Play Together &rarr;</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Products -->
    <section class="featured">
        <h2>Top Trending This Week</h2>
        <div class="product-grid">
            <div class="product-card">
                <img src="${pageContext.request.contextPath}/client/images/action_figures.png" alt="Action Figure">
                <h3>Super Guardian Elite</h3>
                <p class="price">Rs. 2029.99</p>

            </div>
            <div class="product-card">
                <img src="${pageContext.request.contextPath}/client/images/plushies.png" alt="Unicorn Plush">
                <h3>Rainbow Unicorn Plush</h3>
                <p class="price">Rs. 1900.90</p>

            </div>
            <div class="product-card">
                <img src="https://images.pexels.com/photos/2599244/pexels-photo-2599244.jpeg" alt="Robot Kit">
                <h3>Mars Rover STEM Kit</h3>
                <p class="price">Rs. 4500.00</p>

            </div>
        </div>
    </section>

    <!-- About Us -->
    <section class="about" id="about">
        <div class="about-content">
            <img src="${pageContext.request.contextPath}/client/images/hero.png" alt="ToyGalaxy Store">
            <div class="about-text">
                <h2>Our Mission</h2>
                <p>At ToyGalaxy, we believe that play is the most powerful way for children to learn and grow. Our curated collection focuses on quality, safety, and most importantly, the fun factor!</p>
                <p>From timeless classics to modern STEM innovations, we bring the best toys from around the galaxy right to your doorstep.</p>
                <button class="sign-in">Learn More About Us</button>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="contact" id="contact">
        <div class="contact-container">
            <div class="contact-info">
                <h2>Contact Us</h2>
                <p>Have questions regarding a product or your order? Our dedicated support team is here to assist you.</p>
                <p><strong>HQ:</strong> 42 Barnes Place, Colombo 07, Sri Lanka</p>
                <p><strong>Comm Link:</strong> (011) 298-7869</p>
                <p><strong>Frequency:</strong> enquiries@toygalaxy.com</p>
            </div>
            <form class="contact-form">
                <input type="text" placeholder="Your Explorer Name" required>
                <input type="email" placeholder="Your Star-Mail" required>
                <textarea placeholder="How can we help your journey?" required></textarea>
                <button type="submit" class="submit-btn">Send Message</button>
            </form>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <h3>ToyGalaxy</h3>
                <p>Sparking joy across the universe since 2026.</p>
            </div>
            <div class="footer-section">
                <h3>Explore</h3>
                <ul>
                    <li><a href="#">Best Sellers</a></li>
                    <li><a href="#">New Arrivals</a></li>
                    <li><a href="#">Gift Cards</a></li>
                    <li><a href="#">Educational Toys</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Support</h3>
                <ul>
                    <li><a href="#">Shipping Info</a></li>
                    <li><a href="#">Returns</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Play</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Stay Tuned</h3>
                <p>Join our newsletter for exclusive drops!</p>
                <div style="display: flex; gap: 0.5rem; margin-top: 1rem;">
                    <input type="email" placeholder="Enter email" style="padding: 0.5rem; border-radius: 0.5rem; border: none; flex: 1;">
                    <button style="padding: 0.5rem 1rem;">Join</button>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 ToyGalaxy. All rights reserved.</p>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/client/script/script.js"></script>
</body>
</html>
package service;

import model.Order;
import util.FileDatabase;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class OrderService {
    private static final String FILE_NAME = "order.txt";

    public boolean placeOrder(Order order) {
        order.setOrderId(FileDatabase.getNextId(FILE_NAME));
        String[] record = {
                String.valueOf(order.getOrderId()),
                String.valueOf(order.getUserId()),
                String.valueOf(order.getProductId()),
                String.valueOf(order.getQuantity()),
                String.valueOf(order.getTotalPrice()),
                order.getOrderDate(),
                order.getStatus()
        };
        return FileDatabase.addRecord(FILE_NAME, record);
    }

    public boolean updateOrderStatus(int orderId, String newStatus) {
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            if (record.length >= 7 && record[0].trim().equals(String.valueOf(orderId))) {
                String[] updated = {
                        record[0].trim(), record[1].trim(), record[2].trim(),
                        record[3].trim(), record[4].trim(), record[5].trim(),
                        newStatus
                };
                return FileDatabase.updateRecord(FILE_NAME, String.valueOf(orderId), updated);
            }
        }
        return false;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            if (record.length > 1 && FileDatabase.safeParseInt(record[1]) == userId) {
                Order o = mapToOrder(record);
                if (o != null) orders.add(o);
            }
        }
        return orders;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            Order o = mapToOrder(record);
            if (o != null) orders.add(o);
        }
        return orders;
    }

    /**
     * Returns all orders for a seller by matching productId -> sellerId.
     */
    public List<Order> getOrdersBySellerId(int sellerId, service.ProductService productService) {
        List<Order> result = new ArrayList<>();
        for (Order o : getAllOrders()) {
            model.Product p = productService.getProductById(o.getProductId());
            if (p != null && p.getSellerId() == sellerId) {
                result.add(o);
            }
        }
        return result;
    }

    /**
     * FIXED: Counts orders with status "Pending" (Cash on Delivery orders not yet fulfilled).
     * Previously counted "Cash on Delivery" which was the final status — now "Pending" is the
     * initial status set by OrderServlet, making this count meaningful.
     */
    public int getPendingOrderCountForSeller(int sellerId, service.ProductService productService) {
        int count = 0;
        for (Order o : getOrdersBySellerId(sellerId, productService)) {
            if ("Pending".equalsIgnoreCase(o.getStatus())) count++;
        }
        return count;
    }

    /**
     * FIXED: Now counts ALL orders for this seller (Pending + Paid + Cash on Delivery),
     * not just "Paid" ones — because Cash on Delivery orders are real sales too.
     */
    public double getTotalSalesForSeller(int sellerId, service.ProductService productService) {
        double total = 0;
        for (Order o : getOrdersBySellerId(sellerId, productService)) {
            // Count all non-cancelled orders as sales
            String status = o.getStatus();
            if (!"Cancelled".equalsIgnoreCase(status)) {
                total += o.getTotalPrice();
            }
        }
        return total;
    }

    /**
     * Total revenue across all sellers — only fully Paid orders.
     */
    public double getTotalRevenue() {
        double total = 0;
        for (Order o : getAllOrders()) {
            if ("Paid".equalsIgnoreCase(o.getStatus())) total += o.getTotalPrice();
        }
        return total;
    }

    public int getOrderCountByStatus(String status) {
        int count = 0;
        for (Order o : getAllOrders()) {
            if (status.equalsIgnoreCase(o.getStatus())) count++;
        }
        return count;
    }

    public List<Order> getUnreviewedOrdersByUserId(int userId, Set<Integer> reviewedOrderIds) {
        List<Order> unreviewed = new ArrayList<>();
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            if (record.length > 1 && FileDatabase.safeParseInt(record[1]) == userId) {
                Order o = mapToOrder(record);
                if (o != null
                        && ("Paid".equalsIgnoreCase(o.getStatus())
                        || "Pending".equalsIgnoreCase(o.getStatus())
                        || "Cash on Delivery".equalsIgnoreCase(o.getStatus()))
                        && !reviewedOrderIds.contains(o.getOrderId())) {
                    unreviewed.add(o);
                }
            }
        }
        return unreviewed;
    }

    private Order mapToOrder(String[] record) {
        if (record.length < 7) return null;
        try {
            Order order = new Order();
            order.setOrderId(FileDatabase.safeParseInt(record[0]));
            order.setUserId(FileDatabase.safeParseInt(record[1]));
            order.setProductId(FileDatabase.safeParseInt(record[2]));
            order.setQuantity(FileDatabase.safeParseInt(record[3]));
            order.setTotalPrice(FileDatabase.safeParseDouble(record[4]));
            order.setOrderDate(record[5].trim());
            order.setStatus(record[6].trim());
            if (order.getOrderId() <= 0) return null;
            return order;
        } catch (Exception e) {
            return null;
        }
    }
}
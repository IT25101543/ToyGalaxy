package service;

import model.Review;
import util.FileDatabase;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ReviewService {

    private static final String FILE_NAME = "review.txt";

    // Create Review — stores orderId as field 8
    public boolean createReview(Review review) {
        review.setReviewId(FileDatabase.getNextId(FILE_NAME));
        review.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        review.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        String safeComment = review.getComment()
                .replace("|", "&#124;")
                .replace("\r", " ")
                .replace("\n", " ");
        String[] record = {
                String.valueOf(review.getReviewId()),
                String.valueOf(review.getUserId()),
                String.valueOf(review.getProductId()),
                String.valueOf(review.getRating()),
                safeComment,
                String.valueOf(review.getCreatedAt().getTime()),
                String.valueOf(review.getUpdatedAt().getTime()),
                String.valueOf(review.getOrderId())
        };
        return FileDatabase.addRecord(FILE_NAME, record);
    }

    // Get Review by ID
    public Review getReviewById(int reviewId) {
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            if (safeParseInt(record[0]) == reviewId) {
                Review r = mapToReview(record);
                if (r != null) return r;
            }
        }
        return null;
    }

    // Get All Reviews by User
    public List<Review> getReviewsByUserId(int userId) {
        List<Review> reviews = new ArrayList<>();
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            if (record.length < 7) continue;
            if (safeParseInt(record[1]) == userId) {
                Review r = mapToReview(record);
                if (r != null) reviews.add(r);
            }
        }
        return reviews;
    }

    // Get ALL reviews across all users — used by admin reports
    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            Review r = mapToReview(record);
            if (r != null) reviews.add(r);
        }
        return reviews;
    }

    // Returns the set of orderIds already reviewed by this user
    public Set<Integer> getReviewedOrderIdsByUser(int userId) {
        Set<Integer> reviewedOrderIds = new HashSet<>();
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            if (record.length < 7) continue;
            if (safeParseInt(record[1]) == userId && record.length >= 8) {
                int oid = safeParseInt(record[7]);
                if (oid > 0) reviewedOrderIds.add(oid);
            }
        }
        return reviewedOrderIds;
    }

    // Update Review
    public boolean updateReview(Review review) {
        Review existing = getReviewById(review.getReviewId());
        if (existing == null) return false;

        existing.setRating(review.getRating());
        existing.setComment(review.getComment());
        existing.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        String safeComment = existing.getComment()
                .replace("|", "&#124;")
                .replace("\r", " ")
                .replace("\n", " ");
        String[] record = {
                String.valueOf(existing.getReviewId()),
                String.valueOf(existing.getUserId()),
                String.valueOf(existing.getProductId()),
                String.valueOf(existing.getRating()),
                safeComment,
                String.valueOf(existing.getCreatedAt().getTime()),
                String.valueOf(existing.getUpdatedAt().getTime()),
                String.valueOf(existing.getOrderId())
        };
        return FileDatabase.updateRecord(FILE_NAME, String.valueOf(existing.getReviewId()), record);
    }

    // Delete Review
    public boolean deleteReview(int reviewId) {
        return FileDatabase.deleteRecord(FILE_NAME, String.valueOf(reviewId));
    }

    // Count Reviews by User
    public int getReviewCountByUser(int userId) {
        int count = 0;
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            if (record.length > 1 && safeParseInt(record[1]) == userId) count++;
        }
        return count;
    }

    // Get Reviews by Product ID
    public List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            if (record.length > 2 && safeParseInt(record[2]) == productId) {
                Review r = mapToReview(record);
                if (r != null) reviews.add(r);
            }
        }
        return reviews;
    }

    // Map record to Review — backward compatible: field 8 (orderId) optional
    private Review mapToReview(String[] record) {
        if (record.length < 7) return null;
        try {
            int reviewId  = safeParseInt(record[0]);
            int userId    = safeParseInt(record[1]);
            int productId = safeParseInt(record[2]);
            int rating    = safeParseInt(record[3]);
            if (reviewId <= 0 || rating < 1 || rating > 5) return null;
            String comment = record[4].replace("&#124;", "|");
            long createdMs = safeParseLong(record[5]);
            long updatedMs = safeParseLong(record[6]);
            if (createdMs <= 0 || updatedMs <= 0) return null;

            Review review = new Review();
            review.setReviewId(reviewId);
            review.setUserId(userId);
            review.setProductId(productId);
            review.setRating(rating);
            review.setComment(comment);
            review.setCreatedAt(new Timestamp(createdMs));
            review.setUpdatedAt(new Timestamp(updatedMs));
            if (record.length >= 8 && !record[7].trim().isEmpty()) {
                review.setOrderId(safeParseInt(record[7]));
            }
            return review;
        } catch (Exception e) {
            return null;
        }
    }

    private static int safeParseInt(String s) {
        if (s == null) return 0;
        try { return Integer.parseInt(s.trim()); }
        catch (NumberFormatException e) { return 0; }
    }

    private static long safeParseLong(String s) {
        if (s == null) return 0L;
        try { return Long.parseLong(s.trim()); }
        catch (NumberFormatException e) { return 0L; }
    }
}

package service;

import model.Review;
import util.FileDatabase;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ReviewService {

    private static final String FILE_NAME = "review.txt";

    // Create Review
    public boolean createReview(Review review) {
        review.setReviewId(FileDatabase.getNextId(FILE_NAME));
        review.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        review.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        String[] record = {
                String.valueOf(review.getReviewId()),
                String.valueOf(review.getUserId()),
                String.valueOf(review.getProductId()),
                String.valueOf(review.getRating()),
                review.getComment().replace("|", "&#124;"),
                String.valueOf(review.getCreatedAt().getTime()),
                String.valueOf(review.getUpdatedAt().getTime())
        };
        return FileDatabase.addRecord(FILE_NAME, record);
    }

    // Get Review by ID
    public Review getReviewById(int reviewId) {
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            if (record.length > 0 && Integer.parseInt(record[0].trim()) == reviewId) {
                return mapToReview(record);
            }
        }
        return null;
    }

    // Get All Reviews by User
    public List<Review> getReviewsByUserId(int userId) {
        List<Review> reviews = new ArrayList<>();
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            if (record.length > 1 && Integer.parseInt(record[1].trim()) == userId) {
                Review r = mapToReview(record);
                if (r != null) {
                    reviews.add(r);
                }
            }
        }
        return reviews;
    }

    // Update Review
    public boolean updateReview(Review review) {
        Review existing = getReviewById(review.getReviewId());
        if (existing == null) return false;

        // Update only the fields that are allowed to change
        existing.setRating(review.getRating());
        existing.setComment(review.getComment());
        existing.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        String[] record = {
                String.valueOf(existing.getReviewId()),
                String.valueOf(existing.getUserId()),
                String.valueOf(existing.getProductId()),
                String.valueOf(existing.getRating()),
                existing.getComment().replace("|", "&#124;"),
                String.valueOf(existing.getCreatedAt().getTime()),
                String.valueOf(existing.getUpdatedAt().getTime())
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
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            if (record.length > 1 && Integer.parseInt(record[1]) == userId) {
                count++;
            }
        }
        return count;
    }

    // Get Reviews by Product ID
    public List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            if (record.length > 2 && Integer.parseInt(record[2]) == productId) {
                Review r = mapToReview(record);
                if (r != null) {
                    reviews.add(r);
                }
            }
        }
        return reviews;
    }

    // Map record to Review object
    private Review mapToReview(String[] record) {
        if (record.length < 7) return null;
        try {
            Review review = new Review();
            review.setReviewId(Integer.parseInt(record[0].trim()));
            review.setUserId(Integer.parseInt(record[1].trim()));
            review.setProductId(Integer.parseInt(record[2].trim()));
            review.setRating(Integer.parseInt(record[3].trim()));
            review.setComment(record[4].replace("&#124;", "|"));
            review.setCreatedAt(new Timestamp(Long.parseLong(record[5].trim())));
            review.setUpdatedAt(new Timestamp(Long.parseLong(record[6].trim())));
            return review;
        } catch (Exception e) {
            return null;
        }
    }
}

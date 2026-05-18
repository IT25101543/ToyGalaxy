package service;

import model.Seller;
import util.FileDatabase;

import java.util.ArrayList;
import java.util.List;

public class SellerService {

    private static final String FILE_NAME = "seller.txt";

    public boolean createSeller(Seller seller) {
        seller.setId(FileDatabase.getNextId(FILE_NAME));
        String[] record = {
                String.valueOf(seller.getId()),
                seller.getName(),
                seller.getEmail(),
                seller.getPassword(),
                seller.getStoreName(),
                String.valueOf(seller.isApproved())
        };
        return FileDatabase.addRecord(FILE_NAME, record);
    }

    public Seller login(String email, String password) {
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            if (record.length > 3 && record[2].equals(email) && record[3].equals(password)) {
                return mapToSeller(record);
            }
        }
        return null;
    }

    public Seller getSellerById(int id) {
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            if (record.length > 0 && FileDatabase.safeParseInt(record[0]) == id) {
                return mapToSeller(record);
            }
        }
        return null;
    }

    public Seller getSellerByEmail(String email) {
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            if (record.length > 2 && record[2].equals(email)) {
                return mapToSeller(record);
            }
        }
        return null;
    }

    public List<Seller> getAllSellers() {
        List<Seller> sellers = new ArrayList<>();
        for (String[] record : FileDatabase.readAll(FILE_NAME)) {
            Seller s = mapToSeller(record);
            if (s != null) sellers.add(s);
        }
        return sellers;
    }

    public boolean updateSeller(Seller seller) {
        String[] record = {
                String.valueOf(seller.getId()),
                seller.getName(),
                seller.getEmail(),
                seller.getPassword(),
                seller.getStoreName(),
                String.valueOf(seller.isApproved())
        };
        return FileDatabase.updateRecord(FILE_NAME, String.valueOf(seller.getId()), record);
    }

    public boolean approveSeller(int sellerId) {
        Seller seller = getSellerById(sellerId);
        if (seller != null) {
            seller.setApproved(true);
            return updateSeller(seller);
        }
        return false;
    }

    public boolean deleteSeller(int sellerId) {
        return FileDatabase.deleteRecord(FILE_NAME, String.valueOf(sellerId));
    }

    private Seller mapToSeller(String[] record) {
        if (record.length < 6) return null;
        try {
            int id = FileDatabase.safeParseInt(record[0]);
            if (id <= 0) return null;
            Seller seller = new Seller();
            seller.setId(id);
            seller.setName(record[1]);
            seller.setEmail(record[2]);
            seller.setPassword(record[3]);
            seller.setStoreName(record[4]);
            seller.setApproved(Boolean.parseBoolean(record[5].trim()));
            return seller;
        } catch (Exception e) {
            return null;
        }
    }
}

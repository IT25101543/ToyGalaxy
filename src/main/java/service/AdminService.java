package service;

import model.Admin;
import util.FileDatabase;

import java.util.ArrayList;
import java.util.List;

public class AdminService {

    private static final String FILE_NAME = "admin.txt";

    // Create Admin
    public boolean createAdmin(Admin admin) {
        admin.setId(FileDatabase.getNextId(FILE_NAME));
        String[] record = {
                String.valueOf(admin.getId()),
                admin.getName(),
                admin.getEmail(),
                admin.getPassword()
        };
        return FileDatabase.addRecord(FILE_NAME, record);
    }

    // Get Admin by ID
    public Admin getAdmin(int id) {
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            if (FileDatabase.safeParseInt(record[0]) == id) {
                return mapToAdmin(record);
            }
        }
        return null;
    }

    // Get Admin by Email
    public Admin getAdminByEmail(String email) {
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            if (record[2].equals(email)) {
                return mapToAdmin(record);
            }
        }
        return null;
    }

    // Get All Admins
    public List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            admins.add(mapToAdmin(record));
        }
        return admins;
    }

    // Update Admin
    public boolean updateAdmin(Admin admin) {
        String[] record = {
                String.valueOf(admin.getId()),
                admin.getName(),
                admin.getEmail(),
                admin.getPassword()
        };
        return FileDatabase.updateRecord(FILE_NAME, String.valueOf(admin.getId()), record);
    }

    // Delete Admin
    public boolean deleteAdmin(int id) {
        return FileDatabase.deleteRecord(FILE_NAME, String.valueOf(id));
    }

    // Helper: Map record to Admin object
    private Admin mapToAdmin(String[] record) {
        Admin admin = new Admin();
        admin.setId(FileDatabase.safeParseInt(record[0]));
        admin.setName(record[1]);
        admin.setEmail(record[2]);
        admin.setPassword(record[3]);
        return admin;
    }
}


package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Application;
import util.DBConnection;

public class ApplicationDAO {
    
    public boolean createApplication(Application application) {
        String query = "INSERT INTO applications (internship_id, student_id, status, apply_date) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, application.getInternshipId());
            stmt.setInt(2, application.getStudentId());
            stmt.setString(3, application.getStatus());
            stmt.setDate(4, new java.sql.Date(application.getApplyDate().getTime()));
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Application> getApplicationsByStudent(int studentId) {
        List<Application> applications = new ArrayList<>();
        String query = "SELECT a.*, i.title as internship_title, c.name as company_name " +
                       "FROM applications a " +
                       "JOIN internships i ON a.internship_id = i.id " +
                       "JOIN users c ON i.company_id = c.user_id " +
                       "WHERE a.student_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Application application = new Application();
                application.setId(rs.getInt("id"));
                application.setInternshipId(rs.getInt("internship_id"));
                application.setStudentId(rs.getInt("student_id"));
                application.setStatus(rs.getString("status"));
                application.setApplyDate(rs.getDate("apply_date"));
                application.setInternshipTitle(rs.getString("internship_title"));
                application.setCompanyName(rs.getString("company_name"));
                applications.add(application);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return applications;
    }
    
    public List<Application> getApplicationsByCompany(int companyId) {
        List<Application> applications = new ArrayList<>();
        String query = "SELECT a.*, i.title as internship_title, s.name as student_name " +
                       "FROM applications a " +
                       "JOIN internships i ON a.internship_id = i.id " +
                       "JOIN users s ON a.student_id = s.user_id " +
                       "WHERE i.company_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, companyId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Application application = new Application();
                application.setId(rs.getInt("id"));
                application.setInternshipId(rs.getInt("internship_id"));
                application.setStudentId(rs.getInt("student_id"));
                application.setStatus(rs.getString("status"));
                application.setApplyDate(rs.getDate("apply_date"));
                application.setInternshipTitle(rs.getString("internship_title"));
                application.setStudentName(rs.getString("student_name"));
                applications.add(application);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return applications;
    }
    
    public List<Application> getAllApplications() {
        List<Application> applications = new ArrayList<>();
        String query = "SELECT a.*, i.title as internship_title, s.name as student_name, c.name as company_name " +
                       "FROM applications a " +
                       "JOIN internships i ON a.internship_id = i.id " +
                       "JOIN users s ON a.student_id = s.user_id " +
                       "JOIN users c ON i.company_id = c.user_id";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Application application = new Application();
                application.setId(rs.getInt("id"));
                application.setInternshipId(rs.getInt("internship_id"));
                application.setStudentId(rs.getInt("student_id"));
                application.setStatus(rs.getString("status"));
                application.setApplyDate(rs.getDate("apply_date"));
                application.setInternshipTitle(rs.getString("internship_title"));
                application.setStudentName(rs.getString("student_name"));
                application.setCompanyName(rs.getString("company_name"));
                applications.add(application);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return applications;
    }
    
    public boolean updateApplicationStatus(int id, String status) {
        String query = "UPDATE applications SET status = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, id);
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean hasApplied(int studentId, int internshipId) {
        String query = "SELECT COUNT(*) FROM applications WHERE student_id = ? AND internship_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, internshipId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return false;
    }
}
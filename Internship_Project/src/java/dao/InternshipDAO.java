package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Internship;
import util.DBConnection;

public class InternshipDAO {
    
    public boolean createInternship(Internship internship) {
        String query = "INSERT INTO internships (title, description, company_id, deadline) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, internship.getTitle());
            stmt.setString(2, internship.getDescription());
            stmt.setInt(3, internship.getCompanyId());
            stmt.setDate(4, new java.sql.Date(internship.getDeadline().getTime()));
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Internship> getAllInternships() {
        List<Internship> internships = new ArrayList<>();
        String query = "SELECT i.*, u.name as company_name FROM internships i " +
                       "JOIN users u ON i.company_id = u.user_id";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Internship internship = new Internship();
                internship.setId(rs.getInt("id"));
                internship.setTitle(rs.getString("title"));
                internship.setDescription(rs.getString("description"));
                internship.setCompanyId(rs.getInt("company_id"));
                internship.setDeadline(rs.getDate("deadline"));
                internship.setCompanyName(rs.getString("company_name"));
                internships.add(internship);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return internships;
    }
    
    public List<Internship> getInternshipsByCompany(int companyId) {
        List<Internship> internships = new ArrayList<>();
        String query = "SELECT i.*, u.name as company_name FROM internships i " +
                       "JOIN users u ON i.company_id = u.user_id " +
                       "WHERE i.company_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, companyId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Internship internship = new Internship();
                internship.setId(rs.getInt("id"));
                internship.setTitle(rs.getString("title"));
                internship.setDescription(rs.getString("description"));
                internship.setCompanyId(rs.getInt("company_id"));
                internship.setDeadline(rs.getDate("deadline"));
                internship.setCompanyName(rs.getString("company_name"));
                internships.add(internship);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return internships;
    }
    
    public Internship getInternshipById(int id) {
        String query = "SELECT i.*, u.name as company_name FROM internships i " +
                       "JOIN users u ON i.company_id = u.user_id " +
                       "WHERE i.id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Internship internship = new Internship();
                internship.setId(rs.getInt("id"));
                internship.setTitle(rs.getString("title"));
                internship.setDescription(rs.getString("description"));
                internship.setCompanyId(rs.getInt("company_id"));
                internship.setDeadline(rs.getDate("deadline"));
                internship.setCompanyName(rs.getString("company_name"));
                return internship;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean updateInternship(Internship internship) {
        String query = "UPDATE internships SET title = ?, description = ?, deadline = ? WHERE id = ? AND company_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, internship.getTitle());
            stmt.setString(2, internship.getDescription());
            stmt.setDate(3, new java.sql.Date(internship.getDeadline().getTime()));
            stmt.setInt(4, internship.getId());
            stmt.setInt(5, internship.getCompanyId());
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteInternship(int id, int companyId) {
        String query = "DELETE FROM internships WHERE id = ? AND company_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            stmt.setInt(2, companyId);
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
}
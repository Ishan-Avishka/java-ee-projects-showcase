/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Reservation;
import dao.BookDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {
    
    public boolean reserveBook(Reservation reservation) {
        String query = "INSERT INTO reservations (student_name, student_id, book_id) VALUES (?, ?, ?)";
        
        try (Connection conn = BookDAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, reservation.getStudentName());
            stmt.setString(2, reservation.getStudentId());
            stmt.setInt(3, reservation.getBookId());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    reservation.setId(generatedKeys.getInt(1));
                }
                return true;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public List<Reservation> getReservationsByStudentId(String studentId) {
        List<Reservation> reservations = new ArrayList<>();
        String query = "SELECT * FROM reservations WHERE student_id = ?";
        
        try (Connection conn = BookDAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setId(rs.getInt("id"));
                reservation.setStudentName(rs.getString("student_name"));
                reservation.setStudentId(rs.getString("student_id"));
                reservation.setBookId(rs.getInt("book_id"));
                reservation.setReservationDate(rs.getTimestamp("reservation_date"));
                reservations.add(reservation);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return reservations;
    }
    
    public boolean isBookReserved(int bookId) {
        String query = "SELECT COUNT(*) FROM reservations WHERE book_id = ?";
        
        try (Connection conn = BookDAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
}
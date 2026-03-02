/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

public class Reservation {
    private int id;
    private String studentName;
    private String studentId;
    private int bookId;
    private Timestamp reservationDate;
    
    public Reservation() {
        this.reservationDate = new Timestamp(System.currentTimeMillis());
    }
    
    public Reservation(int id, String studentName, String studentId, int bookId, Timestamp reservationDate) {
        this.id = id;
        this.studentName = studentName;
        this.studentId = studentId;
        this.bookId = bookId;
        this.reservationDate = reservationDate;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getStudentId() {
        return studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public Timestamp getReservationDate() {
        return reservationDate;
    }
    
    public void setReservationDate(Timestamp reservationDate) {
        this.reservationDate = reservationDate;
    }
    
    @Override
    public String toString() {
        return "Reservation [id=" + id + ", studentName=" + studentName + ", studentId=" + studentId + 
               ", bookId=" + bookId + ", reservationDate=" + reservationDate + "]";
    }
}
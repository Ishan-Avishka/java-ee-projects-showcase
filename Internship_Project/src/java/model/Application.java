package model;

import java.util.Date;

public class Application {
    private int id;
    private int internshipId;
    private int studentId;
    private String status;
    private Date applyDate;
    
    private String internshipTitle;
    private String studentName;
    private String companyName;
    
    public Application() {}
    
    public Application(int id, int internshipId, int studentId, String status, Date applyDate) {
        this.id = id;
        this.internshipId = internshipId;
        this.studentId = studentId;
        this.status = status;
        this.applyDate = applyDate;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getInternshipId() {
        return internshipId;
    }
    
    public void setInternshipId(int internshipId) {
        this.internshipId = internshipId;
    }
    
    public int getStudentId() {
        return studentId;
    }
    
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Date getApplyDate() {
        return applyDate;
    }
    
    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }
    
    public String getInternshipTitle() {
        return internshipTitle;
    }
    
    public void setInternshipTitle(String internshipTitle) {
        this.internshipTitle = internshipTitle;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getCompanyName() {
        return companyName;
    }
    
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
}
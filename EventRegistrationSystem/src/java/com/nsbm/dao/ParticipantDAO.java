/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.nsbm.dao;

/**
 *
 * @author ishanavishka
 */


import com.nsbm.model.Participant;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ParticipantDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/eventdb";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Ishan2003$$";
    
    private static final String INSERT_PARTICIPANT_SQL = "INSERT INTO participants (name, email, event) VALUES (?, ?, ?)";
    private static final String SELECT_ALL_PARTICIPANTS = "SELECT * FROM participants";
    
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }
    
    public void insertParticipant(Participant participant) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PARTICIPANT_SQL)) {
            preparedStatement.setString(1, participant.getName());
            preparedStatement.setString(2, participant.getEmail());
            preparedStatement.setString(3, participant.getEvent());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Participant> listParticipants() {
        List<Participant> participants = new ArrayList<>();
        
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PARTICIPANTS);
             ResultSet rs = preparedStatement.executeQuery()) {
            
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String event = rs.getString("event");
                participants.add(new Participant(id, name, email, event));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return participants;
    }
}
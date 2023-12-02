package com.libraryproject.controllers;

import com.libraryproject.models.User;
import com.libraryproject.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/user")
    public String showUserList(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "user";
    }

    @GetMapping("/add-user")
    public String showAddUserForm(Model model) {
        model.addAttribute("user", new User());
        return "add-user";
    }

    @PostMapping("/user")
    public String createUser(@ModelAttribute User user, Model model) {
        userService.create(user);
        model.addAttribute("message", "User added successfully");
        return "redirect:/user";
    }

    @PutMapping("/user/{id}")
    public ResponseEntity<User> editUser(@PathVariable Long id, @RequestBody User updatedUser) {
        try {
            User existingUser = userService.get(id);

            existingUser.setFirstName(updatedUser.getFirstName());
            existingUser.setSecondName(updatedUser.getSecondName());
            existingUser.setThirdName(updatedUser.getThirdName());
            existingUser.setPhoneNumber(updatedUser.getPhoneNumber());
            existingUser.setExpired(updatedUser.getExpired());

            User savedUser = userService.update(id, existingUser);

            return new ResponseEntity<>(savedUser, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/user/{id}")
    public ResponseEntity<String> deleteUser(@PathVariable Long id) {
        try {
            userService.delete(id);
            return ResponseEntity.ok("User deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to delete user");
        }
    }
}

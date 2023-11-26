package com.libraryproject.controllers;

import com.libraryproject.models.User;
import com.libraryproject.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
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

    @GetMapping("/user/{id}")
    public User getUserById(@PathVariable Long id){
        return userService.get(id);
    }

    @PostMapping("/user")
    public User addUser(@RequestBody User user){
        return userService.create(user);
    }

    @PostMapping("/user/{id}")
    public User editUser(@PathVariable Long id, @RequestBody User user){
        return userService.update(id, user);
    }

    @DeleteMapping("/user/{id}")
    public void deleteUser(@PathVariable Long id){
        userService.delete(id);
    }
}

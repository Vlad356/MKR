package com.libraryproject;

import com.libraryproject.controllers.UserController;
import com.libraryproject.models.User;
import com.libraryproject.services.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@SpringBootTest
class UserControllerTest {

    @Mock
    private UserService userService;

    @Mock
    private Model model;

    @InjectMocks
    private UserController userController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testShowUserList() {
        List<User> users = new ArrayList<>();
        when(userService.getAllUsers()).thenReturn(users);

        String viewName = userController.showUserList(model);

        assertEquals("user", viewName);
        verify(model).addAttribute("users", users);
    }

    @Test
    void testShowAddUserForm() {
        String viewName = userController.showAddUserForm(model);

        assertEquals("add-user", viewName);
        verify(model).addAttribute(eq("user"), any(User.class));
    }

    @Test
    void testCreateUser() {
        User user = new User();

        String viewName = userController.createUser(user, model);

        assertEquals("redirect:/user", viewName);
        verify(userService).create(user);
        verify(model).addAttribute(eq("message"), eq("User added successfully"));
    }

    @Test
    void testEditUser() {
        Long userId = 1L;
        User existingUser = new User();
        User updatedUser = new User();

        when(userService.get(userId)).thenReturn(existingUser);
        when(userService.update(userId, existingUser)).thenReturn(existingUser);

        ResponseEntity<User> responseEntity = userController.editUser(userId, updatedUser);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertNotNull(responseEntity.getBody());

        verify(userService).get(userId);
        verify(userService).update(userId, existingUser);
    }

    @Test
    void testEditUserNotFound() {
        Long userId = 1L;
        User updatedUser = new User();

        when(userService.get(userId)).thenThrow(new RuntimeException("User not found"));

        ResponseEntity<User> responseEntity = userController.editUser(userId, updatedUser);

        assertEquals(HttpStatus.NOT_FOUND, responseEntity.getStatusCode());
        assertEquals(null, responseEntity.getBody());

        verify(userService).get(userId);
        verifyNoMoreInteractions(userService);
    }

    @Test
    void testDeleteUser() {
        Long userId = 1L;

        ResponseEntity<String> responseEntity = userController.deleteUser(userId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals("User deleted successfully", responseEntity.getBody());

        verify(userService).delete(userId);
    }

    @Test
    void testDeleteUserException() {
        Long userId = 1L;

        doThrow(new RuntimeException("Failed to delete user")).when(userService).delete(userId);

        ResponseEntity<String> responseEntity = userController.deleteUser(userId);

        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, responseEntity.getStatusCode());
        assertEquals("Failed to delete user", responseEntity.getBody());

        verify(userService).delete(userId);
    }
}
package com.libraryproject;

import com.libraryproject.controllers.BookIssueController;
import com.libraryproject.models.Book;
import com.libraryproject.models.BookIssue;
import com.libraryproject.models.User;
import com.libraryproject.services.BookIssueService;
import com.libraryproject.services.BookService;
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
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@SpringBootTest
class BookIssueControllerTest {

    @Mock
    private BookIssueService bookIssueService;

    @Mock
    private UserService userService;

    @Mock
    private BookService bookService;

    @Mock
    private Model model;

    @InjectMocks
    private BookIssueController bookIssueController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testShowBookIssueList() {
        List<BookIssue> issues = new ArrayList<>();
        when(bookIssueService.getAllIssuesWithDetails()).thenReturn(issues);

        String viewName = bookIssueController.showBookIssueList(model);

        assertEquals("issue", viewName);
        verify(model).addAttribute("issuedBooks", issues);
    }




    @Test
    void testCreateIssueFailure() {
        when(userService.get(anyLong())).thenThrow(new RuntimeException("User not found"));

        String viewName = bookIssueController.createIssue(new BookIssue(), model);

        assertEquals("add-issue", viewName);
        verify(model).addAttribute("error", "Failed to add book issue");
    }

    @Test
    void testEditIssue() {
        Long issueId = 1L;
        BookIssue existingIssue = new BookIssue();
        BookIssue updatedIssue = new BookIssue();

        when(bookIssueService.get(issueId)).thenReturn(existingIssue);
        when(bookIssueService.update(issueId, existingIssue)).thenReturn(existingIssue);

        ResponseEntity<BookIssue> responseEntity = bookIssueController.editIssue(issueId, updatedIssue);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertNotNull(responseEntity.getBody());

        verify(bookIssueService).get(issueId);
        verify(bookIssueService).update(issueId, existingIssue);
    }

    @Test
    void testEditIssueNotFound() {
        Long issueId = 1L;
        BookIssue updatedIssue = new BookIssue();

        when(bookIssueService.get(issueId)).thenThrow(new RuntimeException("Issue not found"));

        ResponseEntity<BookIssue> responseEntity = bookIssueController.editIssue(issueId, updatedIssue);

        assertEquals(HttpStatus.NOT_FOUND, responseEntity.getStatusCode());
        assertEquals(null, responseEntity.getBody());

        verify(bookIssueService).get(issueId);
        verifyNoMoreInteractions(bookIssueService);
    }

    @Test
    void testDeleteIssue() {
        Long issueId = 1L;

        ResponseEntity<String> responseEntity = bookIssueController.deleteIssue(issueId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals("Book issue deleted successfully", responseEntity.getBody());

        verify(bookIssueService).delete(issueId);
    }

    @Test
    void testDeleteIssueException() {
        Long issueId = 1L;

        doThrow(new RuntimeException("Failed to delete book issue")).when(bookIssueService).delete(issueId);

        ResponseEntity<String> responseEntity = bookIssueController.deleteIssue(issueId);

        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, responseEntity.getStatusCode());
        assertEquals("Failed to delete book issue", responseEntity.getBody());

        verify(bookIssueService).delete(issueId);
    }
}

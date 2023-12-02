package com.libraryproject.controllers;

import com.libraryproject.models.Book;
import com.libraryproject.models.BookIssue;
import com.libraryproject.models.User;
import com.libraryproject.services.BookIssueService;
import com.libraryproject.services.BookService;
import com.libraryproject.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
public class BookIssueController {
    @Autowired
    private BookIssueService bookIssueService;
    @Autowired
    private UserService userService;
    @Autowired
    private BookService bookService;

    @GetMapping("/issue")
    public String showBookIssueList(Model model) {
        List<BookIssue> issues = bookIssueService.getAllIssuesWithDetails();
        model.addAttribute("issuedBooks", issues);
        return "issue";
    }

    @GetMapping("/add-issue")
    public String showAddIssueForm(Model model) {
        List<User> users = userService.getAllUsers();
        List<Book> books = bookService.getAll();

        model.addAttribute("users", users);
        model.addAttribute("books", books);
        model.addAttribute("issue", new BookIssue());

        return "add-issue";
    }

    @PostMapping("/issue")
    public String createIssue(@ModelAttribute BookIssue bookIssue, Model model) {
        try {
            User user = userService.get(bookIssue.getUser().getId());
            Book book = bookService.get(bookIssue.getBook().getId());

            bookIssue.setUser(user);
            bookIssue.setBook(book);

            bookIssue.setIssueDate(new Date());

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(bookIssue.getIssueDate());
            calendar.add(Calendar.DAY_OF_MONTH, 14);
            bookIssue.setReturnDate(calendar.getTime());

            bookIssueService.create(bookIssue);

            model.addAttribute("message", "Book issue added successfully");
            return "redirect:/issue";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to add book issue");
            return "add-issue";
        }
    }

    @PutMapping("/issue/{id}")
    public ResponseEntity<BookIssue> editIssue(@PathVariable Long id, @RequestBody BookIssue updatedIssue) {
        try {
            BookIssue existingIssue = bookIssueService.get(id);

            existingIssue.setUser(updatedIssue.getUser());
            existingIssue.setBook(updatedIssue.getBook());
            existingIssue.setIssueDate(updatedIssue.getIssueDate());
            existingIssue.setReturnDate(updatedIssue.getReturnDate());

            BookIssue savedIssue = bookIssueService.update(id, existingIssue);

            return new ResponseEntity<>(savedIssue, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/issue/{id}")
    public ResponseEntity<String> deleteIssue(@PathVariable Long id) {
        try {
            bookIssueService.delete(id);
            return ResponseEntity.ok("Book issue deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to delete book issue");
        }
    }
}

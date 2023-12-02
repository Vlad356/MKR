package com.libraryproject.services;

import com.libraryproject.models.Book;
import com.libraryproject.models.BookIssue;
import com.libraryproject.models.BookIssueRepository;
import com.libraryproject.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookIssueService {
    @Autowired
    private BookIssueRepository bookIssueRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private BookService bookService;

    public BookIssue get(Long id) {
        Optional<BookIssue> byId = bookIssueRepository.findById(id);

        if (byId.isPresent()) {
            return byId.get();
        }
        throw new RuntimeException("Book issue not found");
    }

    public List<BookIssue> getAllIssuesWithDetails() {
        List<BookIssue> issues = (List<BookIssue>) bookIssueRepository.findAll();

        for (BookIssue issue : issues) {
            // Fetch detailed user information
            User user = userService.get(issue.getUser().getId());
            issue.setUser(user);

            // Fetch detailed book information
            Book book = bookService.get(issue.getBook().getId());
            issue.setBook(book);
        }

        return issues;
    }

    public BookIssue create(BookIssue bookIssue) {
        User user = userService.get(bookIssue.getUser().getId());
        Book book = bookService.get(bookIssue.getBook().getId());

        bookIssue.setUser(user);
        bookIssue.setBook(book);

        BookIssue savedIssue = bookIssueRepository.save(bookIssue);
        return savedIssue;
    }

    public BookIssue update(Long id, BookIssue bookIssue) {
        BookIssue original = get(id);

        original.setUser(bookIssue.getUser());
        original.setBook(bookIssue.getBook());
        original.setIssueDate(bookIssue.getIssueDate());
        original.setReturnDate(bookIssue.getReturnDate());

        BookIssue updatedIssue = bookIssueRepository.save(original);
        return updatedIssue;
    }

    public void delete(Long id) {
        BookIssue issue = get(id);
        bookIssueRepository.delete(issue);
    }
}

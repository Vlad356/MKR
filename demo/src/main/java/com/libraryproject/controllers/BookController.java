package com.libraryproject.controllers;

import com.libraryproject.models.Book;
import com.libraryproject.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class BookController{

    @Autowired
    private BookService bookService;

    @GetMapping("/book")
    public String showBookList(Model model) {
        List<Book> books = bookService.getAll();
        model.addAttribute("books", books);
        return "book";
    }

    @GetMapping("/add-book")
    public String showAddBookForm(Model model) {
        model.addAttribute("book", new Book()); // Додаємо пустий об'єкт Book для форми
        return "add-book";
    }

    @PostMapping("/book")
    public String createBook(@ModelAttribute Book book, Model model) {
        bookService.create(book);
        model.addAttribute("message", "Book added successfully");
        return "redirect:/book"; // Перенаправлення на сторінку зі списком книг
    }

    @PutMapping("/book/{id}")
    public ResponseEntity<Book> editBook(@PathVariable Long id, @RequestBody Book updatedBook) {
        try {
            // Перевірка, чи існує книга за вказаним id
            Book existingBook = bookService.get(id);

            // Оновлення інформації з updatedBook у існуючій книзі
            existingBook.setTitle(updatedBook.getTitle());
            existingBook.setAuthor(updatedBook.getAuthor());
            existingBook.setDescription(updatedBook.getDescription());
            existingBook.setPublisher(updatedBook.getPublisher());
            existingBook.setIsbn(updatedBook.getIsbn());
            existingBook.setYear(updatedBook.getYear());

            // Збереження оновленої книги
            Book savedBook = bookService.update(id, existingBook);

            return new ResponseEntity<>(savedBook, HttpStatus.OK);
        } catch (RuntimeException e) {
            // Обробка винятку
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/book/{id}")
    public ResponseEntity<String> deleteBook(@PathVariable Long id) {
        try {
            bookService.delete(id);
            return ResponseEntity.ok("Book deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to delete book");
        }
    }


}

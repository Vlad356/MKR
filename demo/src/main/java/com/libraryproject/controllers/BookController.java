package com.libraryproject.controllers;

import com.libraryproject.models.Book;
import com.libraryproject.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
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
    @GetMapping("/book/{id}")
    public Book getBookById(@PathVariable Long id) {
        return bookService.get(id);
    }
    @PostMapping("/book")
    public Book createBook(@RequestBody Book book) {
        return bookService.create(book);
    }
    @PutMapping("/book/{id}")
    public Book editBook(@PathVariable Long id, @RequestBody Book book) {
        return bookService.update(id, book);
    }
    @DeleteMapping("/book/{id}")
    public void deleteBook(@PathVariable Long id) {
        bookService.delete(id);
    }


}

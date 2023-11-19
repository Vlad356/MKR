package com.libraryproject.services;

import com.libraryproject.models.Book;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class BookService {
    public Book get(Long id){
        // Return book from database
        return new Book();
    }

    public List<Book> getAll(){
        // get all the books from database
        return Collections.emptyList();
    }

    public Book create(Book book){
        // Save book to the database
        return book;
    }

    public Book update (Long id, Book book){
        // get book by id and update it
        return book;
    }
    public void delete(Long id){
        // delete book from database
    }
}

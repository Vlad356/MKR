package com.libraryproject;

import com.libraryproject.controllers.BookController;
import com.libraryproject.models.Book;
import com.libraryproject.services.BookService;
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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.*;

@SpringBootTest
class BookControllerTest {

    @Mock
    private BookService bookService;

    @Mock
    private Model model;

    @InjectMocks
    private BookController bookController;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testShowBookList() {
        List<Book> books = new ArrayList<>();
        when(bookService.getAll()).thenReturn(books);

        String viewName = bookController.showBookList(model);

        assertEquals("book", viewName);
        verify(model).addAttribute("books", books);
    }

    @Test
    void testShowAddBookForm() {
        String viewName = bookController.showAddBookForm(model);

        assertEquals("add-book", viewName);
        verify(model).addAttribute(eq("book"), any(Book.class));
    }

    @Test
    void testCreateBook() {
        Book book = new Book();

        String viewName = bookController.createBook(book, model);

        assertEquals("redirect:/book", viewName);
        verify(bookService).create(book);
        verify(model).addAttribute(eq("message"), eq("Book added successfully"));
    }

    @Test
    void testEditBook() {
        Long bookId = 1L;
        Book existingBook = new Book();
        Book updatedBook = new Book();

        when(bookService.get(bookId)).thenReturn(existingBook);
        when(bookService.update(bookId, existingBook)).thenReturn(existingBook);

        ResponseEntity<Book> responseEntity = bookController.editBook(bookId, updatedBook);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertNotNull(responseEntity.getBody());

        verify(bookService).get(bookId);
        verify(bookService).update(bookId, existingBook);
    }

    @Test
    void testEditBookNotFound() {
        Long bookId = 1L;
        Book updatedBook = new Book();

        when(bookService.get(bookId)).thenThrow(new RuntimeException("Book not found"));

        ResponseEntity<Book> responseEntity = bookController.editBook(bookId, updatedBook);

        assertEquals(HttpStatus.NOT_FOUND, responseEntity.getStatusCode());
        assertEquals(null, responseEntity.getBody());

        verify(bookService).get(bookId);
        verifyNoMoreInteractions(bookService);
    }

    @Test
    void testDeleteBook() {
        Long bookId = 1L;

        ResponseEntity<String> responseEntity = bookController.deleteBook(bookId);

        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertEquals("Book deleted successfully", responseEntity.getBody());

        verify(bookService).delete(bookId);
    }

    @Test
    void testDeleteBookException() {
        Long bookId = 1L;

        doThrow(new RuntimeException("Failed to delete book")).when(bookService).delete(bookId);

        ResponseEntity<String> responseEntity = bookController.deleteBook(bookId);

        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, responseEntity.getStatusCode());
        assertEquals("Failed to delete book", responseEntity.getBody());

        verify(bookService).delete(bookId);
    }
}

package com.libraryproject;

import com.libraryproject.models.Book;
import com.libraryproject.services.BookService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
public class LibraryTest {

	@Autowired
	private BookService bookService;

	@Test
	public void testCreateBook() {
		// Arrange
		Book bookToCreate = new Book();
		bookToCreate.setTitle("Test Book");
		bookToCreate.setAuthor("Test Author");
		bookToCreate.setDescription("Test Description");
		bookToCreate.setPublisher("Test Publisher");
		bookToCreate.setIsbn("Test ISBN");
		bookToCreate.setYear(2023);

		// Act
		Book createdBook = bookService.create(bookToCreate);

		// Assert
		assertEquals(bookToCreate.getTitle(), createdBook.getTitle());
		assertEquals(bookToCreate.getAuthor(), createdBook.getAuthor());
		assertEquals(bookToCreate.getDescription(), createdBook.getDescription());
		assertEquals(bookToCreate.getPublisher(), createdBook.getPublisher());
		assertEquals(bookToCreate.getIsbn(), createdBook.getIsbn());
		assertEquals(bookToCreate.getYear(), createdBook.getYear());
		// Add assertions for other properties
	}
}

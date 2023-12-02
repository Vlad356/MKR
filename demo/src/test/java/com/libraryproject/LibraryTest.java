package com.libraryproject;

import com.libraryproject.controllers.BookController;
import com.libraryproject.models.Book;
import com.libraryproject.models.BookIssue;
import com.libraryproject.models.BookIssueRepository;
import com.libraryproject.models.User;
import com.libraryproject.services.BookIssueService;
import com.libraryproject.services.BookService;
import com.libraryproject.services.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.util.List;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;


@SpringBootTest
@AutoConfigureMockMvc
public class LibraryTest {

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private BookIssueRepository bookIssueRepository;

	@Autowired
	private UserService userService;

	@Autowired
	private BookService bookService;

	@Autowired
	private BookIssueService bookIssueService;

	@Test
	public void mainMethodShouldNotThrowException() {
		// Ensure that the main method does not throw any exception
		assertDoesNotThrow(() -> LibraryprojectApplication.main(new String[]{}));
	}

	@Test
	public void testSetAndGetIdUser() {
		// Arrange
		User user = new User();
		Long expectedId = 123L;

		// Act
		user.setId(expectedId);
		Long actualId = user.getId();

		// Assert
		assertEquals(expectedId, actualId);
	}

	@Test
	public void testSetAndGetIdBook() {
		// Arrange
		Book book = new Book();
		Long expectedId = 456L;

		// Act
		book.setId(expectedId);
		Long actualId = book.getId();

		// Assert
		assertEquals(expectedId, actualId);
	}

	@Test
	public void testSetAndGetIdIssue() {
		// Arrange
		BookIssue bookIssue = new BookIssue();
		Long expectedId = 789L;

		// Act
		bookIssue.setId(expectedId);
		Long actualId = bookIssue.getId();

		// Assert
		assertEquals(expectedId, actualId);
	}

	@Test
	public void testUpdateBook() {
		// Arrange
		Book bookToUpdate = new Book();
		bookToUpdate.setTitle("Existing Book");
		bookToUpdate.setAuthor("Existing Author");
		bookToUpdate.setDescription("Existing Description");
		bookToUpdate.setPublisher("Existing Publisher");
		bookToUpdate.setIsbn("Existing ISBN");
		bookToUpdate.setYear(2022);

		Book createdBook = bookService.create(bookToUpdate);

		// Update book details
		bookToUpdate.setTitle("Updated Book Title");
		bookToUpdate.setAuthor("Updated Author");
		bookToUpdate.setDescription("Updated Description");
		bookToUpdate.setPublisher("Updated Publisher");
		bookToUpdate.setIsbn("Updated ISBN");
		bookToUpdate.setYear(2023);

		// Act
		Book updatedBook = bookService.update(createdBook.getId(), bookToUpdate);

		// Assert
		assertEquals(bookToUpdate.getTitle(), updatedBook.getTitle());
		assertEquals(bookToUpdate.getAuthor(), updatedBook.getAuthor());
		assertEquals(bookToUpdate.getDescription(), updatedBook.getDescription());
		assertEquals(bookToUpdate.getPublisher(), updatedBook.getPublisher());
		assertEquals(bookToUpdate.getIsbn(), updatedBook.getIsbn());
		assertEquals(bookToUpdate.getYear(), updatedBook.getYear());
	}

	@Test
	public void testDeleteBook() {
		// Arrange
		Book bookToDelete = new Book();
		bookToDelete.setTitle("Book to Delete");
		bookToDelete.setAuthor("Delete Author");
		bookToDelete.setDescription("Delete Description");
		bookToDelete.setPublisher("Delete Publisher");
		bookToDelete.setIsbn("Delete ISBN");
		bookToDelete.setYear(2021);

		Book createdBook = bookService.create(bookToDelete);

		// Act
		bookService.delete(createdBook.getId());

		// Assert
		assertThrows(RuntimeException.class, () -> bookService.get(createdBook.getId()));
	}

	@Test
	public void testUpdateUser() {
		// Arrange
		User userToUpdate = new User();
		userToUpdate.setFirstName("Existing First Name");
		userToUpdate.setSecondName("Existing Second Name");
		userToUpdate.setThirdName("Existing Third Name");
		userToUpdate.setPhoneNumber("+380987654321");
		userToUpdate.setExpired("No");

		User createdUser = userService.create(userToUpdate);

		// Update user details
		userToUpdate.setFirstName("Updated First Name");
		userToUpdate.setSecondName("Updated Second Name");
		userToUpdate.setThirdName("Updated Third Name");
		userToUpdate.setPhoneNumber("+380123456789");
		userToUpdate.setExpired("Yes");

		// Act
		User updatedUser = userService.update(createdUser.getId(), userToUpdate);

		// Assert
		assertEquals(userToUpdate.getFirstName(), updatedUser.getFirstName());
		assertEquals(userToUpdate.getSecondName(), updatedUser.getSecondName());
		assertEquals(userToUpdate.getThirdName(), updatedUser.getThirdName());
		assertEquals(userToUpdate.getPhoneNumber(), updatedUser.getPhoneNumber());
		assertEquals(userToUpdate.getExpired(), updatedUser.getExpired());
	}

	@Test
	public void testDeleteUser() {
		// Arrange
		User userToDelete = new User();
		userToDelete.setFirstName("User to Delete");
		userToDelete.setSecondName("Delete Second Name");
		userToDelete.setThirdName("Delete Third Name");
		userToDelete.setPhoneNumber("+380111223344");
		userToDelete.setExpired("No");

		User createdUser = userService.create(userToDelete);

		// Act
		userService.delete(createdUser.getId());

		// Assert
		assertThrows(RuntimeException.class, () -> userService.get(createdUser.getId()));
	}

	@Test
	public void testGetAllUsers() {
		// Arrange
		User user1 = new User();
		user1.setFirstName("User1");
		user1.setSecondName("LastName1");
		user1.setThirdName("MiddleName1");
		user1.setPhoneNumber("+380111111111");
		user1.setExpired("No");

		User user2 = new User();
		user2.setFirstName("User2");
		user2.setSecondName("LastName2");
		user2.setThirdName("MiddleName2");
		user2.setPhoneNumber("+380222222222");
		user2.setExpired("Yes");

		userService.create(user1);
		userService.create(user2);

		// Act
		List<User> allUsers = userService.getAllUsers();

		// Assert
		assertTrue(allUsers.stream().anyMatch(u -> u.getFirstName().equals("User1")));
		assertTrue(allUsers.stream().anyMatch(u -> u.getFirstName().equals("User2")));
	}

	@Test
	public void testGetAllBooks() {
		// Arrange
		Book book1 = new Book();
		book1.setTitle("Book1");
		book1.setAuthor("Author1");
		book1.setDescription("Description1");
		book1.setPublisher("Publisher1");
		book1.setIsbn("ISBN1");
		book1.setYear(2020);

		Book book2 = new Book();
		book2.setTitle("Book2");
		book2.setAuthor("Author2");
		book2.setDescription("Description2");
		book2.setPublisher("Publisher2");
		book2.setIsbn("ISBN2");
		book2.setYear(2021);

		bookService.create(book1);
		bookService.create(book2);

		// Act
		List<Book> allBooks = bookService.getAll();

		// Assert
		assertTrue(allBooks.stream().anyMatch(b -> b.getTitle().equals("Book1")));
		assertTrue(allBooks.stream().anyMatch(b -> b.getTitle().equals("Book2")));
	}
	@Test
	public void testCreateBookIssue() {
		// Arrange
		Book book = new Book();
		book.setTitle("Test Book");
		book.setAuthor("Test Author");
		book.setDescription("Test Description");
		book.setPublisher("Test Publisher");
		book.setIsbn("Test ISBN");
		book.setYear(2023);

		User user = new User();
		user.setFirstName("Test Name");
		user.setSecondName("Test Surname");
		user.setThirdName("Test Last Name");
		user.setPhoneNumber("+380123456789");
		user.setExpired("No");

		bookService.create(book);
		userService.create(user);

		BookIssue bookIssueToCreate = new BookIssue();
		bookIssueToCreate.setBook(book);
		bookIssueToCreate.setUser(user);
		bookIssueToCreate.setIssueDate(new Date());
		bookIssueToCreate.setReturnDate(new Date());

		// Act
		BookIssue createdBookIssue = bookIssueService.create(bookIssueToCreate);

		// Assert
		assertNotNull(createdBookIssue);
		assertNotNull(createdBookIssue.getId());
		assertEquals(book.getTitle(), createdBookIssue.getBook().getTitle());
		assertEquals(user.getFirstName(), createdBookIssue.getUser().getFirstName());
		assertNotNull(createdBookIssue.getIssueDate());
		assertNotNull(createdBookIssue.getReturnDate());
	}
	@Test
	public void testDeleteBookIssue() {
		// Arrange
		Book book = new Book();
		book.setTitle("Test Book");
		book.setAuthor("Test Author");
		book.setDescription("Test Description");
		book.setPublisher("Test Publisher");
		book.setIsbn("Test ISBN");
		book.setYear(2023);

		User user = new User();
		user.setFirstName("Test Name");
		user.setSecondName("Test Surname");
		user.setThirdName("Test Last Name");
		user.setPhoneNumber("+380123456789");
		user.setExpired("No");

		bookService.create(book);
		userService.create(user);

		BookIssue bookIssueToCreate = new BookIssue();
		bookIssueToCreate.setBook(book);
		bookIssueToCreate.setUser(user);
		bookIssueToCreate.setIssueDate(new Date());
		bookIssueToCreate.setReturnDate(new Date());

		BookIssue createdBookIssue = bookIssueService.create(bookIssueToCreate);

		// Act
		bookIssueService.delete(createdBookIssue.getId());

		// Assert
		assertThrows(RuntimeException.class, () -> bookIssueService.get(createdBookIssue.getId()));
	}

	@Test
	public void testGetAllIssuesWithDetails() {
		// Arrange
		Book book = new Book();
		book.setTitle("Test Book");
		book.setAuthor("Test Author");
		book.setDescription("Test Description");
		book.setPublisher("Test Publisher");
		book.setIsbn("Test ISBN");
		book.setYear(2023);

		User user = new User();
		user.setFirstName("Test Name");
		user.setSecondName("Test Surname");
		user.setThirdName("Test Last Name");
		user.setPhoneNumber("+380123456789");
		user.setExpired("No");

		bookService.create(book);
		userService.create(user);

		BookIssue bookIssue = new BookIssue();
		bookIssue.setBook(book);
		bookIssue.setUser(user);
		bookIssue.setIssueDate(new Date());
		bookIssue.setReturnDate(new Date());

		bookIssueService.create(bookIssue);

		// Act
		List<BookIssue> issuesWithDetails = bookIssueService.getAllIssuesWithDetails();

		// Assert
		assertNotNull(issuesWithDetails);
		assertFalse(issuesWithDetails.isEmpty());

		// Check if detailed information is fetched
		for (BookIssue issue : issuesWithDetails) {
			assertNotNull(issue.getUser());
			assertNotNull(issue.getBook());
			assertNotNull(issue.getUser().getFirstName());
			assertNotNull(issue.getBook().getTitle());
		}
	}
	@Test
	public void testMainPage() throws Exception {
		mockMvc.perform(MockMvcRequestBuilders.get("/"))
				.andExpect(status().isOk())
				.andExpect(view().name("main"));
	}

	private final BookController bookController = new BookController();

	@Test
	void showAddBookForm() throws Exception {
		mockMvc.perform(get("/add-book"))
				.andExpect(status().isOk())
				.andExpect(view().name("add-book"))
				.andExpect(model().attributeExists("book"));
	}


}

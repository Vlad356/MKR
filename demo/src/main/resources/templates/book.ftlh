<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-image: url('/images/background.jpg');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            flex-direction: column; /* Stack elements vertically */
            align-items: flex-start; /* Align content to the left */
            justify-content: flex-start; /* Align content to the top */
        }

        .toggle-bar {
            padding: 10px; /* Increase padding for wider toggle bar */
            font-size: 24px; /* Increase font size for the toggle bar */
            cursor: pointer;
            color: white;
            background-color: #4CAF50; /* Green background color */
            border: none; /* Remove border */
            border-radius: 0; /* Make the toggle bar square */
            margin: 20px;
            width: 40px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add a subtle box shadow */
        }

        .button-container {
            display: none;
            animation: slide-in 0.5s ease-out; /* Animation for sliding in */
            margin-top: 5px; /* Add margin to separate buttons from toggle bar */
            align-self: flex-start; /* Align to the left */
        }

        .button-container.reverse {
            animation: slide-out 0.5s ease-in reverse; /* Animation for sliding out (reverse) */
        }

        @keyframes slide-in {
            from {
                transform: translateY(-100%); /* Move up initially */
                opacity: 0; /* Start with 0 opacity */
            }
            to {
                transform: translateY(0); /* Move down to normal position */
                opacity: 1; /* End with full opacity */
            }
        }

        @keyframes slide-out {
            from {
                transform: translateY(0); /* Start at normal position */
                opacity: 1; /* Start with full opacity */
            }
            to {
                transform: translateY(-100%); /* Move up to hide */
                opacity: 0; /* End with 0 opacity */
            }
        }

        button {
            padding: 25px; /* Increase padding for bigger buttons */
            font-size: 20px; /* Increase font size for the buttons */
            cursor: pointer;
            margin-left: 20px;
            background-color: #4CAF50; /* Green background color */
            color: white; /* White text color */
            border: 2px solid #4CAF50; /* Add a border */
            border-radius: 0; /* Make the buttons square */
            text-align: center;
            text-decoration: none;
            display: block; /* Make buttons appear in a vertical list */
            width: 200%; /* Make buttons take full width */
            margin-bottom: 0; /* Remove space between buttons */
            transition-duration: 0.4s;
        }

        button:hover {
            background-color: white;
            color: #4CAF50;
            border-color: white; /* Change border color on hover */
        }

        .centered-text {
            font-size: 42px;
            color: lime;
            text-align: center; /* Center the text */
            margin-top: 50px; /* Add some margin from the top */
            align-self: center; /* Center the text horizontally */
            position: absolute; /* Use absolute positioning */
            top: 0%; /* Position at 50% from the top */
            transform: translateY(-50%); /* Adjust to center vertically */
        }

        .tableFixHead {
            overflow-y: auto;
            max-height: 500px; /* Set a maximum height */
            background-color: #f5f5f5;
            position: absolute;
            top: 300px;
            left: 50%;
            transform: translateX(-50%);
            width: 80%;
        }

        .tableFixHead thead th {
            position: sticky;
            top: 0;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            white-space: normal; /* Allow text to wrap */
            word-wrap: break-word; /* Break word when it exceeds the width */
            max-width: 300px; /* Set your desired maximum width */
            overflow: hidden;
            text-overflow: ellipsis;
        }

        th {
            background-color: #333;
            color: white;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .add-book-button {
            position: absolute;
            bottom: 50px;
            left: 168px;
            width: 200px;
            height: 50px;
            padding: 10px;
            font-size: 18px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: 2px solid #4CAF50;
            border-radius: 0;
            text-align: center;
            text-decoration: none;
            display: block;
        }

        .add-book-button:hover {
            background-color: white;
            color: #4CAF50;
            border-color: white;
        }

        .issue-button {
            position: absolute;
            bottom: 50px;
            left: 400px;
            width: 200px;
            height: 50px;
            padding: 10px;
            font-size: 18px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: 2px solid #4CAF50;
            border-radius: 0;
            text-align: center;
            text-decoration: none;
            display: block;
        }

        .issue-button:hover {
            background-color: white;
            color: #4CAF50;
            border-color: white;
        }

        .edit-button, .delete-button {
            padding: 10px; /* Adjust padding for buttons */
            font-size: 18px; /* Adjust font size for buttons */
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: 2px solid #4CAF50;
            border-radius: 0;
            text-align: center;
            text-decoration: none;
            display: block;
            width: 100%; /* Take up the full width of the cell */
            margin: 5px auto; /* Center buttons vertically within the cell */
            transition-duration: 0.4s;
        }

        .edit-button:hover, .delete-button:hover {
            background-color: white;
            color: #4CAF50;
            border-color: white;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Adjust the width of the form */
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-size: 16px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button-edit {
            padding: 10px;
            font-size: 18px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: 2px solid #4CAF50;
            border-radius: 4px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            width: auto; /* Adjust the width as needed */
            margin-right: 10px;
            transition-duration: 0.4s;
            display: inline-block; /* Display the buttons in line */
            margin-right: 10px; /* Add some margin between the buttons */
        }

        button-edit:hover {
            background-color: white;
            color: #4CAF50;
            border-color: white;
        }

        .cancel-button {
            padding: 10px;
            font-size: 18px;
            cursor: pointer;
            background-color: #ccc; /* Use a different background color for the Cancel button */
            color: black; /* Use a different text color for the Cancel button */
            border: 2px solid #ccc; /* Use a different border color for the Cancel button */
            border-radius: 4px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            width: auto; /* Adjust the width as needed */
        }

        .cancel-button:hover {
            background-color: white;
            color: #ccc;
            border-color: white;
        }

        #searchInput {
            padding: 10px;
            font-size: 16px;
            margin: 20px;
            border: 2px solid #4CAF50;
            border-radius: 5px;
            width: 300px;
            box-sizing: border-box;
            background-color: white;
            color: #4CAF50;
            position: absolute;
            top: 200px;
            right: 165px;
        }

        /* Style for the search input placeholder */
        #searchInput::placeholder {
            color: #4CAF50;
            opacity: 0.7;
        }

        /* Style for the search input on focus */
        #searchInput:focus {
            outline: none;
            border-color: #45a049;
            box-shadow: 0 0 5px rgba(0, 128, 0, 0.5);
        }
  </style>
</head>
<body>
<div class="toggle-bar" onclick="toggleButtons()">=</div>
<div class="button-container">
    <button onclick="window.location.href='/'">Main Page</button>
    <button onclick="window.location.href='/user'">Users</button>
</div>
<div class="centered-text">Book List</div>
    <div class="tableFixHead">
        <table border="1">
        <thead>
        <tr>
            <th>Title</th>
            <th>Author</th>
            <th>Description</th>
            <th>Publisher</th>
            <th>ISBN</th>
            <th>Year</th>
            <th>Edit</th>
            <th>Delete</th>
        </tr>
        </thead>
        <tbody>
        <#list books as book>
            <tr>
                <td>${book.title}</td>
                <td>${book.author}</td>
                <td>${book.description}</td>
                <td>${book.publisher}</td>
                <td>${book.isbn}</td>
                <td>${book.year}</td>
                <td><button class="edit-button" data-id="${book.id}" data-title="${book.title}" data-author="${book.author}" data-description="${book.description}" data-publisher="${book.publisher}" data-isbn="${book.isbn}" data-year="${book.year}" onclick="openEditModal(this)">Edit</button></td>
                <td><button class="delete-button" onclick="prepareAndDeleteBook('${book.id}')">Delete</button></td>
            </tr>
        </#list>
        </tbody>
        </table>
    </div>
<div id="editModal" class="modal">
    <div class="modal-content">

        <label for="editTitle">Title:</label>
        <input type="text" id="editTitle" name="editTitle">

        <label for="editAuthor">Author:</label>
        <input type="text" id="editAuthor" name="editAuthor">

        <label for="editDescription">Description:</label>
        <input type="text" id="editDescription" name="editDescription">

        <label for="editPublisher">Publisher:</label>
        <input type="text" id="editPublisher" name="editPublisher">

        <label for="editISBN">ISBN:</label>
        <input type="text" id="editISBN" name="editISBN">

        <label for="editYear">Year:</label>
        <input type="number" id="editYear" name="editYear">


        <input type="hidden" id="editedBookId" name="editedBookId">

        <button-edit onclick="saveEditedBook()">Save Changes</button-edit>
        <button class="cancel-button" onclick="hideEditModal()">Cancel</button>
    </div>
</div>
<button class="add-book-button" onclick="window.location.href='/add-book'">Add New Book</button>
<button class="issue-button" onclick="window.location.href='/issue'">Issues</button>
<input type="text" id="searchInput" oninput="filterBooks()" placeholder="Search by title...">
<script>
    function toggleButtons() {
        var buttonContainer = document.querySelector('.button-container');
        buttonContainer.classList.toggle('reverse'); /* Toggle the reverse class for the disappearing effect */
        buttonContainer.style.display = (buttonContainer.style.display === 'none' || buttonContainer.style.display === '') ? 'block' : 'none';
    }

    function prepareAndDeleteBook(bookId) {
        // Replace &nbsp; with an empty string in the book ID
        var cleanedBookId = bookId.replace(/&nbsp;/g, '');

        // Remove non-numeric characters from the book ID
        var numericBookId = cleanedBookId.replace(/\D/g, '');

        deleteBook(numericBookId);
    }

    function deleteBook(bookId) {
        // Replace &nbsp; with an empty string in the book ID
        var cleanedBookId = bookId.replace(/&nbsp;/g, '');

        // Remove non-numeric characters from the book ID
        var numericBookId = cleanedBookId.replace(/\D/g, '');

        var confirmation = confirm("Are you sure you want to delete this book?");

        if (confirmation) {
            fetch('/book/' + encodeURIComponent(numericBookId), {
                method: 'DELETE',
            })
        .then(response => {
            if (response.ok) {
                alert("Book deleted successfully");
                location.reload(); // Reload the page after successful deletion
            }
            else {
                alert("Failed to delete book");
            }
        })
        .catch(error => {
            console.error('Error deleting book:', error);
            alert("An error occurred while deleting the book");
        });
        }
    }

    function openEditModal(button) {
        var bookId = button.getAttribute('data-id').replace(/\s/g, '');
        var title = button.getAttribute('data-title');
        var author = button.getAttribute('data-author');
        var description = button.getAttribute('data-description');
        var publisher = button.getAttribute('data-publisher');
        var isbn = button.getAttribute('data-isbn');
        var year = button.getAttribute('data-year');

        document.getElementById('editTitle').value = title;
        document.getElementById('editAuthor').value = author;
        document.getElementById('editDescription').value = description;
        document.getElementById('editPublisher').value = publisher;
        document.getElementById('editISBN').value = isbn;
        document.getElementById('editYear').value = year;
        document.getElementById('editedBookId').value = bookId;

        showEditModal();
    }

    function showEditModal() {
        var editModal = document.getElementById('editModal');
        editModal.style.display = 'block';
    }

    function hideEditModal() {
        var editModal = document.getElementById('editModal');
        editModal.style.display = 'none';
    }

    function saveEditedBook() {
        const editedBookId = document.getElementById('editedBookId').value;
        const editedTitle = document.getElementById('editTitle').value;
        const editedAuthor = document.getElementById('editAuthor').value;
        const editedDescription = document.getElementById('editDescription').value;
        const editedPublisher = document.getElementById('editPublisher').value;
        const editedISBN = document.getElementById('editISBN').value;
        const editedYear = document.getElementById('editYear').value;

        if (!editedTitle || !editedAuthor || !editedPublisher || !editedISBN || !editedYear) {
            alert("Please fill in all required fields.");
            return;
        }
        const isbnPattern = /^(?:\d{3}-\d{1,5}-\d{1,7}-\d{1,7}-\d|\d{13})$/;

        if (!isbnPattern.test(editedISBN)) {
            alert("Please enter a valid ISBN.");
            return;
        }

        fetch('/book/' + editedBookId, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },

            body: JSON.stringify({
                title: editedTitle,
                author: editedAuthor,
                description: editedDescription,
                publisher: editedPublisher,
                isbn: editedISBN,
                year: editedYear,
            }),
        })
        .then(response => {
            if (response.ok) {
                alert("Book edited successfully");
                hideEditModal();
                location.reload();
            }
            else {
                alert("Failed to edit book");
            }
        })
        .catch(error => {
            console.error('Error editing book:', error);
            alert("An error occurred while editing the book");
        });
    }

    function filterBooks() {
        var searchInput = document.getElementById('searchInput');
        var filter = searchInput.value.toUpperCase();
        var table = document.querySelector('table');
        var rows = table.querySelectorAll('tbody tr');

        rows.forEach(function (row) {
            var titleColumn = row.getElementsByTagName('td')[0]; // Assuming title is the second column
            if (titleColumn) {
                var titleText = titleColumn.textContent || titleColumn.innerText;
                if (titleText.toUpperCase().indexOf(filter) > -1) {
                    row.style.display = '';
                }
                else {
                    row.style.display = 'none';
                }
            }
        });
    }
</script>
</body>
</html>

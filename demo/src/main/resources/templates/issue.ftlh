<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Issued Books</title>
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
            max-height: 450px; /* Set a maximum height */
            background-color: #f5f5f5;
            position: absolute;
            top: 350px;
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

        .add-issue-button {
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

        .add-issue-button:hover {
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

        .select-style {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
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

        .return-button {
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

        .return-button:hover, .delete-button:hover {
            background-color: white;
            color: #4CAF50;
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
<script src="https://www.kryogenix.org/code/browser/sorttable/sorttable.js"></script>
<div class="toggle-bar" onclick="toggleButtons()">=</div>
<div class="button-container">
    <button onclick="window.location.href='/'">Main Page</button>
    <button onclick="window.location.href='/user'">Users</button>
    <button onclick="window.location.href='/book'">Books</button>
</div>
<div class="centered-text">Issued Books</div>
<div class="tableFixHead">
    <table>
        <thead>
        <tr>
            <th class="sorttable_nosort">User Info</th>
            <th class="sorttable_nosort">Book Info</th>
            <th class="sorttable_numeric">Issue Date</th>
            <th class="sorttable_nosort">Return Date</th>
            <th class="sorttable_nosort">Return</th>
        </tr>
        </thead>
        <tbody>
        <#if issuedBooks??>
        <#list issuedBooks as bookIssue>
        <tr>
            <td>${bookIssue.user.firstName}, ${bookIssue.user.secondName}, ${bookIssue.user.thirdName}, ${bookIssue.user.phoneNumber}, ${bookIssue.user.expired}</td>
            <td>${bookIssue.book.title}, ${bookIssue.book.author}, ${bookIssue.book.description}, ${bookIssue.book.publisher}, ${bookIssue.book.isbn}, ${bookIssue.book.year}</td>
            <td>${bookIssue.issueDate?string("yyyy-MM-dd HH:mm:ss")}</td>
            <td>${bookIssue.returnDate?string("yyyy-MM-dd HH:mm:ss")}</td>
            <td><button class="delete-button" onclick="prepareAndReturnIssue('${bookIssue.id}')">Return</button></td>
        </tr>
        </#list>
        <#else>
        <tr>
        </tr>
        </#if>
    </tbody>
    </table>
</div>

<button class="add-issue-button" onclick="window.location.href='/add-issue'">Add New Issue</button>
<input type="text" id="searchInput" oninput="filterUsers()" placeholder="Search by first name...">

<script>
    document.addEventListener('DOMContentLoaded', function () {
       makeTableSortable();
    });

    function prepareAndReturnIssue(bookIssueId) {
        // Replace &nbsp; with an empty string in the book ID
        var cleanedBookIssueId = bookIssueId.replace(/&nbsp;/g, '');

        // Remove non-numeric characters from the book ID
        var numericBookIssueId = cleanedBookIssueId.replace(/\D/g, '');

        deleteBookIssue(numericBookIssueId);
    }

    function deleteBookIssue(bookIssueId) {
        var confirmation = confirm("Are you sure you want to delete this issue?");

        if (confirmation) {
            fetch('/issue/' + bookIssueId, {
                method: 'DELETE',
            })

            .then(response => {
                if (response.ok) {
                    alert("Issue deleted successfully");
                    location.reload();
                }
                else {
                    alert("Failed to delete issue");
                }
            })

            .catch(error => {
                console.error('Error deleting user:', error);
                alert("An error occurred while deleting the issue");
            });
        }
    }

    function makeTableSortable() {
        const table = document.querySelector('table');
        const tbody = table.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr'));

        const sortRows = () => {
            const sortedRows = rows.sort((a, b) => {
                const dateA = new Date(a.cells[2].textContent);
                const dateB = new Date(b.cells[2].textContent);
                return dateA - dateB;
            });

           tbody.innerHTML = '';
           sortedRows.forEach(row => tbody.appendChild(row));
        };

        table.querySelector('th:nth-child(3)').addEventListener('click', sortRows);
    }

    function toggleButtons() {
        var buttonContainer = document.querySelector('.button-container');
        buttonContainer.classList.toggle('reverse');
        buttonContainer.style.display = (buttonContainer.style.display === 'none' || buttonContainer.style.display === '') ? 'block' : 'none';
    }

    function filterUsers() {
        var searchInput = document.getElementById('searchInput');
        var filter = searchInput.value.toUpperCase();
        var table = document.querySelector('table');
        var rows = table.querySelectorAll('tbody tr');

        rows.forEach(function (row) {
            var Column = row.getElementsByTagName('td')[0]; // Assuming the first column
            if (Column) {
                var Text = Column.textContent || Column.innerText;
                if (Text.toUpperCase().indexOf(filter) > -1) {
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

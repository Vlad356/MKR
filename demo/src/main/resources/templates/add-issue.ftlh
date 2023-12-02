<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Issue</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px; /* Adjusted width */
            margin: auto; /* Center the form */
        }

        h2 {
            text-align: center;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        select,
        input,
        button {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            background-color: #4CAF50;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<form action="/issue" method="post">
    <h2>Add New Issue</h2>
    <label for="user">User:</label>
    <select id="user" name="user">
        <#list users as user>
        <option data-id="${user.id}" value="${user.id}">
            ${user.firstName?default('Unknown User')} ${user.secondName?default('')} ${user.thirdName?default('')} (${user.phoneNumber?default('')})
        </option>
    </#list>
    </select>
    <label for="book">Book:</label>
    <select id="book" name="book">
        <#list books as book>
        <option data-id="${book.id}" value="${book.id}">
            ${book.title?default('Unknown Book')} by ${book.author?default('Unknown Author')}, Publisher: ${book.publisher?default('Unknown Publisher')}, ISBN: ${book.isbn?default('Unknown ISBN')}, Year: ${book.year?default('Unknown Year')}
        </option>
    </#list>
    </select>
    <button type="submit">Add Book Issue</button>
</form>
<script>
    document.addEventListener('DOMContentLoaded', function (){
        // Get the form element
        var form = document.querySelector('form');

        // Add a submit event listener to the form
        form.addEventListener('submit', function (event){
            // Get the user and book select elements
            var userSelect = document.getElementById('user');
            var bookSelect = document.getElementById('book');

            // Process user and book values before submission
            processSelectValues(userSelect);
            processSelectValues(bookSelect);
        });

        // Function to process select values
        function processSelectValues(selectElement) {
            // Loop through options
            for (var i = 0; i < selectElement.options.length; i++) {
                var option = selectElement.options[i];
                // Replace non-breaking spaces with regular spaces in the option value
                option.value = option.value.replace(/\s/g, ' ');
            }
        }
    });
</script>
</body>
</html>

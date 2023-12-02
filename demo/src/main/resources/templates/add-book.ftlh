<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Book</title>
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
            width: 300px;
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

        input, textarea, button {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
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
    <form action="/book" method="post">
        <h2>Add New Book</h2>
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" min="0" maxlength="255" title= required>

        <label for="author">Author:</label>
        <input type="text" id="author" name="author" maxlength="255" required>

        <label for="description">Description:</label>
        <textarea id="description" name="description" maxlength="255"></textarea>

        <label for="publisher">Publisher:</label>
        <input type="text" id="publisher" name="publisher" maxlength="255" required>

        <label for="isbn">ISBN:</label>
        <input type="text" id="isbn" name="isbn" placeholder="978-0-545-01022-1" pattern="(?:\d{3}-\d{1,5}-\d{1,7}-\d{1,7}-\d| \d{13})" title="Enter a valid ISBN" required>

        <label for="year">Year:</label>
        <input type="number" id="year" name="year" min="0" max="2023" required>

        <button type="submit">Add Book</button>
    </form>
</body>
</html>

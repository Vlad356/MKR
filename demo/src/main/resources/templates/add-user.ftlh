<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New User</title>
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

        input,
        textarea,
        button {
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

        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        select:hover {
            border-color: #888;
        }
    </style>
</head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/css/intlTelInput.min.css">
<body>
    <form action="/user" method="post">
        <h2>Add New User</h2>
        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" pattern="[A-Za-zА-ЯЁа-яёҐґІіЇїЄє]+" maxlength="255" title="Please enter only letters" required>

        <label for="secondName">Second Name:</label>
        <input type="text" id="secondName" name="secondName" pattern="[A-Za-zА-ЯЁа-яёҐґІіЇїЄє]+" maxlength="255" title="Please enter only letters" required>

        <label for="thirdName">Third Name:</label>
        <input type="text" id="thirdName" name="thirdName" pattern="[A-Za-zА-ЯЁа-яёҐґІіЇїЄє]+" maxlength="255" title="Please enter only letters" required>

        <label for="phoneNumber">Phone Number:</label>
        <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="+380123456789" pattern="\+[0-9]{12}" title="Please enter a phone number in the format +380123456789" required>

        <label for="expired">Expired:</label>
        <select id="expired" name="expired" required>
            <option value="Yes">Yes</option>
            <option value="No">No</option>
        </select>
        <button type="submit">Add User</button>
    </form>
</body>
</html>

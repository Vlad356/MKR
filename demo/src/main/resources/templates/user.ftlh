<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Users</title>
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
      padding: 15px; /* Increase padding for wider toggle bar */
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
      margin-top: 10px; /* Add margin to separate buttons from toggle bar */
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
}

th {
  background-color: #333;
  color: white;
}

tr:hover {
  background-color: #f5f5f5;
}

  </style>
</head>

<body>
  <div class="toggle-bar" onclick="toggleButtons()">=</div>
  <div class="button-container">
    <button onclick="window.location.href='/'">Main Page</button>
    <button onclick="window.location.href='/book'">Books</button>
  </div>

  <div class="centered-text">
    User List
  </div>
  <div class="tableFixHead">
    <table border="1">
      <thead>
        <tr>
          <th>ID</th>
          <th>First Name</th>
          <th>Second Name</th>
          <th>Third Name</th>
          <th>Phone number</th>
          <th>Expired</th>
        </tr>
      </thead>
      <tbody>
        <#list users as user>
                      <tr>
                          <td>${user.id}</td>
                          <td>${user.fistName}</td>
                          <td>${user.secondName}</td>
                          <td>${user.thirdName}</td>
                          <td>${user.phoneNumber}</td>
                          <td>${user.expired}</td>
                      </tr>
                  </#list>
      </tbody>
    </table>
  </div>
  <script>
    function toggleButtons() {
      var buttonContainer = document.querySelector('.button-container');
      buttonContainer.classList.toggle('reverse'); /* Toggle the reverse class for the disappearing effect */
      buttonContainer.style.display = (buttonContainer.style.display === 'none' || buttonContainer.style.display === '') ? 'block' : 'none';
    }
  </script>
</body>

</html>

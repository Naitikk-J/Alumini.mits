# Create project directory
$PROJECT_DIR = "my-login-app"
New-Item -ItemType Directory -Path $PROJECT_DIR
Set-Location $PROJECT_DIR

# Create public directory and subdirectories
New-Item -ItemType Directory -Path "public"
New-Item -ItemType Directory -Path "public/css"
New-Item -ItemType Directory -Path "public/js"

# Create index.html
@"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form id="loginForm">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
    <script src="js/main.js"></script>
</body>
</html>
"@ | Out-File -FilePath "public/index.html"

# Create styles.css
@"
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.login-container {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
}

h2 {
    text-align: center;
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 15px;
}

label {
    display: block;
    margin-bottom: 5px;
}

input[type="email"],
input[type="password"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button {
    width: 100%;
    padding: 10px;
    background-color: #28a745;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background-color: #218838;
}
"@ | Out-File -FilePath "public/css/styles.css"

# Create main.js
@"
document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault();
    
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    fetch('/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ email, password })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Login successful!');
            // Redirect or perform other actions
        } else {
            alert('Login failed: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
});
"@ | Out-File -FilePath "public/js/main.js"

# Create server.js
@"
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(express.static('public'));

app.post('/login', (req, res) => {
    const { email, password } = req.body;

    // Dummy check for demonstration purposes
    if (email === 'user@example.com' && password === 'password') {
        res.json({ success: true });
    } else {
        res.json({ success: false, message: 'Invalid credentials' });
    }
});

app.listen(port, () => {
    console.log(\`Server running at http://localhost:\${port}\`);
});
"@ | Out-File -FilePath "server.js"

# Create package.json
@"
{
  "name": "my-login-app",
  "version": "1.0.0",
  "description": "A simple login interface",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.17.1",
    "body-parser": "^1.19.0"
  }
}
"@ | Out-File -FilePath "package.json"

# Install dependencies
Write-Host "Installing dependencies..."
npm install

# Start the server
Write-Host "Starting the server..."
npm start
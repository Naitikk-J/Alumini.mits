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
    console.log(`Server running at http://localhost:${port}`);
});
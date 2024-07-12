const app = require('./app');
const { connect } = require('./database');

async function main() {
    try {
        // Database connection
        await connect();

        // App connection
        await app.listen(4000);
        console.log('Server on port 4000: Connected');
    } catch (error) {
        console.error('Error starting the server:', error);
    }
}

main();
